package fr.cytech.pau.hia_jee.controller;

import fr.cytech.pau.hia_jee.model.Team;
import fr.cytech.pau.hia_jee.repository.TeamRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

/**
 * Contrôleur gérant l'affichage de la page du classement (Ladder).
 * En la Fase 3, este controlador ahora recupera los datos reales de ELO.
 */
@Controller
public class LadderController {

    @Autowired
    private TeamRepository teamRepository;

    /**
     * Gère la requête pour voir le classement global.
     * Les équipes son triées par ELO décroissant (le plus haut en premier).
     */
    @GetMapping("/ladder")
    public String showLadder(Model model) {
        // 1. Recuperamos todos los equipos ordenados por ELO (Descendente)
        // Esto asegura que el "Top 1" aparezca al principio de la lista.
        List<Team> teams = teamRepository.findAll(Sort.by(Sort.Direction.DESC, "elo"));

        // 2. Pasamos la lista a la vista Thymeleaf bajo el nombre "teams"
        model.addAttribute("teams", teams);

        // 3. Devolvemos la vista ladder.html
        return "ladder";
    }
}