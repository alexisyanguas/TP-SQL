-- ● Ajoutez une table "clients" contenant les colonnes suivantes :
CREATE TABLE clients (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    adresse VARCHAR(255) NOT NULL,
    ville VARCHAR(255) NOT NULL,
    id_pays INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_pays) REFERENCES pays(id)
);

-- ● Ajoutez une table de jointure "expeditions_clients" contenant les colonnes suivantes :
CREATE TABLE expeditions_clients (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_expedition INT UNSIGNED NOT NULL,
    id_client INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_expedition) REFERENCES expeditions(id),
    FOREIGN KEY (id_client) REFERENCES clients(id)
);

-- Modifiez la table "expeditions" pour y ajouter une colonne "id_client" (entier, clé étrangère faisant référence à la table "clients").
-- ALTER TABLE expeditions ADD COLUMN id_client INT UNSIGNED NOT NULL; ne fonctionne pas donc on supprime la table et on la recrée avec la nouvelle colonne
DROP TABLE expeditions;
CREATE TABLE expeditions (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    date_expedition DATE NOT NULL,
    date_livraison DATE NULL,
    date_estimee_livraison DATE NULL,
    id_entrepot_source INT UNSIGNED NOT NULL,
    id_entrepot_destination INT UNSIGNED NOT NULL,
    poids DECIMAL(10, 2) NOT NULL,
    statut VARCHAR(255) NOT NULL,
    id_client INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_entrepot_source) REFERENCES entrepots(id),
    FOREIGN KEY (id_entrepot_destination) REFERENCES entrepots(id),
    FOREIGN KEY (id_client) REFERENCES clients(id)
);


-- ● Ajoutez des données aux tables "clients" et "expeditions_clients".
INSERT INTO clients (nom, adresse, ville, id_pays)
VALUES ('Jean', '1 rue de la paix', 'Paris', 1),
('Pierre', '2 rue de la paix', 'Paris', 1);

INSERT INTO expeditions_clients (id_expedition, id_client)
VALUES (1, 1),
(2, 2);

-- ○ Pour chaque client, affichez son nom, son adresse complète, le nombre total d'expéditions qu'il a envoyées et le nombre total d'expéditions qu'il a reçues.
SELECT clients.nom, clients.adresse, clients.ville, COUNT(expeditions_clients.id_expedition) AS nb_expeditions_envoyees, COUNT(expeditions_clients.id_client) AS nb_expeditions_recues
FROM clients
INNER JOIN expeditions_clients ON clients.id = expeditions_clients.id_client
GROUP BY clients.id;

-- ○ Pour chaque expédition, affichez son ID, son poids, le nom du client qui l'a envoyée, le nom du client qui l'a reçue et le statut
SELECT expeditions.id, expeditions.poids, clients_envoyeur.nom AS nom_envoyeur, clients_receveur.nom AS nom_receveur, expeditions.statut
FROM expeditions
INNER JOIN clients AS clients_envoyeur ON expeditions.id_client = clients_envoyeur.id
INNER JOIN expeditions_clients ON expeditions.id = expeditions_clients.id_expedition
INNER JOIN clients AS clients_receveur ON expeditions_clients.id_client = clients_receveur.id;



