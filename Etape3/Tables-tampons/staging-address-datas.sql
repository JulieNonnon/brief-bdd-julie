-- table tampon qui va accueillir les données du fichier .csv avant de les envoyer dans la table address
-- données en TEXT pour éviter tout conflit

CREATE TABLE address_staging (
    rep TEXT,
    alias TEXT,
    nom_ld TEXT,
    nom_voie TEXT,              -- pour identifier la rue sans id direct
    nom_commune TEXT,           -- pour identifier la commune sans id direct
    x TEXT,                     -- coordonnées pour lier à la géoloc
    y TEXT,
    lon TEXT,
    lat TEXT,
    type_position TEXT,
    source_position TEXT
);

-- Dbeaver : clic droit sur la table et importer les données du fichier csv (attention à délimitation ";") puis requète suivante :

-- mapping des données qui seront insérées dans la table address :

INSERT INTO "address" (
    rep, alias, nom_ld, id_fantoir, id_commune, id_geolocalisation
)
SELECT
    TRIM(rep),
    NULLIF(TRIM(alias), ''),
    NULLIF(TRIM(nom_ld), ''),
    s.id_fantoir,
    t.id_commune,
    g.id_geolocalisation
FROM address_staging AS stg
LEFT JOIN street AS s 
    ON LOWER(s.nom_voie) = LOWER(TRIM(stg.nom_voie))
LEFT JOIN town AS t 
    ON LOWER(t.nom_commune) = LOWER(TRIM(stg.nom_commune))
LEFT JOIN geolocation AS g
    ON ROUND(g.lon::numeric, 5) = ROUND(CAST(stg.lon AS numeric), 5)
   AND ROUND(g.lat::numeric, 5) = ROUND(CAST(stg.lat AS numeric), 5);

-- vérification de l'insertion des données concernées :

select * from "address";
