CREATE DATABASE bddban;

DROP TABLE IF EXISTS parcel_address CASCADE;
DROP TABLE IF EXISTS "address" CASCADE;
DROP TABLE IF EXISTS geolocation CASCADE;
DROP TABLE IF EXISTS street CASCADE;
DROP TABLE IF EXISTS town CASCADE;
DROP TABLE IF EXISTS parcel CASCADE;

CREATE TABLE parcel (
    id_parcelle SERIAL PRIMARY KEY,
    cad_parcelle TEXT NOT NULL
);

CREATE TABLE town (
    id_commune SERIAL PRIMARY KEY,
    code_insee VARCHAR(5) NOT NULL UNIQUE,
    nom_commune VARCHAR(50),
    code_insee_ancienne_commune VARCHAR(5),
    nom_ancienne_commune VARCHAR(50),
    certification_commune BOOLEAN NOT NULL,
    libelle_acheminement VARCHAR(50)
);

CREATE TABLE street (
    id_fantoir SERIAL PRIMARY KEY,
    numero INT,
    nom_voie VARCHAR(50) NOT NULL,
    code_postal INT NOT NULL,
    nom_afnor VARCHAR(50),
    source_nom_voie VARCHAR(50)
);

CREATE TABLE geolocation (
    id_geolocalisation SERIAL PRIMARY KEY,
    x DOUBLE PRECISION NOT NULL,
    y DOUBLE PRECISION NOT NULL,
    lon DOUBLE PRECISION NOT NULL,
    lat DOUBLE PRECISION NOT NULL,
    type_position VARCHAR(50),
    source_position VARCHAR(50)
);

CREATE TABLE "address" (
    id_adresse SERIAL PRIMARY KEY,
    rep VARCHAR(20),
    alias TEXT,
    nom_ld TEXT,
    id_fantoir INT,
    id_commune INT,
    id_geolocalisation INT,
    CONSTRAINT fk_id_fantoir FOREIGN KEY (id_fantoir)
        REFERENCES street (id_fantoir) ON DELETE CASCADE,
    CONSTRAINT fk_id_commune FOREIGN KEY (id_commune)
        REFERENCES town (id_commune) ON DELETE CASCADE,
    CONSTRAINT fk_id_geolocalisation FOREIGN KEY (id_geolocalisation)
        REFERENCES geolocation (id_geolocalisation) ON DELETE CASCADE
);

CREATE TABLE parcel_address (
    id_parcelle INT NOT NULL,
    id_adresse INT NOT NULL,
    PRIMARY KEY (id_parcelle, id_adresse),
    CONSTRAINT fk_id_parcelle FOREIGN KEY (id_parcelle)
        REFERENCES parcel (id_parcelle) ON DELETE CASCADE,
    CONSTRAINT fk_id_adresse FOREIGN KEY (id_adresse)
        REFERENCES address (id_adresse) ON DELETE CASCADE
);
