CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts int NOT NULL DEFAULT 0,
    neutered boolean NOT NULL DEFAULT false,
    weight_kg float NOT NULL DEFAULT 0,
	PRIMARY KEY (id)
);


CREATE TABLE owners (
    owners_id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR (100) NOT NULL,
    age INT,
    PRIMARY KEY(owners_id)
);

CREATE TABLE species(
    species_id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY(species_id)
);

-- Adding Species column
ALTER TABLE animals ADD COLUMN species varchar(100);
ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals 
ADD species_id INT, 
ADD owners_id INT,
ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(species_id) ON DELETE CASCADE,
ADD CONSTRAINT fk_owners FOREIGN KEY (owners_id) REFERENCES owners (owners_id) ON DELETE CASCADE


-- Create Table Vets
CREATE TABLE vets (
    vets_id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR (100) NOT NULL,
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY(vets_id)
);

-- create table specicializions
CREATE TABLE specializations (
    species_id bigint NOT NULL,
    vets_id bigint NOT NULL,
    FOREIGN KEY (species_id) REFERENCES species (species_id) ON DELETE  RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (vets_id) REFERENCES vets (vets_id) ON DELETE  RESTRICT ON UPDATE CASCADE,
    PRIMARY KEY (species_id, vets_id)
);

-- create table visits
CREATE TABLE visits (
    visit_id INT GENERATED ALWAYS AS IDENTITY,
    vets_id bigint NOT NULL,
    animals_id bigint NOT NULL,
    date_of_visit DATE,
    FOREIGN KEY (animals_id) REFERENCES animals (id) ON DELETE  RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (vets_id) REFERENCES vets (vets_id) ON DELETE  RESTRICT ON UPDATE CASCADE
    PRIMARY KEY (visit_id, vets_id, animals_id)
);