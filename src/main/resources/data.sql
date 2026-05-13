-- ==========================================
-- 1. USUARIOS (Jugadores Reales de CS2)
-- ==========================================
-- Admin
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins)
SELECT 'admin', 'admin', 'ADMIN', 0, 0, 0 WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'admin');

-- Natus Vincere Players (Alineación Campeona Major 2024)
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins) SELECT 'aleksib', '1234', 'PLAYER', 0, 0, 0 WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'aleksib');
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins) SELECT 'jL', '1234', 'PLAYER', 0, 0, 0 WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'jL');
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins) SELECT 'iM', '1234', 'PLAYER', 0, 0, 0 WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'iM');
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins) SELECT 'b1t', '1234', 'PLAYER', 0, 0, 0 WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'b1t');
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins) SELECT 'w0nderful', '1234', 'PLAYER', 0, 0, 0 WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'w0nderful');

-- FaZe Clan Players
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins) SELECT 'karrigan', '1234', 'PLAYER', 0, 0, 0 WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'karrigan');
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins) SELECT 'ropz', '1234', 'PLAYER', 0, 0, 0 WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'ropz');
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins) SELECT 'broky', '1234', 'PLAYER', 0, 0, 0 WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'broky');
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins) SELECT 'rain', '1234', 'PLAYER', 0, 0, 0 WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'rain');
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins) SELECT 'frozen', '1234', 'PLAYER', 0, 0, 0 WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'frozen');

-- Team Vitality Players
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins) SELECT 'apEX', '1234', 'PLAYER', 0, 0, 0 WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'apEX');
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins) SELECT 'ZywOo', '1234', 'PLAYER', 0, 0, 0 WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'ZywOo');
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins) SELECT 'Spinx', '1234', 'PLAYER', 0, 0, 0 WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'Spinx');
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins) SELECT 'flameZ', '1234', 'PLAYER', 0, 0, 0 WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'flameZ');
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins) SELECT 'mezii', '1234', 'PLAYER', 0, 0, 0 WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'mezii');

-- G2 Esports Players
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins) SELECT 'NiKo', '1234', 'PLAYER', 0, 0, 0 WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'NiKo');
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins) SELECT 'm0NESY', '1234', 'PLAYER', 0, 0, 0 WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'm0NESY');
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins) SELECT 'huNter-', '1234', 'PLAYER', 0, 0, 0 WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'huNter-');
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins) SELECT 'Snax', '1234', 'PLAYER', 0, 0, 0 WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'Snax');
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins) SELECT 'malbsMd', '1234', 'PLAYER', 0, 0, 0 WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'malbsMd');

-- ==========================================
-- 2. LOGROS
-- ==========================================
INSERT INTO achievement (name, description, icon) SELECT 'Primer victoria', 'Gana tu primer partido en la plataforma', '🥇' WHERE NOT EXISTS (SELECT 1 FROM achievement WHERE name = 'Primer victoria');
INSERT INTO achievement (name, description, icon) SELECT '5 victorias seguidas', 'Demuestra tu dominio con una racha', '🔥' WHERE NOT EXISTS (SELECT 1 FROM achievement WHERE name = '5 victorias seguidas');
INSERT INTO achievement (name, description, icon) SELECT 'Campeón', 'Gana la final de un torneo', '👑' WHERE NOT EXISTS (SELECT 1 FROM achievement WHERE name = 'Campeón');

-- ==========================================
-- 3. EQUIPOS (Equipos Reales)
-- ==========================================
INSERT INTO teams (name, logo_url, game, leader_id, wins, losses, tournament_wins)
SELECT 'Natus Vincere', 'https://img.vavel.com/navi-logo-vector-1611680145653.png', 'CSGO', (SELECT id FROM app_users WHERE username = 'aleksib'), 0, 0, 0
    WHERE NOT EXISTS (SELECT 1 FROM teams WHERE name = 'Natus Vincere');

INSERT INTO teams (name, logo_url, game, leader_id, wins, losses, tournament_wins)
SELECT 'FaZe Clan', 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/43/FaZe_Clan.svg/1200px-FaZe_Clan.svg.png', 'CSGO', (SELECT id FROM app_users WHERE username = 'karrigan'), 0, 0, 0
    WHERE NOT EXISTS (SELECT 1 FROM teams WHERE name = 'FaZe Clan');

INSERT INTO teams (name, logo_url, game, leader_id, wins, losses, tournament_wins)
SELECT 'Team Vitality', 'https://upload.wikimedia.org/wikipedia/en/thumb/f/f6/Team_Vitality_logo.svg/1200px-Team_Vitality_logo.svg.png', 'CSGO', (SELECT id FROM app_users WHERE username = 'apEX'), 0, 0, 0
    WHERE NOT EXISTS (SELECT 1 FROM teams WHERE name = 'Team Vitality');

INSERT INTO teams (name, logo_url, game, leader_id, wins, losses, tournament_wins)
SELECT 'G2 Esports', 'https://upload.wikimedia.org/wikipedia/en/thumb/4/47/G2_Esports_logo.svg/1200px-G2_Esports_logo.svg.png', 'CSGO', (SELECT id FROM app_users WHERE username = 'Snax'), 0, 0, 0
    WHERE NOT EXISTS (SELECT 1 FROM teams WHERE name = 'G2 Esports');

-- ==========================================
-- 4. VINCULACIÓN DE MIEMBROS
-- ==========================================
UPDATE app_users SET team_id = (SELECT id FROM teams WHERE name = 'Natus Vincere') WHERE username IN ('aleksib', 'jL', 'iM', 'b1t', 'w0nderful');
UPDATE app_users SET team_id = (SELECT id FROM teams WHERE name = 'FaZe Clan') WHERE username IN ('karrigan', 'ropz', 'broky', 'rain', 'frozen');
UPDATE app_users SET team_id = (SELECT id FROM teams WHERE name = 'Team Vitality') WHERE username IN ('apEX', 'ZywOo', 'Spinx', 'flameZ', 'mezii');
UPDATE app_users SET team_id = (SELECT id FROM teams WHERE name = 'G2 Esports') WHERE username IN ('NiKo', 'm0NESY', 'huNter-', 'Snax', 'malbsMd');

-- ==========================================
-- 5. TORNEO DE CS2
-- ==========================================
INSERT INTO tournaments (name, status, game)
SELECT 'CS2 Major Guadalajara 2026', 'OUVERT', 'CSGO'
    WHERE NOT EXISTS (SELECT 1 FROM tournaments WHERE name = 'CS2 Major Guadalajara 2026');

-- ==========================================
-- 6. INSCRIPCIÓN AL TORNEO
-- ==========================================
INSERT INTO tournament_teams (tournament_id, team_id)
SELECT tr.id, t.id FROM tournaments tr, teams t
WHERE tr.name = 'CS2 Major Guadalajara 2026'
  AND t.name IN ('Natus Vincere', 'FaZe Clan', 'Team Vitality', 'G2 Esports')
  AND NOT EXISTS (
    SELECT 1 FROM tournament_teams tt
    WHERE tt.tournament_id = tr.id AND tt.team_id = t.id
);
