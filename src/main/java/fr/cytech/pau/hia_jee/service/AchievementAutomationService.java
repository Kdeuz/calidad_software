package fr.cytech.pau.hia_jee.service;

import fr.cytech.pau.hia_jee.model.Achievement;
import fr.cytech.pau.hia_jee.model.User;
import fr.cytech.pau.hia_jee.repository.AchievementRepository;
import fr.cytech.pau.hia_jee.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class AchievementAutomationService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private AchievementRepository achievementRepository;

    /**
     * 🔥 AUTOMATIZACIÓN CORE 🔥
     * @Scheduled(fixedRate = 60000) hace que este método se ejecute solo,
     * automáticamente, cada 60,000 milisegundos (1 minuto), sin que nadie haga clic en nada.
     */
    @Scheduled(fixedRate = 60000)
    @Transactional
    public void autoAssignAchievements() {
        System.out.println("[AUTOMATIZACIÓN] Iniciando el bot de inspección de logros...");
        List<User> users = userRepository.findAll();

        // El robot saca las medallas de la vitrina (Base de datos)
        Achievement firstWin = achievementRepository.findByName("Primer victoria").orElse(null);
        Achievement winStreak = achievementRepository.findByName("5 victorias seguidas").orElse(null);
        Achievement champion = achievementRepository.findByName("Campeón").orElse(null);

        // Si por alguna razón la base de datos está vacía, el robot se apaga por seguridad
        if (firstWin == null || winStreak == null || champion == null) return;

        int awardsGiven = 0;

        // El robot escanea a TODOS los jugadores de la plataforma
        for (User user : users) {

            // Regla 1: Tiene 1 victoria y NO tiene la medalla
            if (user.getWins() >= 1 && !user.getAchievements().contains(firstWin)) {
                user.getAchievements().add(firstWin);
                awardsGiven++;
            }

            // Regla 2: Tiene 5 victorias y NO tiene la medalla
            if (user.getWins() >= 5 && !user.getAchievements().contains(winStreak)) {
                user.getAchievements().add(winStreak);
                awardsGiven++;
            }

            // Regla 3: Ganó un torneo y NO tiene la medalla
            if (user.getTournamentWins() >= 1 && !user.getAchievements().contains(champion)) {
                user.getAchievements().add(champion);
                awardsGiven++;
            }
        }

        // Si el robot repartió premios, guarda los cambios y avisa en la consola
        if (awardsGiven > 0) {
            userRepository.saveAll(users);
            System.out.println("[AUTOMATIZACIÓN] ¡Éxito! " + awardsGiven + " nuevas insignias distribuidas automáticamente.");
        } else {
            System.out.println("[AUTOMATIZACIÓN] Escaneo terminado. Ningún logro nuevo por distribuir.");
        }
    }
}