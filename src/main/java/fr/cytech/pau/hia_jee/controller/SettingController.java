package fr.cytech.pau.hia_jee.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import fr.cytech.pau.hia_jee.model.User;
import fr.cytech.pau.hia_jee.service.UserService;
import fr.cytech.pau.hia_jee.repository.UserRepository; // <-- AÑADIDO
import jakarta.servlet.http.HttpSession;

//Contrôleur gérant la page de "Paramètres" (Settings) de l'utilisateur.

@Controller
@RequestMapping("/setting")
public class SettingController {

    @Autowired
    private UserService userService;

    @Autowired
    private UserRepository userRepository; // <-- AÑADIDO para guardar la imagen fácilmente

    // ============================================================
    // AFFICHER LA PAGE DES PARAMÈTRES
    // ============================================================

    @GetMapping
    public String showSettings(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");

        // Sécurité manuelle : Si l'utilisateur n'est pas connecté, on le renvoie au login.
        if (user == null) return "redirect:/login";

        // On passe l'utilisateur au modèle pour pré-remplir les champs (pseudo, etc.)
        model.addAttribute("user", user);
        return "setting"; // Vue: src/main/resources/templates/setting.html
    }

    // ============================================================
    // ACTION : CHANGER PSEUDO ET PHOTO DE PROFIL
    // ============================================================

    @PostMapping("/update-profile")
    public String updateProfile(@RequestParam String username,
                                @RequestParam(value = "profileImageUrl", required = false) String profileImageUrl, // <-- AÑADIDO
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser == null) return "redirect:/login";

        try {
            // 1. Appel au service pour mise à jour du pseudo en base de données
            User updatedUser = userService.updateUsername(sessionUser.getId(), username);

            // 2. 🔥 MISE À JOUR DE LA PHOTO DE PROFIL 🔥
            if (profileImageUrl != null) {
                updatedUser.setProfileImageUrl(profileImageUrl);
                updatedUser = userRepository.save(updatedUser); // On sauvegarde l'image en BDD
            }

            // 3. MISE À JOUR DE LA SESSION (Crucial !)
            session.setAttribute("user", updatedUser);

            // 4. Message flash
            redirectAttributes.addFlashAttribute("success", "Profil mis à jour avec succès !");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }

        return "redirect:/setting";
    }

    // ============================================================
    // ACTION : CHANGER MOT DE PASSE
    // ============================================================

    @PostMapping("/update-password")
    public String updatePassword(@RequestParam String currentPassword,
                                 @RequestParam String newPassword,
                                 @RequestParam String confirmPassword,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        try {
            userService.updatePassword(user.getId(), currentPassword, newPassword, confirmPassword);
            redirectAttributes.addFlashAttribute("success", "Mot de passe modifié !");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/setting";
    }

    // ============================================================
    // ACTION : QUITTER EQUIPE
    // ============================================================

    @PostMapping("/leave-team")
    public String leaveTeam(HttpSession session, RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        try {
            userService.leaveTeam(user.getId());
            user.setTeam(null);
            session.setAttribute("user", user);

            redirectAttributes.addFlashAttribute("success", "Vous avez quitté l'équipe.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/setting";
    }

    // ============================================================
    // ACTION : SUPPRIMER COMPTE
    // ============================================================

    @PostMapping("/delete-account")
    public String deleteAccount(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            userService.deleteAccount(user.getId());
            session.invalidate();
        }
        return "redirect:/"; // Retour à l'accueil publique
    }
}