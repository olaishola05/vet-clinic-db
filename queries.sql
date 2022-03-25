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
SELECT visits.vets_id, vets.name, animals.name, visits.date_of_visit from visits LEFT JOIN vets ON vets.vets_id = visits.vets_id
JOIN animals ON animals.id = visits.animals_id WHERE vets.name = 'William Tatcher' ORDER BY date_of_visit DESC LIMIT 1;

SELECT COUNT(visits.vets_id) from visits JOIN vets ON vets.vets_id = visits.vets_id 
JOIN animals AN ON AN.id = visits.animals_id WHERE vets.name = 'Stephanie Mendez';

-- LIst all vets & Specialities including non-specialists
SELECT * FROM vets VT LEFT JOIN specializations SP ON SP.vets_id = VT.vets_id

-- ALL animals that visited Stephanie
SELECT VT.name, VS.visit_id, AN.name, 
AN.id, VS.date_of_visit, 
VT.vets_id from vets VT JOIN visits VS ON VS.vets_id = VT.vets_id 
JOIN animals AN ON AN.id = VS.animals_id WHERE VT.name = 'Stephanie Mendez' AND VS.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- ANimal with most vets visits
SELECT AN.name AS Name, COUNT(VT.animals_id) from visits VT JOIN animals AN ON AN.id = VT.animals_id JOIN vets V ON V.vets_id = VT.vets_id
GROUP BY AN.name;

-- Masy smith first visit
SELECT visits.vets_id, vets.name, animals.name, visits.date_of_visit from visits LEFT JOIN vets ON vets.vets_id = visits.vets_id
JOIN animals ON animals.id = visits.animals_id WHERE vets.name = 'Maisy Smith' ORDER BY date_of_visit LIMIT 1;

-- Recent visit animal details
SELECT VS.date_of_visit, VS.visit_id, AN.name, VT.name, VT.age, VT.date_of_graduation FROM visits VS 
LEFT JOIN animals AN ON AN.id = VS.animals_id RIGHT JOIN vets VT ON VS.vets_id = VT.vets_id ORDER BY date_of_visit DESC LIMIT 6

--  visits with a vet that did not specialize in that animal's species
SELECT COUNT(*) AS number_of_visit_no_specialty from visits VS JOIN vets VT ON VS.vets_id = VT.vets_id
JOIN animals AN ON VS.animals_id = AN.id LEFT JOIN specializations SP ON VT.vets_id = SP.vets_id AND AN.species_id = SP.species_id
LEFT JOIN species SPE ON SPE.species_id = SP.species_id WHERE SP.species_id != AN.species_id OR SPE.name IS NULL

--  Maisy Smith consider specialty 
 SELECT COUNT(SP.species_id) as Visit_Count, SP.name 
    FROM visits VS JOIN animals AN ON VS.animals_id = AN.id 
    JOIN species SP ON AN.species_id = SP.species_id 
    JOIN vets VT ON VS.vets_id = VT.vets_id 
    WHERE VT.name LIKE '%Maisy Smith%' 
    GROUP BY SP.species_id 
    ORDER BY visit_Count DESC 
    LIMIT 1;