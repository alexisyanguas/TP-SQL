CREATE DATABASE transport_logistique;

USE transport_logistique;


CREATE TABLE pays (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nom_pays VARCHAR(255) NOT NULL,
    continent VARCHAR(255) NOT NULL
);


CREATE TABLE entrepots (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nom_entrepot VARCHAR(255) NOT NULL,
    adresse VARCHAR(255) NOT NULL,
    ville VARCHAR(255) NOT NULL,
    id_pays INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_pays) REFERENCES pays(id)
);

CREATE TABLE expeditions (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    date_expedition DATE NOT NULL,
    date_livraison DATE NULL,
    date_estimee_livraison DATE NULL,
    id_entrepot_source INT UNSIGNED NOT NULL,
    id_entrepot_destination INT UNSIGNED NOT NULL,
    poids DECIMAL(10, 2) NOT NULL,
    statut VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_entrepot_source) REFERENCES entrepots(id),
    FOREIGN KEY (id_entrepot_destination) REFERENCES entrepots(id)
);