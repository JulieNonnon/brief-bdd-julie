-- Import du fichier .csv dans PostgreSQL dans une table brute :

-- creation de la table (format des données en TEXT pour éviter tout conflit):
create table brutdata (
    id TEXT,
    id_fantoir TEXT,
    numero TEXT,
    rep TEXT,
    nom_voie TEXT,
    code_postal TEXT,
    code_insee TEXT,
    nom_commune TEXT,
    code_insee_ancienne_commune TEXT,
    nom_ancienne_commune TEXT,
    x TEXT,
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

-- Dbeaver : clic droit sur la table et importer les données du fichier csv (attention à délimitation ";" et "disable batches" si besoin)