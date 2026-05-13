-- ==========================================
-- 1. ADMIN Y CAPITANES REALES (Con imágenes crudas de Wikimedia Commons)
-- ==========================================
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, profile_image_url)
SELECT 'admin', 'admin', 'ADMIN', 0, 0, 0, 1200, 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d8/Person_icon_BLACK-01.svg/200px-Person_icon_BLACK-01.svg.png' WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'admin');

-- Capitanes de CSGO (9 Equipos Completos)
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, profile_image_url) SELECT 's1mple', '1234', 'PLAYER', 0, 0, 0, 1200, 'https://upload.wikimedia.org/wikipedia/commons/c/cb/S1mple_at_IEM_Katowice_2020.jpg' WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 's1mple');
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, profile_image_url) SELECT 'karrigan', '1234', 'PLAYER', 0, 0, 0, 1200, 'https://upload.wikimedia.org/wikipedia/commons/8/8e/Karrigan_at_IEM_Katowice_2024.jpg' WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'karrigan');
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, profile_image_url) SELECT 'ZywOo', '1234', 'PLAYER', 0, 0, 0, 1200, 'https://upload.wikimedia.org/wikipedia/commons/4/45/ZywOo_at_IEM_Katowice_2024.jpg' WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'ZywOo');
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, profile_image_url) SELECT 'device', '1234', 'PLAYER', 0, 0, 0, 1200, 'https://upload.wikimedia.org/wikipedia/commons/4/4f/Device_at_IEM_Katowice_2020.jpg' WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'device');
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, profile_image_url) SELECT 'NiKo', '1234', 'PLAYER', 0, 0, 0, 1200, 'https://upload.wikimedia.org/wikipedia/commons/6/6b/NiKo_at_IEM_Katowice_2020.jpg' WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'NiKo');
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, profile_image_url) SELECT 'Twistzz', '1234', 'PLAYER', 0, 0, 0, 1200, 'https://upload.wikimedia.org/wikipedia/commons/c/cd/Twistzz_at_IEM_Katowice_2024.jpg' WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'Twistzz');
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, profile_image_url) SELECT 'apEX', '1234', 'PLAYER', 0, 0, 0, 1200, 'https://upload.wikimedia.org/wikipedia/commons/f/f3/ApEX_at_IEM_Katowice_2024.jpg' WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'apEX');
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, profile_image_url) SELECT 'Jame', '1234', 'PLAYER', 0, 0, 0, 1200, 'https://upload.wikimedia.org/wikipedia/commons/0/0e/Jame_at_IEM_Katowice_2024.jpg' WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'Jame');
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, profile_image_url) SELECT 'Snappi', '1234', 'PLAYER', 0, 0, 0, 1200, 'https://upload.wikimedia.org/wikipedia/commons/9/91/Snappi_at_IEM_Katowice_2024.jpg' WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'Snappi');

-- Capitanes de equipos INCOMPLETOS
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, profile_image_url) SELECT 'donk', '1234', 'PLAYER', 0, 0, 0, 1200, 'https://upload.wikimedia.org/wikipedia/commons/3/3d/Donk_at_IEM_Katowice_2024.jpg' WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'donk');
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, profile_image_url) SELECT 'Faker', '1234', 'PLAYER', 0, 0, 0, 1200, 'https://upload.wikimedia.org/wikipedia/commons/2/2f/Faker_2020_interview.png' WHERE NOT EXISTS (SELECT 1 FROM app_users WHERE username = 'Faker');


