CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts int NOT NULL DEFAULT 0,
    neutered boolean NOT NULL DEFAULT false,
    weight_kg float NOT NULL DEFAULT 0,
	PRIMARY KEY (id)
);
