-- ● Créez une vue qui affiche les informations suivantes pour chaque entrepôt : nom de l'entrepôt, adresse complète, nombre d'expéditions envoyées au cours des 30 derniers jours.
CREATE VIEW info_entrepot AS
SELECT nom_entrepot, CONCAT(adresse, ' ', ville, ' ', pays.nom_pays) AS adresse_complete, COUNT(*) AS nb_expeditions
FROM expeditions
INNER JOIN entrepots ON expeditions.id_entrepot_source = entrepots.id
INNER JOIN pays ON entrepots.id_pays = pays.id
WHERE date_expedition > DATE_SUB(CURDATE(), INTERVAL 30 DAY) AND date_expedition <= NOW()
GROUP BY nom_entrepot, adresse_complete;


-- ● Créez une procédure stockée qui prend en entrée l'ID d'un entrepôt et renvoie le nombre total d'expéditions envoyées par cet entrepôt au cours du dernier mois.
CREATE PROCEDURE nb_expeditions_entrepot(IN id_entrepot INT)
BEGIN
    SELECT COUNT(*) AS nb_expeditions
    FROM expeditions
    WHERE id_entrepot_source = id_entrepot AND date_expedition > DATE_SUB(CURDATE(), INTERVAL 30 DAY) AND date_expedition <= NOW();
END;

CALL nb_expeditions_entrepot(7);

-- ● Créez une fonction qui prend en entrée une date et renvoie le nombre total d'expéditions livrées ce jour-là.
CREATE FUNCTION nb_expeditions_livre(date_livraison DATE) RETURNS INT
BEGIN
    DECLARE nb_expeditions INT;
    SELECT COUNT(*) INTO nb_expeditions FROM expeditions WHERE expeditions.date_livraison = date_livraison;
    RETURN nb_expeditions;
END;

SELECT nb_expeditions_livre('2023-06-25');



