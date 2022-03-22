UPDATE animals SET name = 'Pikachu' WHERE date_of_birth = '2021-01-07'; 
SELECT * from animals WHERE name like "%mon"
SELECT * from animals where extract(YEAR FROM date_of_birth) BETWEEN 2016 AND 2019;
SELECT * FROM animals where neutered = true AND escape_attempts < 3;
SELECT date_of_birth AS "Date of Birth" FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE NOT name = 'Gabumon'
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;


-- Setting species column to unspecified

BEGIN;

UPDATE animals SET species = 'unspecified' WHERE species IS NULL;

ROLLBACK;

BEGIN;

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

COMMIT;

-- DELETE ALL ITEMS FROM THE TABLE IN A TRANSACTION

BEGIN;

DELETE FROM animals;

ROLLBACK;


BEGIN;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';

SAVEPOINT animals_deleted;

UPDATE animals SET weight_kg = weight_kg * - 1;

ROLLBACK TO animals_deleted;

UPDATE animals SET weight_kg = weight_kg * - 1 WHERE weight_kg < 0;

COMMIT;
