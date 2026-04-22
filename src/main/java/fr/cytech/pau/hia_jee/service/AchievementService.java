package fr.cytech.pau.hia_jee.service;

import fr.cytech.pau.hia_jee.model.Achievement;
import fr.cytech.pau.hia_jee.model.User;
import fr.cytech.pau.hia_jee.repository.AchievementRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AchievementService {

    @Autowired
    private AchievementRepository achievementRepository;

    public void unlockAchievement(User user, String achievementName) {
        Achievement achievement = achievementRepository.findByName(achievementName).orElse(null);

        if (achievement != null && !user.getAchievements().contains(achievement)) {
            user.getAchievements().add(achievement);
        }
    }
}