-- ==========================================
-- 2. EQUIPOS CON LOGOS REALES (Wikimedia)
-- ==========================================
-- 9 Equipos COMPLETOS de CSGO
INSERT INTO teams (name, logo_url, game, leader_id, wins, losses, tournament_wins, elo) SELECT 'Natus Vincere', 'https://upload.wikimedia.org/wikipedia/en/a/ac/NaVi_logo.svg', 'CSGO', (SELECT id FROM app_users WHERE username = 's1mple'), 0, 0, 0, 1200 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE name = 'Natus Vincere');
INSERT INTO teams (name, logo_url, game, leader_id, wins, losses, tournament_wins, elo) SELECT 'FaZe Clan', 'https://upload.wikimedia.org/wikipedia/commons/4/43/FaZe_Clan.svg', 'CSGO', (SELECT id FROM app_users WHERE username = 'karrigan'), 0, 0, 0, 1200 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE name = 'FaZe Clan');
INSERT INTO teams (name, logo_url, game, leader_id, wins, losses, tournament_wins, elo) SELECT 'Team Vitality', 'https://upload.wikimedia.org/wikipedia/en/f/f6/Team_Vitality_logo.svg', 'CSGO', (SELECT id FROM app_users WHERE username = 'ZywOo'), 0, 0, 0, 1200 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE name = 'Team Vitality');
INSERT INTO teams (name, logo_url, game, leader_id, wins, losses, tournament_wins, elo) SELECT 'Astralis', 'https://upload.wikimedia.org/wikipedia/commons/1/14/Astralis_logo.svg', 'CSGO', (SELECT id FROM app_users WHERE username = 'device'), 0, 0, 0, 1200 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE name = 'Astralis');
INSERT INTO teams (name, logo_url, game, leader_id, wins, losses, tournament_wins, elo) SELECT 'G2 Esports', 'https://upload.wikimedia.org/wikipedia/en/1/10/G2_Esports_logo.svg', 'CSGO', (SELECT id FROM app_users WHERE username = 'NiKo'), 0, 0, 0, 1200 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE name = 'G2 Esports');
INSERT INTO teams (name, logo_url, game, leader_id, wins, losses, tournament_wins, elo) SELECT 'Team Liquid', 'https://upload.wikimedia.org/wikipedia/commons/7/7b/Team_Liquid_logo.svg', 'CSGO', (SELECT id FROM app_users WHERE username = 'Twistzz'), 0, 0, 0, 1200 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE name = 'Team Liquid');
INSERT INTO teams (name, logo_url, game, leader_id, wins, losses, tournament_wins, elo) SELECT 'MOUZ', 'https://upload.wikimedia.org/wikipedia/commons/f/fa/MOUZ_logo.svg', 'CSGO', (SELECT id FROM app_users WHERE username = 'apEX'), 0, 0, 0, 1200 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE name = 'MOUZ');
INSERT INTO teams (name, logo_url, game, leader_id, wins, losses, tournament_wins, elo) SELECT 'Virtus.pro', 'https://upload.wikimedia.org/wikipedia/commons/b/b2/Virtus.pro_Logo.png', 'CSGO', (SELECT id FROM app_users WHERE username = 'Jame'), 0, 0, 0, 1200 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE name = 'Virtus.pro');
INSERT INTO teams (name, logo_url, game, leader_id, wins, losses, tournament_wins, elo) SELECT 'ENCE', 'https://upload.wikimedia.org/wikipedia/commons/3/3d/ENCE_logo.svg', 'CSGO', (SELECT id FROM app_users WHERE username = 'Snappi'), 0, 0, 0, 1200 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE name = 'ENCE');

-- 2 Equipos INCOMPLETOS
INSERT INTO teams (name, logo_url, game, leader_id, wins, losses, tournament_wins, elo) SELECT 'Team Spirit', 'https://upload.wikimedia.org/wikipedia/en/4/4b/Team_Spirit_logo.svg', 'CSGO', (SELECT id FROM app_users WHERE username = 'donk'), 0, 0, 0, 1200 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE name = 'Team Spirit');
INSERT INTO teams (name, logo_url, game, leader_id, wins, losses, tournament_wins, elo) SELECT 'T1', 'https://upload.wikimedia.org/wikipedia/en/f/f9/T1_logo.svg', 'LOL', (SELECT id FROM app_users WHERE username = 'Faker'), 0, 0, 0, 1200 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE name = 'T1');

-- ACTUALIZAR CAPITANES AL ID DE SUS EQUIPOS
UPDATE app_users SET team_id = (SELECT id FROM teams WHERE name = 'Natus Vincere') WHERE username = 's1mple';
UPDATE app_users SET team_id = (SELECT id FROM teams WHERE name = 'FaZe Clan') WHERE username = 'karrigan';
UPDATE app_users SET team_id = (SELECT id FROM teams WHERE name = 'Team Vitality') WHERE username = 'ZywOo';
UPDATE app_users SET team_id = (SELECT id FROM teams WHERE name = 'Astralis') WHERE username = 'device';
UPDATE app_users SET team_id = (SELECT id FROM teams WHERE name = 'G2 Esports') WHERE username = 'NiKo';
UPDATE app_users SET team_id = (SELECT id FROM teams WHERE name = 'Team Liquid') WHERE username = 'Twistzz';
UPDATE app_users SET team_id = (SELECT id FROM teams WHERE name = 'MOUZ') WHERE username = 'apEX';
UPDATE app_users SET team_id = (SELECT id FROM teams WHERE name = 'Virtus.pro') WHERE username = 'Jame';
UPDATE app_users SET team_id = (SELECT id FROM teams WHERE name = 'ENCE') WHERE username = 'Snappi';
UPDATE app_users SET team_id = (SELECT id FROM teams WHERE name = 'Team Spirit') WHERE username = 'donk';
UPDATE app_users SET team_id = (SELECT id FROM teams WHERE name = 'T1') WHERE username = 'Faker';

