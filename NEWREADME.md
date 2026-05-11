```mermaid
classDiagram
    class Tournament {
        +Long id
        +String name
        +StatusTournament status
        +Game game
        +List~Sponsor~ Sponsors
        +List~Team~ teams
    }
    class Sponsor {
        +Long id
        +String name
        +SponsorshipLevel level
        +SponsorType type
        +String logoUrl
    }
    class Team {
        +Long id
        +User leader
        +List~User~ members
    }
    class User {
        +Long id
        +String username
        +Set~Achievement~ achievements
    }

    Tournament "m" -- "n" Sponsor : tournament_sponsor
    Tournament "1" -- "n" Match : contains
    Team "m" -- "n" Tournament : tournament_teams
    User "m" -- "n" Achievement : user_achievements
    Team "1" -- "n" User : members
```
```mermaid
sequenceDiagram
actor Admin
participant Controller as TournamentController
participant Service as TournamentService
participant DB as MatchRepository

    Admin->>Controller: POST /{id}/generate
    Controller->>Service: generateBracket(tournamentId)
    
    Service->>DB: deleteAll(matches_existentes)
    Service->>Service: Valida equipos >= 2
    Service->>Service: Calcula Potencias de 2 (Barrages)
    
    loop Por cada partido (Barrage / Ronda Regular)
        Service->>DB: save(new Match)
    end
    
    Service-->>Controller: void (Termina lógica)
    Controller-->>Admin: redirect:/tournaments/tree/{id}
```

## Validación UI/UX (Fase 2)
Se realizó una sesión de validación de prototipos con usuarios del perfil "Jugador/Líder de Equipo".
* **Hallazgo 1:** Los usuarios no sabían dónde ver sus logros.
* **Acción Tomada:** Se priorizó mover la visualización de iconos (🥇, 👑) directamente al perfil principal del usuario (`/profile`).
* **Hallazgo 2:** El árbol de torneos (Bracket) se veía amontonado en móviles.
* **Acción Tomada:** Se agregó CSS responsivo (`overflow-x: auto`) a la vista de los brackets para permitir scroll horizontal.