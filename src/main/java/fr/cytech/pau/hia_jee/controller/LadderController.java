package fr.cytech.pau.hia_jee.controller;

import fr.cytech.pau.hia_jee.model.Game;
import fr.cytech.pau.hia_jee.model.Team;
import fr.cytech.pau.hia_jee.repository.TeamRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class LadderController {

    @Autowired
    private TeamRepository teamRepository;

    /**
     * Gère la requête pour voir le classement global, filtré par jeu.
     */
    @GetMapping("/ladder")
    public String showLadder(@RequestParam(required = false) Game game, Model model) {

        // Si aucun jeu n'est sélectionné dans l'URL, on affiche CSGO par défaut
        if (game == null) {
            game = Game.CSGO;
        }

        // 1. Récupération des équipes filtrées par le jeu sélectionné ET triées par ELO
        List<Team> teams = teamRepository.findByGameOrderByEloDesc(game);

        // 2. Transmission des données à la vue
        model.addAttribute("teams", teams);
        model.addAttribute("games", Game.values()); // Pour générer les onglets (tabs)
        model.addAttribute("selectedGame", game);   // Pour surligner l'onglet actif

        return "ladder";
    }
}