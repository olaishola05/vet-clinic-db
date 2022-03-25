-- Populating data into Animals Table
INSERT INTO animals (name, date_of_birth, neutered, weight_kg) VALUES ('Agumon', '2020-02-03', true, 10.23);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Gabumon', '2018-11-15', 8, true, 2);
INSERT INTO animals (name, date_of_birth, weight_kg, escape_attempts) VALUES ('Pikachu', '2021-01-07', 15.04, 1);
INSERT INTO animals (name, date_of_birth, weight_kg,neutered, escape_attempts) VALUES ('Devimon', '2017-05-12', 11, true, 5);

-- Adding new Animal to the table
INSERT INTO animals (name, date_of_birth, weight_kg,neutered, escape_attempts) VALUES ('Charmander', '2020-02-08', -11, false, 0);
INSERT INTO animals (name, date_of_birth, weight_kg,neutered, escape_attempts) VALUES ('Plantmon', '2021-11-15', -5.7, true, 2);
INSERT INTO animals (name, date_of_birth, weight_kg,neutered, escape_attempts) VALUES ('Squirtle', '1993-04-02', -12.13, false, 3);
INSERT INTO animals (name, date_of_birth, weight_kg,neutered, escape_attempts) VALUES ('Angemon', '2005-06-12', -45, true, 1);
INSERT INTO animals (name, date_of_birth, weight_kg,neutered, escape_attempts) VALUES ('Boarmon', '2005-06-07', 20, true, 7);
INSERT INTO animals (name, date_of_birth, weight_kg,neutered, escape_attempts) VALUES ('Blossom', '1998-10-13', 17, true, 3);
INSERT INTO animals (name, date_of_birth, weight_kg,neutered, escape_attempts) VALUES ('Ditto', '2022-05-14', 22, true, 4);


-- Adding info to owners table
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);


INSERT INTO species(name) VALUES('Pokemon');
INSERT INTO species(name) VALUES('Digimon');


UPDATE animals SET species_id = species.species_id FROM species WHERE animals.name LIKE '%mon' AND species.name = 'Digimon'
UPDATE animals SET species_id = species.species_id FROM species WHERE animals.name NOT LIKE '%mon' AND species.name = 'Pokemon'

UPDATE animals SET owners_id = owners.owners_id FROM owners WHERE animals.name = 'Agumon' AND owners.full_name = 'Sam Smith';
UPDATE animals SET owners_id = owners.owners_id FROM owners WHERE animals.name IN ('Gabumon', 'Pikachu') AND owners.full_name = 'Jennifer Orwell';
UPDATE animals SET owners_id = owners.owners_id FROM owners WHERE animals.name IN ('Devimon', 'Plantmon') AND owners.full_name = 'Bob';
UPDATE animals SET owners_id = owners.owners_id FROM owners WHERE animals.name IN ('Charmander', 'Squirtle', 'Blossom') AND owners.full_name = 'Melody Pond';
UPDATE animals SET owners_id = owners.owners_id FROM owners WHERE animals.name IN ('Angemon', 'Boarmon') AND owners.full_name = 'Dean Winchester';


-- Populating Vets
INSERT INTO vets (name, age, date_of_graduation) VALUES ('William Tatcher',45, '2000-03-23');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Maisy Smith',26, '2019-01-17');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Stephanie Mendez',64, '1981-05-04');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Jack Harkness', 38, '2008-06-08');


INSERT INTO specializations VALUES (1, 1);
INSERT INTO specializations VALUES (2, 3);
INSERT INTO specializations VALUES (1, 3);
INSERT INTO specializations VALUES (2, 4);

INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (1,1,'2020-05-24');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (1,3,'2020-07-22');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (2,4,'2021-02-02');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (3,2,'2020-01-05');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (3,2,'2020-03-08');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (3,2,'2020-05-14');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (4,3,'2021-05-04');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (5,4,'2021-02-24');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (6,2,'2019-12-21');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (6,1,'2020-08-10');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (6,2,'2021-04-07');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (7,3,'2019-09-29');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (8,4,'2020-10-03');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (8,4,'2020-11-04');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (9,2,'2019-01-24');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (9,2,'2019-05-15');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (9,2,'2020-02-27');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (9,2,'2020-08-03');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (10,3,'2020-05-24');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (10,1,'2021-01-11');

