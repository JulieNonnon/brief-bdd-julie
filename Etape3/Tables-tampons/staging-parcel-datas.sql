-- table tampon qui va accueillir les données du fichier .csv avant de les envoyer dans la table parcel
-- données en TEXT pour éviter tout conflit

CREATE TABLE parcel_staging (
    cad_parcelles TEXT
);

-- Dbeaver : clic droit sur la table et importer les données du fichier csv (attention à délimitation ";") puis requète suivante :

-- mapping des données qui seront insérées dans la table parcel :

INSERT INTO parcel (cad_parcelle)
SELECT DISTINCT TRIM(cad_parcelles)
FROM parcel_staging
WHERE cad_parcelles IS NOT NULL AND cad_parcelles <> '';

-- vérification de l'insertion des données concernées :

select * from parcel;