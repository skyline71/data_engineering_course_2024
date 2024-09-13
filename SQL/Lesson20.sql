-- Lesson 20: CREATE TABLE, data types, PK, FK



CREATE TABLE patients(
	patient_id serial,
	name varchar(50),
	surname varchar(50),
	policy_number varchar(11) NOT NULL DEFAULT '00000000000',
	birth_date date,
	create_time timestamp DEFAULT now(),
	modify_time timestamp DEFAULT now(),
	PRIMARY KEY (patient_id)
);

INSERT INTO patients(name, surname, policy_number, birth_date)
VALUES('Ivan', 'Ivanov', '12345678910', '2000-01-01'),
('Petr', 'Petrov', '78965412311', '1988-05-10')

CREATE TABLE doctors(
	doctor_id serial,
	name varchar(50),
	surname varchar(50),
	badge_number varchar(6) NOT NULL DEFAULT '000000',
	birth_date date,
	create_time timestamp DEFAULT now(),
	modify_time timestamp DEFAULT now(),
	PRIMARY KEY (doctor_id)
);

INSERT INTO doctors(name, surname, badge_number, birth_date)
VALUES('Vasiliy', 'Petrov', '654321', '1960-01-02'),
('Semen', 'Ivanov', '123123', '1984-11-30'),
('Elena', 'Berk', '564325', '1999-04-25'),
('Nikita', 'Pivovarov', '998843', '1976-09-09'),
('Anton', 'Yashin', '743208', '1954-08-05'),
('Roman', 'Dmitriev', '000034', '1977-04-20')


CREATE TABLE receptions(
	reception_id serial,
	patient_id serial,
	doctor_id serial,
	diagnosis varchar(100) DEFAULT NULL,
	create_time timestamp DEFAULT now(),
	modify_time timestamp DEFAULT now(),
	PRIMARY KEY (reception_id),
	FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
	FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);


SELECT *
FROM patients;

SELECT *
FROM doctors;

SELECT *
FROM receptions;







