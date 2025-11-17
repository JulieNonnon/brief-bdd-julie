
-- ✅ Lister toutes les adresses d’une commune donnée, triées par voie (ex: Oze).

SELECT a.id_adresse,
       a.rep,
       a.alias,
       a.nom_ld,
       s.nom_voie,
       s.numero,
       t.nom_commune,
       s.code_postal
FROM "address" a
JOIN street s ON a.id_fantoir = s.id_fantoir
JOIN town t ON a.id_commune = t.id_commune
WHERE t.nom_commune = 'Oze'
ORDER BY s.nom_voie, s.numero;

-- ✅ Compter le nombre d’adresses par commune (bonus: et par voie).
SELECT t.nom_commune,
       s.nom_voie,
       COUNT(a.id_adresse) AS nb_adresses
FROM "address" a
JOIN street s ON a.id_fantoir = s.id_fantoir
JOIN town t ON a.id_commune = t.id_commune
GROUP BY t.nom_commune, s.nom_voie
ORDER BY t.nom_commune, s.nom_voie;

-- ✅ Lister toutes les communes distinctes présentes dans le fichier.
SELECT DISTINCT nom_commune
FROM town
ORDER BY nom_commune;

-- ✅ Rechercher toutes les adresses contenant un mot-clé particulier dans le nom de voie (ex: Boulevard, Rue, etc...).

SELECT a.id_adresse,
       s.nom_voie,
       s.numero,
       t.nom_commune
FROM "address" a
JOIN street s ON a.id_fantoir = s.id_fantoir
JOIN town t ON a.id_commune = t.id_commune
WHERE s.nom_voie ILIKE '%Route%';

-- ✅ Identifier les adresses où le code postal est vide alors que la commune est renseignée.
-- NOTE: aucun code postal n'est manquant dans le fichier .csv étudié, par conséquent aucune ligne ne sera affichée pour cette requête 

SELECT a.id_adresse,
       s.nom_voie,
       s.numero,
       t.nom_commune,
       s.code_postal
FROM "address" a
JOIN street s ON a.id_fantoir = s.id_fantoir
JOIN town t ON a.id_commune = t.id_commune
WHERE (s.code_postal IS NULL OR s.code_postal = 0)
  AND t.nom_commune IS NOT NULL;

-- Ajouter une nouvelle adresse complète dans les tables finales.

-- TODO

-- ✅ Mettre à jour le nom d’une voie pour une adresse spécifique.

UPDATE street s
SET nom_voie = 'TEST MAJ VOIE'
FROM "address" a
WHERE a.id_fantoir = s.id_fantoir
  AND a.id_adresse = 123;

-- Supprimer toutes les adresses avec un champ manquant critique (ex : numéro de voie vide).

-- TODO

-- ✅ Identifier doublons exacts (mêmes numéro + nom de voie + code postal + commune).

SELECT 
    t.nom_commune,
    s.nom_voie,
    s.numero,
    s.code_postal,
    COUNT(a.id_adresse) AS nb_doublons
FROM "address" a
JOIN street s ON a.id_fantoir = s.id_fantoir
JOIN town t ON a.id_commune = t.id_commune
GROUP BY t.nom_commune, s.nom_voie, s.numero, s.code_postal
HAVING COUNT(a.id_adresse) > 1
ORDER BY nb_doublons DESC;

-- ✅ Identifier les adresses incohérentes sans coordonnées GPS

SELECT a.id_adresse,
       s.nom_voie,
       s.numero,
       t.nom_commune,
       g.lon,
       g.lat
FROM "address" a
JOIN street s ON a.id_fantoir = s.id_fantoir
JOIN town t ON a.id_commune = t.id_commune
LEFT JOIN geolocation g ON a.id_geolocalisation = g.id_geolocalisation
WHERE a.id_geolocalisation IS NULL
   OR g.lon IS NULL
   OR g.lat IS NULL;

-- ✅ Lister les codes postaux avec plus de 10 000 adresses pour détecter les anomalies volumétriques.

SELECT s.code_postal,
       t.nom_commune,
       COUNT(a.id_adresse) AS nb_adresses
FROM "address" a
JOIN street s ON a.id_fantoir = s.id_fantoir
JOIN town t ON a.id_commune = t.id_commune
GROUP BY s.code_postal, t.nom_commune
HAVING COUNT(a.id_adresse) > 10000
ORDER BY nb_adresses DESC;

-- ✅ Nombre moyen d’adresses par commune et par voie.

SELECT t.nom_commune,
       COUNT(a.id_adresse)::DECIMAL / COUNT(DISTINCT s.id_fantoir) AS moyenne_adresses_par_voie
FROM "address" a
JOIN street s ON a.id_fantoir = s.id_fantoir
JOIN town t ON a.id_commune = t.id_commune
GROUP BY t.nom_commune
ORDER BY moyenne_adresses_par_voie DESC;

-- ✅ Top 10 des communes avec le plus d’adresses.

SELECT t.nom_commune,
       COUNT(a.id_adresse) AS nb_adresses
FROM "address" a
JOIN town t ON a.id_commune = t.id_commune
GROUP BY t.nom_commune
ORDER BY nb_adresses DESC
LIMIT 10;

-- ✅ Vérifier la complétude des champs essentiels (numéro, voie, code postal, commune).

SELECT a.id_adresse,
       s.numero,
       s.nom_voie,
       s.code_postal,
       t.nom_commune
FROM "address" a
LEFT JOIN street s ON a.id_fantoir = s.id_fantoir
LEFT JOIN town t ON a.id_commune = t.id_commune
WHERE s.numero IS NULL
   OR s.nom_voie IS NULL
   OR s.code_postal IS NULL
   OR t.nom_commune IS NULL;