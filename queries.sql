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

-- COUNTS
SELECT COUNT(id) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts <= 0;
SELECT AVG(weight_kg) FROM animals;

SELECT neutered, SUM(escape_attempts) FROM animals WHERE neutered = true OR neutered = false GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

SELECT species,
    SUM(escape_attempts),
    COUNT(escape_attempts),
    SUM(escape_attempts) / COUNT(escape_attempts) as Average FROM animals WHERE extract(YEAR FROM date_of_birth) BETWEEN 1990 AND 2000 GROUP BY species;

-- Joining Tables

SELECT AN.name, date_of_birth, escape_attempts, 
neutered,weight_kg, species_id, O.owners_id AS "OWNERS ID", full_name FROM animals AN 
JOIN owners O ON O.owners_id = AN.owners_id WHERE O.full_name = 'Melody Pond'

SELECT * FROM animals AS AN 
JOIN species S ON S.species_id = AN.species_id
WHERE S.name = 'Pokemon'

SELECT * FROM owners O LEFT JOIN animals AN ON AN.owners_id = O.owners_id
SELECT S.name, COUNT(AN.species_id) FROM animals AN 
LEFT JOIN species S on S.species_id = AN.species_id GROUP BY S.name;

SELECT * FROM animals AN JOIN owners O ON O.owners_id = AN.owners_id 
WHERE O.full_name = 'Jennifer Orwell';

SELECT * FROM animals AN JOIN owners O ON O.owners_id = AN.owners_id 
WHERE O.full_name = 'Dean Winchester' AND AN.escape_attempts <= 0;

SELECT O.full_name, COUNT(O.owners_id) FROM animals AN 
LEFT JOIN owners O ON O.owners_id = AN.owners_id GROUP BY O.full_name ORDER BY COUNT(*) DESC;


-- MANY-TO-MANY
-- SELECT AN.name, VS.date_of_visit FROM animals AN LEFT JOIN visits VS ON (AN.id = VS.animals_id)
-- JOIN specializations SP ON (SP.vets_id = VS.vets_id)
-- GROUP BY AN.name

-- Last Animal seen by Thatcher
SELECT visits.vets_id, vets.animals_id, animals.name, visits.date_of_visit from visits LEFT JOIN vets ON vets.vets_id = visits.vets_id
JOIN animals ON animals.id = visits.animals_id WHERE vets.name = 'William Tatcher' ORDER BY date_of_visit DESC LIMIT 1;

SELECT COUNT(visits.vets_id) from visits JOIN vets ON vets.vets_id = visits.vets_id 
JOIN animals AN ON AN.id = visits.animals_id WHERE vets.name = 'Stephanie Mendez';

-- LIst all vets & Specialities including non-specialists
SELECT * FROM vets VT LEFT JOIN specializations SP ON SP.vets_id = VT.vets_id

-- ALL animals that visited Stephanie
SELECT VT.name, VS.visit_id, AN.name, 
AN.id, VS.date_of_visit, 
VT.vets_id from vets VT JOIN visits VS ON VS.vets_id = VT.vets_id 
JOIN animals AN ON AN.id = VS.animals_id WHERE VT.name = 'Stephanie Mendez';

-- ANimal with most vets visits
SELECT AN.name AS Name, COUNT(VT.animals_id) from visits VT JOIN animals AN ON AN.id = VT.animals_id JOIN vets V ON V.vets_id = VT.vets_id
GROUP BY AN.name;