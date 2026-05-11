package fr.cytech.pau.hia_jee.service;

import org.springframework.stereotype.Service;

@Service
public class EloService {

    private static final int K_FACTOR = 32; // Factor de sensibilidad del algoritmo

    public int calculateNewRating(int currentRating, int opponentRating, boolean won) {
        // 1. Calcular la probabilidad esperada de victoria
        double expectedScore = 1.0 / (1.0 + Math.pow(10, (opponentRating - currentRating) / 400.0));

        // 2. Resultado real (1 si ganó, 0 si perdió)
        int actualScore = won ? 1 : 0;

        // 3. Nueva puntuación ELO
        return (int) (currentRating + K_FACTOR * (actualScore - expectedScore));
    }
}