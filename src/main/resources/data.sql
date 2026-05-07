-- ==========================================
-- 1. USUARIOS (Jugadores de CS2 - 5 por equipo)
-- ==========================================
-- Admin
INSERT INTO app_users (username, password, role) SELECT 'admin', 'admin', 'ADMIN' WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'admin');

-- Natus Vincere Players
INSERT INTO app_users (username, password, role) SELECT 's1mple', '1234', 'PLAYER' WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 's1mple');
INSERT INTO app_users (username, password, role) SELECT 'b1t', '1234', 'PLAYER' WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'b1t');
INSERT INTO app_users (username, password, role) SELECT 'aleksib', '1234', 'PLAYER' WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'aleksib');
INSERT INTO app_users (username, password, role) SELECT 'jL', '1234', 'PLAYER' WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'jL');
INSERT INTO app_users (username, password, role) SELECT 'iM', '1234', 'PLAYER' WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'iM');

-- FaZe Clan Players
INSERT INTO app_users (username, password, role) SELECT 'karrigan', '1234', 'PLAYER' WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'karrigan');
INSERT INTO app_users (username, password, role) SELECT 'ropz', '1234', 'PLAYER' WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'ropz');
INSERT INTO app_users (username, password, role) SELECT 'broky', '1234', 'PLAYER' WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'broky');
INSERT INTO app_users (username, password, role) SELECT 'rain', '1234', 'PLAYER' WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'rain');
INSERT INTO app_users (username, password, role) SELECT 'frozen', '1234', 'PLAYER' WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'frozen');

-- Team Vitality Players
INSERT INTO app_users (username, password, role) SELECT 'apEX', '1234', 'PLAYER' WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'apEX');
INSERT INTO app_users (username, password, role) SELECT 'ZywOo', '1234', 'PLAYER' WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'ZywOo');
INSERT INTO app_users (username, password, role) SELECT 'Spinx', '1234', 'PLAYER' WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'Spinx');
INSERT INTO app_users (username, password, role) SELECT 'flameZ', '1234', 'PLAYER' WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'flameZ');
INSERT INTO app_users (username, password, role) SELECT 'mezii', '1234', 'PLAYER' WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'mezii');

-- Cyber Dragons Players (Antes Equipo Maracuya)
INSERT INTO app_users (username, password, role) SELECT 'pro_player', '1234', 'PLAYER' WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'pro_player');
INSERT INTO app_users (username, password, role) SELECT 'cyber_sniper', '1234', 'PLAYER' WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'cyber_sniper');
INSERT INTO app_users (username, password, role) SELECT 'cyber_tank', '1234', 'PLAYER' WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'cyber_tank');
INSERT INTO app_users (username, password, role) SELECT 'cyber_flash', '1234', 'PLAYER' WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'cyber_flash');
INSERT INTO app_users (username, password, role) SELECT 'cyber_rush', '1234', 'PLAYER' WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'cyber_rush');

-- ==========================================
-- 2. LOGROS
-- ==========================================
INSERT INTO achievement (name, description, icon) SELECT 'Primer victoria', 'Gana tu primer partido en la plataforma', '🥇' WHERE NOT EXISTS (SELECT 1 FROM achievement WHERE name = 'Primer victoria');
INSERT INTO achievement (name, description, icon) SELECT '5 victorias seguidas', 'Demuestra tu dominio con una racha', '🔥' WHERE NOT EXISTS (SELECT 1 FROM achievement WHERE name = '5 victorias seguidas');
INSERT INTO achievement (name, description, icon) SELECT 'Campeón', 'Gana la final de un torneo', '👑' WHERE NOT EXISTS (SELECT 1 FROM achievement WHERE name = 'Campeón');

-- ==========================================
-- 3. EQUIPOS (Todos configurados con CSGO)
-- ==========================================
INSERT INTO teams (name, logo_url, game, leader_id)
SELECT 'Natus Vincere', 'https://upload.wikimedia.org/wikipedia/en/thumb/a/ac/NaVi_logo.svg/1200px-NaVi_logo.svg.png', 'CSGO', (SELECT id FROM app_users WHERE username = 's1mple')
    WHERE NOT EXISTS (SELECT 1 FROM teams WHERE name = 'Natus Vincere');

INSERT INTO teams (name, logo_url, game, leader_id)
SELECT 'FaZe Clan', 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/43/FaZe_Clan.svg/1200px-FaZe_Clan.svg.png', 'CSGO', (SELECT id FROM app_users WHERE username = 'karrigan')
    WHERE NOT EXISTS (SELECT 1 FROM teams WHERE name = 'FaZe Clan');

INSERT INTO teams (name, logo_url, game, leader_id)
SELECT 'Team Vitality', 'https://upload.wikimedia.org/wikipedia/en/thumb/f/f6/Team_Vitality_logo.svg/1200px-Team_Vitality_logo.svg.png', 'CSGO', (SELECT id FROM app_users WHERE username = 'apEX')
    WHERE NOT EXISTS (SELECT 1 FROM teams WHERE name = 'Team Vitality');

INSERT INTO teams (name, logo_url, game, leader_id)
SELECT 'Cyber Dragons', 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d8/Dragon_icon.svg/1200px-Dragon_icon.svg.png', 'CSGO', (SELECT id FROM app_users WHERE username = 'pro_player')
    WHERE NOT EXISTS (SELECT 1 FROM teams WHERE name = 'Cyber Dragons');

-- ==========================================
-- 4. VINCULACIÓN DE MIEMBROS (Soluciona el Bug del Capitán)
-- ==========================================
UPDATE app_users SET team_id = (SELECT id FROM teams WHERE name = 'Natus Vincere') WHERE username IN ('s1mple', 'b1t', 'aleksib', 'jL', 'iM');
UPDATE app_users SET team_id = (SELECT id FROM teams WHERE name = 'FaZe Clan') WHERE username IN ('karrigan', 'ropz', 'broky', 'rain', 'frozen');
UPDATE app_users SET team_id = (SELECT id FROM teams WHERE name = 'Team Vitality') WHERE username IN ('apEX', 'ZywOo', 'Spinx', 'flameZ', 'mezii');
UPDATE app_users SET team_id = (SELECT id FROM teams WHERE name = 'Cyber Dragons') WHERE username IN ('pro_player', 'cyber_sniper', 'cyber_tank', 'cyber_flash', 'cyber_rush');

-- ==========================================
-- 5. TORNEO DE CSGO (Estado abierto)
-- ==========================================
INSERT INTO tournaments (name, status, game)
SELECT 'CS2 Major Guadalajara 2026', 'OUVERT', 'CSGO'
    WHERE NOT EXISTS (SELECT 1 FROM tournaments WHERE name = 'CS2 Major Guadalajara 2026');

-- ==========================================
-- 6. INSCRIPCIÓN AL TORNEO (Para generar el Bracket al instante)
-- ==========================================
INSERT INTO tournament_teams (tournament_id, team_id)
SELECT tr.id, t.id FROM tournaments tr, teams t
WHERE tr.name = 'CS2 Major Guadalajara 2026'
  AND t.name IN ('Natus Vincere', 'FaZe Clan', 'Team Vitality', 'Cyber Dragons')
  AND NOT EXISTS (
    SELECT 1 FROM tournament_teams tt
    WHERE tt.tournament_id = tr.id AND tt.team_id = t.id
);