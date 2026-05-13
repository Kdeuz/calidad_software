package fr.cytech.pau.hia_jee.model;

import jakarta.persistence.*;
import java.util.HashSet;
import java.util.Set;

/**
 * Entité représentant un Utilisateur de l'application (Joueur ou Admin).
 */
@Entity
// "USER" est un mot-clé réservé en SQL (comme SELECT ou INSERT).
// Si on ne change pas le nom avec @Table, Hibernate essaiera de créer une table "User"
// et cela provoquera une erreur SQL au démarrage. On utilise donc "app_users".
@Table(name = "app_users") 
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private int wins = 0;
    private int losses = 0;

    private int tournamentWins = 0;

    @Column(nullable = false)
    private int elo = 1200; // Puntaje inicial estándar

    public int getElo() { return elo; }
    public void setElo(int elo) { this.elo = elo; }

    private String profileImageUrl;

    public String getProfileImageUrl() { return profileImageUrl; }
    public void setProfileImageUrl(String profileImageUrl) { this.profileImageUrl = profileImageUrl; }


    // Le nom d'utilisateur (login).
    // unique = true : La BDD empêchera physiquement d'avoir deux utilisateurs avec le même pseudo.
    // nullable = false : Le champ est obligatoire.
    @Column(nullable = false, unique = true)
    private String username; 

    @Column(nullable = false)
    private String password; // Le mot de passe (idéalement haché, pas en clair)

    /**
     * Rôle de l'utilisateur (ADMIN, PLAYER, MANAGER...).
     * @Enumerated(EnumType.STRING) :
     * Stocke "ADMIN" dans la colonne SQL au lieu de "0".
     * C'est beaucoup plus sûr si vous modifiez l'ordre des rôles dans l'Enum Java plus tard.
     */
    @Enumerated(EnumType.STRING) 
    private Role role;

    // --- RELATION UTILISATEUR -> ÉQUIPE ---
    
    // Relation N-1 (Many-To-One) :
    // - MANY Users (Plusieurs utilisateurs)...
    // - ...belong to ONE Team (...appartiennent à UNE équipe).
    @ManyToOne
    // @JoinColumn définit la Clé Étrangère (Foreign Key).
    // Une colonne "team_id" sera créée dans la table "app_users".
    // C'est cette classe (User) qui "possède" la relation physique (Owning Side).
    @JoinColumn(name = "team_id") 
    private Team team;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
            name = "user_achievements",
            joinColumns = @JoinColumn(name = "user_id"),
            inverseJoinColumns = @JoinColumn(name = "achievement_id")
    )
    private Set<Achievement> achievements = new HashSet<>();

    // --- CONSTRUCTEURS ---
    public User() {}

    public User(String username, String password, Role role) {
        this.username = username;
        this.password = password;
        this.role = role;
    }

    // --- GETTERS & SETTERS ---

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public Role getRole() { return role; }
    public void setRole(Role role) { this.role = role; }

    public Team getTeam() { return team; }
    public void setTeam(Team team) { this.team = team; }

    public Set<Achievement> getAchievements() { return achievements; }
    public void setAchievements(Set<Achievement> achievements) { this.achievements = achievements; }

    public int getWins() {
        return wins;
    }

    public void setWins(int wins) {
        this.wins = wins;
    }

    public int getLosses() {
        return losses;
    }

    public void setLosses(int losses) {
        this.losses = losses;
    }

    public int getTournamentWins() {
        return tournamentWins;
    }

    public void setTournamentWins(int tournamentWins) {
        this.tournamentWins = tournamentWins;
    }
}