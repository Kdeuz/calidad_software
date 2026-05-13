package fr.cytech.pau.hia_jee.controller;

import fr.cytech.pau.hia_jee.model.User;
import fr.cytech.pau.hia_jee.repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class PlayerController {

    @Autowired
    private UserRepository userRepository;

    // Ruta pública para ver el perfil de cualquier jugador por su ID
    @GetMapping("/players/{id}")
    public String showPlayerProfile(@PathVariable Long id, Model model) {
        User player = userRepository.findById(id).orElse(null);

        if (player == null) {
            return "redirect:/";
        }

        model.addAttribute("player", player);
        return "users/profile";
    }

    /**
     * Permite al usuario conectado cambiar su propia foto de perfil.
     */
    @PostMapping("/profile/edit-photo")
    public String updateProfilePhoto(@RequestParam String photoUrl, HttpSession session, RedirectAttributes redirectAttributes) {
        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser != null) {
            User dbUser = userRepository.findById(sessionUser.getId()).orElse(null);
            if (dbUser != null) {
                dbUser.setProfileImageUrl(photoUrl);
                userRepository.save(dbUser);

                // 🔥 Actualizamos el objeto en la sesión para que el cambio sea instantáneo en toda la web
                session.setAttribute("user", dbUser);
                redirectAttributes.addFlashAttribute("success", "Photo de profil mise à jour !");
            }
        }
        return "redirect:/setting"; // Redirige a ajustes o a su perfil
    }

//    @PostMapping("/profile/edit-photo")
//    public String updateProfilePhoto(@RequestParam String photoUrl, HttpSession session) {
//        User user = (User) session.getAttribute("user");
//        if (user != null) {
//            user.setProfileImageUrl(photoUrl);
//            userRepository.save(user);
//            // Actualizar sesión para que los cambios se vean de inmediato
//            session.setAttribute("user", user);
//        }
//        return "redirect:/setting"; // O a su perfil
//    }
}