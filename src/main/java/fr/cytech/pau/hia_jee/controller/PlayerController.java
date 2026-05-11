package fr.cytech.pau.hia_jee.controller;

import fr.cytech.pau.hia_jee.model.User;
import fr.cytech.pau.hia_jee.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class PlayerController {

    @Autowired
    private UserRepository userRepository;

    // Ruta pública para ver el perfil de cualquier jugador por su ID
    @GetMapping("/players/{id}")
    public String showPlayerProfile(@PathVariable Long id, Model model) {
        User player = userRepository.findById(id).orElse(null);

        if (player == null) {
            return "redirect:/"; // Si el ID no existe, regresamos al inicio
        }

        model.addAttribute("player", player);
        return "users/profile"; // Llamará a la nueva vista HTML
    }
}