-- ==========================================
-- 3. RELLENAR JUGADORES (Con IDs de los equipos)
-- ==========================================
-- NaVi (Total 5)
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('b1t', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'Natus Vincere'));
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('aleksib', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'Natus Vincere'));
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('jL', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'Natus Vincere'));
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('iM', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'Natus Vincere'));

-- FaZe (Total 5)
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('ropz', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'FaZe Clan'));
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, profile_image_url, team_id) VALUES ('broky', '1234', 'PLAYER', 0,0,0,1200, 'https://upload.wikimedia.org/wikipedia/commons/4/4a/Broky_at_IEM_Katowice_2024.jpg', (SELECT id FROM teams WHERE name = 'FaZe Clan'));
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('rain', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'FaZe Clan'));
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('frozen', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'FaZe Clan'));

-- Vitality (Total 5)
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('Spinx', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'Team Vitality'));
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('flameZ', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'Team Vitality'));
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('mezii', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'Team Vitality'));
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('Magisk', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'Team Vitality'));

-- Astralis (Total 5)
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('stavn', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'Astralis'));
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('jabbi', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'Astralis'));
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('Staehr', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'Astralis'));
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('br0', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'Astralis'));

-- G2 (Total 5)
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('m0NESY', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'G2 Esports'));
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('huNter-', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'G2 Esports'));
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('nexa', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'G2 Esports'));
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('HooXi', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'G2 Esports'));

-- Liquid (Total 5)
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('NAF', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'Team Liquid'));
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('YEKINDAR', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'Team Liquid'));
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('cadiaN', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'Team Liquid'));
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('skullz', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'Team Liquid'));

-- MOUZ (Total 5)
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('torzsi', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'MOUZ'));
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('Brollan', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'MOUZ'));
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('Jimpphat', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'MOUZ'));
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('xertioN', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'MOUZ'));

-- Virtus.pro (Total 5)
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('FL1T', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'Virtus.pro'));
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('fame', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'Virtus.pro'));
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('n0rb3r7', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'Virtus.pro'));
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('mir', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'Virtus.pro'));

-- ENCE (Total 5)
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('dycha', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'ENCE'));
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('maden', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'ENCE'));
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('SunPayus', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'ENCE'));
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('NertZ', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'ENCE'));

-- Team Spirit INCOMPLETO (Total 3 Jugadores)
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('chopper', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'Team Spirit'));
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, team_id) VALUES ('sh1ro', '1234', 'PLAYER', 0,0,0,1200, (SELECT id FROM teams WHERE name = 'Team Spirit'));

-- T1 INCOMPLETO (Total 2 Jugadores)
INSERT INTO app_users (username, password, role, wins, losses, tournament_wins, elo, profile_image_url, team_id) VALUES ('Zeus', '1234', 'PLAYER', 0,0,0,1200, 'https://upload.wikimedia.org/wikipedia/commons/e/ec/Zeus_at_2022_World_Championship.jpg', (SELECT id FROM teams WHERE name = 'T1'));

-- ==========================================
-- 4. TORNEOS E INSCRIPCIÓN (SÓLO 9 EQUIPOS COMPLETOS DE CSGO)
-- ==========================================
INSERT INTO achievement (name, description, icon) SELECT 'Primer victoria', 'Gana tu primer partido en la plataforma', '🥇' WHERE NOT EXISTS (SELECT 1 FROM achievement WHERE name = 'Primer victoria');
INSERT INTO achievement (name, description, icon) SELECT 'Campeón', 'Gana la final de un torneo', '👑' WHERE NOT EXISTS (SELECT 1 FROM achievement WHERE name = 'Campeón');

INSERT INTO tournaments (name, status, game) SELECT 'IEM Katowice 2026', 'OUVERT', 'CSGO' WHERE NOT EXISTS (SELECT 1 FROM tournaments WHERE name = 'IEM Katowice 2026');

-- Se inscriben SÓLO los 9 equipos que cumplen la regla de 5 jugadores
INSERT INTO tournament_teams (tournament_id, team_id)
SELECT tr.id, t.id FROM tournaments tr, teams t WHERE tr.name = 'IEM Katowice 2026'
                                                  AND t.name IN ('Natus Vincere', 'FaZe Clan', 'Team Vitality', 'Astralis', 'G2 Esports', 'Team Liquid', 'MOUZ', 'Virtus.pro', 'ENCE')
                                                  AND NOT EXISTS (SELECT 1 FROM tournament_teams tt WHERE tt.tournament_id = tr.id AND tt.team_id = t.id);