-- Créer des index sur les champs les plus sollicités.

CREATE INDEX idx_town_nom_commune ON town(nom_commune);

CREATE INDEX idx_street_nom_voie ON street(nom_voie);

CREATE INDEX idx_street_code_postal ON street(code_postal);

CREATE INDEX idx_commune_voie ON street(nom_voie, code_postal);

-- Comparer les temps d’exécution avant et après indexation.

-- avant indexation :
EXPLAIN ANALYZE
SELECT a.id_adresse, s.nom_voie, t.nom_commune
FROM "address" a
JOIN street s ON a.id_fantoir = s.id_fantoir
JOIN town t ON a.id_commune = t.id_commune
WHERE t.nom_commune = 'Oze';

-- indexation du champ "nom_commune"
CREATE INDEX idx_town_nom_commune ON town(nom_commune);

-- après indexation :
EXPLAIN ANALYZE
SELECT a.id_adresse, s.nom_voie, t.nom_commune
FROM "address" a
JOIN street s ON a.id_fantoir = s.id_fantoir
JOIN town t ON a.id_commune = t.id_commune
WHERE t.nom_commune = 'Oze';

-- Optionnel : tester l’impact de la normalisation sur la taille et la lisibilité de la base.