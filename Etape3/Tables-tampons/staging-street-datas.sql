-- table tampon qui va accueillir les données du fichier .csv avant de les envoyer dans la table street
-- données en TEXT pour éviter tout conflit

CREATE TABLE street_staging (
    numero TEXT,
    nom_voie TEXT,
    code_postal TEXT,
    nom_afnor TEXT,
    source_nom_voie TEXT,
    nom_categorie TEXT
);

-- Dbeaver : clic droit sur la table et importer les données du fichier csv (attention à délimitation ";") puis requète suivante :

-- mapping des données qui seront insérées dans la table street :

INSERT INTO street (
    numero, nom_voie, code_postal, nom_afnor,
    source_nom_voie, id_categorie
)
SELECT
    CAST(NULLIF(TRIM(numero), '') AS INT),
    TRIM(nom_voie),
    CAST(code_postal AS INT),
    TRIM(nom_afnor),
    TRIM(source_nom_voie),
    c.id_categorie
FROM street_staging AS stg
LEFT JOIN category AS c
    ON LOWER(c.nom_categorie) = LOWER(TRIM(stg.nom_categorie));

-- vérification de l'insertion des données concernées :

select * from street;