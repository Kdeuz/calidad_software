package fr.cytech.pau.hia_jee.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import fr.cytech.pau.hia_jee.model.*;
import fr.cytech.pau.hia_jee.repository.UserRepository;
import fr.cytech.pau.hia_jee.repository.TeamRepository; // <-- AÑADIDO
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import fr.cytech.pau.hia_jee.repository.MatchRepository;
import fr.cytech.pau.hia_jee.repository.TournamentRepository;

@Service
public class TournamentService {

    private final TournamentRepository tRepo;
    private final MatchRepository mRepo;

    @Autowired
    private AchievementService achievementService;

    @Autowired
    private UserRepository userRepository;

    // 🔥 AÑADIDO: Inyección del TeamRepository para que no marque error
    @Autowired
    private TeamRepository teamRepository;

    public TournamentService(TournamentRepository tRepo, MatchRepository mRepo) {
        this.tRepo = tRepo;
        this.mRepo = mRepo;
    }

    // ============================================================
    // GÉNÉRATION DE L'ARBRE
    // ============================================================

    @Transactional
    public void generateBracket(Long tournamentId) {
        Tournament tournament = tRepo.findById(tournamentId)
                .orElseThrow(() -> new RuntimeException("Tournoi introuvable"));

        if (tournament.getMatches() != null) {
            mRepo.deleteAll(tournament.getMatches());
            tournament.getMatches().clear();
        }

        List<Team> rankedTeams = new ArrayList<>(tournament.getTeams());
        int n = rankedTeams.size();
        if (n < 2) throw new RuntimeException("Il faut au moins 2 équipes !");

        int pBis = Integer.highestOneBit(n);
        if (n == pBis * 2) pBis = n;

        int m = n - pBis;
        int nbDirectQualified = pBis - m;

        // ÉTAPE A : BARRAGES
        List<Match> barrageMatches = new ArrayList<>();
        if (m > 0) {
            List<Team> barragistes = rankedTeams.subList(nbDirectQualified, n);
            for (int i = 0; i < m; i++) {
                Team teamStrong = barragistes.get(i);
                Team teamWeak = barragistes.get(barragistes.size() - 1 - i);

                Match match = new Match();
                match.setTournament(tournament);
                match.setRound(1);
                match.setTeamA(teamStrong);
                match.setTeamB(teamWeak);

                match = mRepo.save(match);
                barrageMatches.add(match);
            }
        }

        // ÉTAPE B : ROUND SUIVANT
        List<Object> round2Slots = new ArrayList<>();
        for (int i = 0; i < nbDirectQualified; i++) {
            round2Slots.add(rankedTeams.get(i));
        }
        round2Slots.addAll(barrageMatches);

        // ÉTAPE C : RÉCURSION
        int currentRoundNumber = (m > 0) ? 2 : 1;
        List<Match> currentRoundMatches = generateRoundMatches(tournament, currentRoundNumber, round2Slots);

        while (currentRoundMatches.size() > 1) {
            currentRoundNumber++;
            List<Object> winnersSlots = new ArrayList<>(currentRoundMatches);
            currentRoundMatches = generateRoundMatches(tournament, currentRoundNumber, winnersSlots);
        }

        tournament.setStatus(StatusTournament.EN_COURS);
        tRepo.save(tournament);
    }

    private List<Match> generateRoundMatches(Tournament tournament, int roundVal, List<Object> entrants) {
        List<Match> createdMatches = new ArrayList<>();
        int size = entrants.size();

        for (int i = 0; i < size / 2; i++) {
            Object entrantTop = entrants.get(i);
            Object entrantBottom = entrants.get(size - 1 - i);

            Match match = new Match();
            match.setTournament(tournament);
            match.setRound(roundVal);

            if (entrantTop instanceof Team) match.setTeamA((Team) entrantTop);
            else if (entrantTop instanceof Match) {
                Match prev = (Match) entrantTop;
                prev.setNextMatch(match);
                mRepo.save(prev);
            }

            if (entrantBottom instanceof Team) match.setTeamB((Team) entrantBottom);
            else if (entrantBottom instanceof Match) {
                Match prev = (Match) entrantBottom;
                prev.setNextMatch(match);
                mRepo.save(prev);
            }

            match = mRepo.save(match);
            createdMatches.add(match);
        }
        return createdMatches;
    }

