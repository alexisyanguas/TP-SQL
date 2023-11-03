
-- J'ai ajouter une table pays pour pouvoir faire des jointures avec les entrepots pour avoir le continent pour une requête plus bas
SELECT * FROM entrepots 
JOIN pays ON entrepots.id_pays = pays.id;


SELECT * FROM expeditions ;


SELECT * FROM expeditions WHERE statut = 'En transit';

SELECT * FROM expeditions WHERE statut = 'Livré';



-- ● Affichez les entrepôts qui ont envoyé au moins une expédition en transit.
SELECT * FROM entrepots
INNER JOIN expeditions ON entrepots.id = expeditions.id_entrepot_source
WHERE expeditions.statut = 'En transit';

-- ● Affichez les entrepôts qui ont reçu au moins une expédition livré.
SELECT * FROM entrepots
INNER JOIN expeditions ON entrepots.id = expeditions.id_entrepot_destination
WHERE expeditions.statut = 'En transit';

-- ● Affichez les expéditions qui ont un poids supérieur à 10 kg et qui sont en
-- transit.
SELECT * FROM expeditions
WHERE expeditions.poids > 10 AND expeditions.statut = 'En transit';

-- ● Affichez le nombre d'expéditions envoyées par chaque entrepôt.
SELECT entrepots.nom_entrepot, COUNT(*) AS nb_expeditions FROM entrepots
INNER JOIN expeditions ON entrepots.id = expeditions.id_entrepot_source
GROUP BY entrepots.nom_entrepot;

-- ● Affichez le nombre total d'expéditions en transit.
SELECT COUNT(*) AS nb_expeditions FROM expeditions
WHERE expeditions.statut = 'En transit';


-- ● Affichez le nombre total d'expéditions livrées.
SELECT COUNT(*) AS nb_expeditions FROM expeditions
WHERE expeditions.statut = 'Livré';

-- ● Affichez le nombre total d'expéditions pour chaque mois de l'année en cours.
SELECT MONTH(expeditions.date_expedition) AS mois, COUNT(*) AS nb_expeditions FROM expeditions
GROUP BY MONTH(expeditions.date_expedition);

-- ● Affichez les entrepôts qui ont envoyé des expéditions au cours des 30 derniers jours.
SELECT * FROM entrepots
INNER JOIN expeditions ON entrepots.id = expeditions.id_entrepot_source
WHERE expeditions.date_expedition > DATE_SUB(NOW(), INTERVAL 30 DAY) AND expeditions.date_expedition < NOW();

-- ● Affichez les entrepôts qui ont reçu des expéditions au cours des 30 derniers jours.
SELECT * FROM entrepots
INNER JOIN expeditions ON entrepots.id = expeditions.id_entrepot_destination
WHERE expeditions.date_expedition > DATE_SUB(NOW(), INTERVAL 30 DAY) AND expeditions.date_expedition < NOW();

-- ● Affichez les expéditions qui ont été livrées dans un délai de moins de 5 jours ouvrables.
-- date_expedition + 5 jours ouvrables = date_livraison
SELECT * FROM expeditions
WHERE DATEDIFF(date_livraison, date_expedition) < 5 AND statut = 'Livré';


-- ● Affichez les expéditions en transit qui ont été initiées par un entrepôt situé en Europe et à destination d'un entrepôt situé en Asie.
-- J'ai donc besoin de la table pays pour faire une jointure avec les entrepots pour avoir le continent
SELECT * FROM expeditions
INNER JOIN entrepots ON expeditions.id_entrepot_source = entrepots.id INNER JOIN pays ON entrepots.id_pays = pays.id
WHERE pays.continent = 'Europe' AND expeditions.statut = 'En transit' AND (SELECT pays.continent FROM entrepots INNER JOIN pays ON entrepots.id_pays = pays.id WHERE entrepots.id = expeditions.id_entrepot_destination) = 'Asie';

-- ● Affichez les entrepôts qui ont envoyé des expéditions à destination d'un entrepôt situé dans le même pays.
SELECT * FROM entrepots
INNER JOIN expeditions ON entrepots.id = expeditions.id_entrepot_source
WHERE expeditions.id_entrepot_source = expeditions.id_entrepot_destination;

-- ● Affichez les entrepôts qui ont envoyé des expéditions à destination d'un entrepôt situé dans un pays différent.
SELECT * FROM entrepots
INNER JOIN expeditions ON entrepots.id = expeditions.id_entrepot_source
WHERE expeditions.id_entrepot_source != expeditions.id_entrepot_destination;

-- ● Affichez les expéditions en transit qui ont été initiées par un entrepôt situé dans un pays dont le nom commence par la lettre "F" et qui pèsent plus de 50 kg.
SELECT * FROM expeditions
INNER JOIN entrepots ON expeditions.id_entrepot_source = entrepots.id
INNER JOIN pays ON entrepots.id_pays = pays.id
WHERE pays.nom_pays LIKE 'F%' AND expeditions.statut = 'En transit' AND expeditions.poids > 50;

-- ● Affichez le nombre total d'expéditions pour chaque combinaison de pays d'origine et de destination.
SELECT pays_source.nom_pays AS pays_source, pays_destination.nom_pays AS pays_destination, COUNT(*) AS nb_expeditions FROM expeditions
INNER JOIN entrepots ON expeditions.id_entrepot_source = entrepots.id
INNER JOIN pays AS pays_source ON entrepots.id_pays = pays_source.id
INNER JOIN entrepots AS entrepots_destination ON expeditions.id_entrepot_destination = entrepots_destination.id
INNER JOIN pays AS pays_destination ON entrepots_destination.id_pays = pays_destination.id
GROUP BY pays_source.nom_pays, pays_destination.nom_pays;

-- ● Affichez les entrepôts qui ont envoyé des expéditions au cours des 30 derniers jours et dont le poids total des expéditions est supérieur à 200 kg.
-- Important d'avoir les mêmes colonnes dans le SELECT et dans le GROUP BY donc pas de SELECT *
SELECT entrepots.id, entrepots.nom_entrepot FROM entrepots 
INNER JOIN expeditions ON entrepots.id = expeditions.id_entrepot_source
WHERE expeditions.date_expedition > DATE_SUB(NOW(), INTERVAL 30 DAY) AND expeditions.date_expedition < NOW()
GROUP BY entrepots.id, entrepots.nom_entrepot
HAVING SUM(expeditions.poids) > 200;

-- Affichez les expéditions qui ont été livrées 
-- J'ai besoin ici d'ajouter date_estimee_livraison dans la table expeditions
SELECT  * FROM expeditions
WHERE expeditions.statut = 'Livré' AND expeditions.date_estimee_livraison < DATE_ADD(expeditions.date_livraison, INTERVAL 2 DAY);


-- ● Affichez le nombre total d'expéditions pour chaque jour du mois en cours, trié par ordre décroissant.
SELECT DAY(expeditions.date_expedition) AS jour, COUNT(*) AS nb_expeditions FROM expeditions
GROUP BY DAY(expeditions.date_expedition)
ORDER BY nb_expeditions DESC;


