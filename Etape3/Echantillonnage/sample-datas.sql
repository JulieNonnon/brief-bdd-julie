-- jeu d’échantillon issu du CSV pour les tests:

CREATE TABLE sample_data (
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

-- Dbeaver : clic droit sur la table et importer les données du fichier "adresses-samples.csv" (attention à délimitation ";") 
-- vérification si les données de l'échantillon on bien été importées :

select * from sample_data;
