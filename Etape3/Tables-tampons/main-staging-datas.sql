-- table tampon qui va accueillir les données du fichier .csv avant de les mapper dans les tables concernées
-- données en TEXT pour éviter tout conflit

CREATE TABLE staging_data (
    id TEXT,
    id_fantoir TEXT,
    numero TEXT,
    rep TEXT,
    nom_voie TEXT,              -- pour identifier la rue sans id direct
    code_postal TEXT,
    code_insee TEXT,
    nom_commune TEXT,           -- pour identifier la commune sans id direct
    code_insee_ancienne_commune TEXT,
    nom_ancienne_commune TEXT,
    x TEXT,                     -- coordonnées pour lier à la géolocalisation
    y TEXT,
    lon TEXT,
    lat TEXT,
    type_position TEXT,
    alias TEXT,
    nom_ld TEXT,
    libelle_acheminement TEXT,
    nom_afnor TEXT,
    source_position TEXT,
    source_nom_voie TEXT,
    certification_commune TEXT,
    cad_parcelles TEXT
);
