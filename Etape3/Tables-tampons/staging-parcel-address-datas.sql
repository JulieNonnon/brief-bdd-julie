-- table tampon qui va accueillir les données du fichier .csv avant de les envoyer dans la table parcel_address
-- données en TEXT pour éviter tout conflit

CREATE TABLE parcel_address_staging (
    cad_parcelles TEXT,
    alias_adresse TEXT     -- correspond au alias de la table address
);

-- Dbeaver : clic droit sur la table et importer les données du fichier csv (attention à délimitation ";") puis requète suivante :

-- mapping des données qui seront insérées dans la table parcel_address :

INSERT INTO parcel_address (id_parcelle, id_adresse)
SELECT
    p.id_parcelle,
    a.id_adresse
FROM parcel_address_staging AS stg
JOIN parcel AS p 
    ON TRIM(p.cad_parcelle) = TRIM(stg.cad_parcelles)
JOIN address AS a
    ON LOWER(TRIM(a.alias)) = LOWER(TRIM(stg.alias_adresse));

-- vérification de l'insertion des données concernées :

select * from parcel_address;