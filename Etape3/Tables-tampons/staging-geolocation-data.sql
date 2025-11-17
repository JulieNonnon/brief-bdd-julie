-- table tampon qui va accueillir les données du fichier .csv avant de les envoyer dans la table geolocation
-- données en TEXT pour éviter tout conflit

CREATE TABLE geolocation_staging (
    x TEXT,
    y TEXT,
    lon TEXT,
    lat TEXT,
    type_position TEXT,
    source_position TEXT,
    nom_categorie TEXT   -- pour récupérer l'id_categorie
);

-- Dbeaver : clic droit sur la table et importer les données du fichier csv (attention à délimitation ";") puis requète suivante :

-- mapping des données qui seront insérées dans la table geolocation :

INSERT INTO geolocation (
    x, y, lon, lat, type_position, source_position, id_categorie
)
SELECT
    CAST(x AS DOUBLE PRECISION),
    CAST(y AS DOUBLE PRECISION),
    CAST(lon AS DOUBLE PRECISION),
    CAST(lat AS DOUBLE PRECISION),
    TRIM(type_position),
    TRIM(source_position),
    c.id_categorie
FROM geolocation_staging AS stg
LEFT JOIN category AS c
    ON LOWER(c.nom_categorie) = LOWER(TRIM(stg.nom_categorie));

-- vérification de l'insertion des données concernées :

select * from "geolocation";