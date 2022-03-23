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
)

-- Adding Species column
ALTER TABLE animals ADD COLUMN species varchar(100);
ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD CONSTRAINT species_id FOREIGN KEY (species_id) REFERENCES species (species_id) ON DELETE CASCADE;