    // ============================================================
    // GESTION DES SCORES (LOGIQUE MÉTIER)
    // ============================================================

    @Transactional
    public void enterScore(Long matchId, int scoreA, int scoreB) {
        Match match = mRepo.findById(matchId)
                .orElseThrow(() -> new RuntimeException("Match introuvable"));

        if (match.getTeamA() == null || match.getTeamB() == null) {
            throw new RuntimeException("Le match n'est pas prêt (il manque une équipe).");
        }

        if (scoreA == scoreB) {
            throw new RuntimeException("Match nul interdit dans un arbre ! Il faut un vainqueur.");
        }

        // Se guarda el score
        match.setScoreA(scoreA);
        match.setScoreB(scoreB);

        // Se define el ganador
        Team winnerTeam = (scoreA > scoreB) ? match.getTeamA() : match.getTeamB();
        Team loserTeam = (scoreA > scoreB) ? match.getTeamB() : match.getTeamA();

        match.setWinner(winnerTeam);
        mRepo.save(match);

        // 🔥 1. ACTUALIZAR ESTADÍSTICAS DEL EQUIPO (Ya no marca error)
        winnerTeam.setWins(winnerTeam.getWins() + 1);
        loserTeam.setLosses(loserTeam.getLosses() + 1);
        teamRepository.save(winnerTeam);
        teamRepository.save(loserTeam);

        // 🔥 2. LOGROS Y STATS PARA TODO EL EQUIPO GANADOR
        if (winnerTeam.getMembers() != null) {
            for (User member : winnerTeam.getMembers()) {
                member.setWins(member.getWins() + 1);
                achievementService.unlockAchievement(member, "Primer victoria");
                userRepository.save(member);
            }
        }

        // 🔥 3. STATS PARA EL EQUIPO PERDEDOR
        if (loserTeam.getMembers() != null) {
            for (User member : loserTeam.getMembers()) {
                member.setLosses(member.getLosses() + 1);
                userRepository.save(member);
            }
        }

        // Propagation au match suivant
        Match nextMatch = match.getNextMatch();

        if (nextMatch != null) {
            Team currentA = nextMatch.getTeamA();

            // Si A est vide OU si c'est déjà nous (update) -> on va en A
            // Sinon -> on va en B
            boolean slotAAvailableOrOurs = (currentA == null) || isTeamFromThisMatch(currentA, match);

            if (slotAAvailableOrOurs) nextMatch.setTeamA(winnerTeam);
            else nextMatch.setTeamB(winnerTeam);

            mRepo.save(nextMatch);

        } else {
            // FINALE
            Tournament tournament = match.getTournament();
            tournament.setStatus(StatusTournament.TERMINE);
            tRepo.save(tournament);

            //Sumar 1 torneo ganado al equipo
            winnerTeam.setTournamentWins(winnerTeam.getTournamentWins() + 1);
            teamRepository.save(winnerTeam);

            //Sumar 1 torneo ganado a cada jugador y dar medalla
            if (winnerTeam.getMembers() != null) {
                for (User champion : winnerTeam.getMembers()) {
                    champion.setTournamentWins(champion.getTournamentWins() + 1); // Sumar torneo
                    achievementService.unlockAchievement(champion, "Campeón");
                    userRepository.save(champion);
                }
            }
        }
    }

    // Méthode utilitaire interne
    private boolean isTeamFromThisMatch(Team teamInNext, Match currentMatch) {
        if (teamInNext == null) return false;
        return teamInNext.equals(currentMatch.getTeamA()) || teamInNext.equals(currentMatch.getTeamB());
    }

    // Méthode helper pour le contrôleur
    public Long findTournamentIdByMatchId(Long matchId) {
        return mRepo.findById(matchId)
                .map(match -> match.getTournament().getId())
                .orElseThrow(() -> new RuntimeException("Match introuvable"));
    }

    // Méthodes standard
    public List<Tournament> findAll() { return tRepo.findAll(); }
    public Optional<Tournament> findById(Long id) { return tRepo.findById(id); }
    public void save(Tournament t) { tRepo.save(t); }
}