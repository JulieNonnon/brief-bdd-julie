-- table tampon qui va accueillir les données du fichier .csv avant de les envoyer dans la table town
-- données en TEXT pour éviter tout conflit

CREATE TABLE town_staging (
    code_insee TEXT,
    nom_commune TEXT,
    code_insee_ancienne_commune TEXT,
    nom_ancienne_commune TEXT,
    certification_commune TEXT,
    libelle_acheminement TEXT
);

-- Dbeaver : clic droit sur la table et importer les données du fichier csv (attention à délimitation ";") puis requète suivante :

-- mapping des données qui seront insérées dans la table town :

INSERT INTO town (
    code_insee,
    nom_commune,
    code_insee_ancienne_commune,
    nom_ancienne_commune,
    certification_commune,
    libelle_acheminement
)
SELECT DISTINCT
    TRIM(code_insee),
    INITCAP(TRIM(nom_commune)),
    NULLIF(TRIM(code_insee_ancienne_commune), ''),
    NULLIF(TRIM(nom_ancienne_commune), ''),
    CASE 
        WHEN LOWER(TRIM(certification_commune)) IN ('true','t','1','oui','yes','y') THEN TRUE
        WHEN LOWER(TRIM(certification_commune)) IN ('false','f','0','non','no','n') THEN FALSE
        ELSE FALSE
    END,
    INITCAP(TRIM(libelle_acheminement))
FROM town_staging
ON CONFLICT (code_insee) DO NOTHING;

-- vérification de l'insertion des données concernées :

select * from town;