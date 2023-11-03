


-- Insertion de 10 pays avec des valeurs prédéfinies
INSERT INTO pays (nom_pays, continent)
VALUES ('France', 'Europe'),
('Allemagne', 'Europe'),
('Espagne', 'Europe'),
('Mexique', 'Amérique'),
('Brésil', 'Amérique'),
('Australie', 'Océanie'),
('Afrique du Sud', 'Afrique'),
('Royaume-Uni', 'Europe'),
('Russie', 'Europe'),
('Chine', 'Asie'),
('Japon', 'Asie'),
('Inde', 'Asie'),
('Corée du Sud', 'Asie');



-- Insertion de 5 entrepôts avec des valeurs prédéfinies
INSERT INTO entrepots (nom_entrepot, adresse, ville, id_pays)
VALUES ('Entrepôt 1', '1 rue de la Paix', 'Paris', 1),
('Entrepôt 2', '2 rue de la Paix', 'Madrid', 3),
('Entrepôt 3', '3 rue de la Paix', 'Berlin', 2),
('Entrepôt 4', '4 rue de la Paix', 'Londres', 8),
('Entrepôt 5', '5 rue de la Paix', 'Moscou', 9),
('Entrepôt 6', '6 rue de la Paix', 'Tokyo', 11),
('Entrepôt 7', '7 rue de la Paix', 'Pékin', 10),
('Entrepôt 8', '8 rue de la Paix', 'Séoul', 12),
('Entrepôt 9', '9 rue de la Paix', 'Sydney', 6),
('Entrepôt 10', '10 rue de la Paix', 'Rio de Janeiro', 5);



-- Insertion de 100 expéditions aléatoire en transit ou livré en 2023
INSERT INTO expeditions (date_expedition, id_entrepot_source, id_entrepot_destination, poids, statut, date_livraison, date_estimee_livraison, id_client)
VALUES (DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND() * 365) DAY), FLOOR(RAND() * 10) + 1, FLOOR(RAND() * 10) + 1, FLOOR(RAND() * 100) + 1, IF(RAND() > 0.5, 'En transit', 'Livré'), IF(RAND() > 0.5, DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND() * 365) DAY), NULL), DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND() * 365) DAY), 2);


-- -- Insertion de 10 expéditions aléatoires et un statut "Livré"
-- INSERT INTO expeditions (date_expedition, id_entrepot_source, id_entrepot_destination, poids, statut)
-- VALUES (DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND() * 365) DAY), FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 100) + 1, 'Livré'),
-- (DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND() * 365) DAY), FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 100) + 1, 'Livré'),
-- (DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND() * 365) DAY), FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 100) + 1, 'Livré'),
-- (DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND() * 365) DAY), FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 100) + 1, 'Livré'),
-- (DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND() * 365) DAY), FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 100) + 1, 'Livré'),
-- (DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND() * 365) DAY), FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 100) + 1, 'Livré'),
-- (DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND() * 365) DAY), FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 100) + 1, 'Livré'),
-- (DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND() * 365) DAY), FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 100) + 1, 'Livré'),
-- (DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND() * 365) DAY), FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 100) + 1, 'Livré'),
-- (DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND() * 365) DAY), FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 100) + 1, 'Livré');


-- -- Add exepedition with date_expedition now
-- INSERT INTO expeditions (date_expedition, id_entrepot_source, id_entrepot_destination, poids, statut)
-- VALUES (NOW(), 1, 2, 10, 'En transit');