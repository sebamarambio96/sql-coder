CREATE TABLE `person` (
  `id` integer AUTO_INCREMENT PRIMARY KEY,
  `name` varchar(255),
  `dni` integer UNIQUE,
  `dni_verification_digit` integer,
  `age` integer,
  `email` varchar(255),
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `doctor` (
  `id` INTEGER AUTO_INCREMENT PRIMARY KEY,
  `person_id` integer,
  `specialty_id` integer,
  `email` VARCHAR(255),
  `phone_number` VARCHAR(20),
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `specialty` (
  `id` INTEGER AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(255) UNIQUE,
  `description` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `user` (
  `id` integer AUTO_INCREMENT PRIMARY KEY,
  `person_id` integer,
  `username` varchar(255),
  `pass` varchar(255),
  `role` varchar(255),
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `user_role` (
  `id` INTEGER AUTO_INCREMENT PRIMARY KEY,
  `role_name` VARCHAR(255) UNIQUE,
  `description` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `session` (
  `id` integer AUTO_INCREMENT PRIMARY KEY,
  `doctor_id` integer,
  `start_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `end_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `confirmed_by_doctor` boolean DEFAULT false,
  `available` boolean DEFAULT false,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `session_request` (
  `id` integer AUTO_INCREMENT PRIMARY KEY,
  `person_id` integer,
  `session_id` integer,
  `confirmed_by_patient` boolean DEFAULT false,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `session_record` (
  `id` integer AUTO_INCREMENT PRIMARY KEY,
  `session_id` integer,
  `session_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `observations` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE `user` ADD FOREIGN KEY (`person_id`) REFERENCES `person` (`id`);

ALTER TABLE `session` ADD FOREIGN KEY (`doctor_id`) REFERENCES `doctor` (`id`);

ALTER TABLE `doctor` ADD FOREIGN KEY (`person_id`) REFERENCES `person` (`id`);

ALTER TABLE `doctor` ADD FOREIGN KEY (`specialty_id`) REFERENCES `specialty` (`id`);

ALTER TABLE `user` ADD FOREIGN KEY (`role`) REFERENCES `user_role` (`role_name`);

ALTER TABLE `session_record` ADD FOREIGN KEY (`session_id`) REFERENCES `session` (`id`);

ALTER TABLE `session_request` ADD FOREIGN KEY (`person_id`) REFERENCES `person` (`id`);

ALTER TABLE `session_request` ADD FOREIGN KEY (`session_id`) REFERENCES `session` (`id`);

-- Inserts para la tabla 'person'
INSERT INTO person (id, name, dni, dni_verification_digit, age, email, created_at) VALUES
(1, 'John Doe', 12345678, 5, 35, 'johndoe@example.com', '2023-06-01 12:00:00'),
(2, 'Jane Smith', 87654321, 3, 28, 'janesmith@example.com', '2023-06-02 13:00:00'),
(3, 'Alice Johnson', 11223344, 1, 30, 'alicejohnson@example.com', '2023-06-03 14:00:00'),
(4, 'Bob Brown', 22334455, 2, 40, 'bobbrown@example.com', '2023-06-04 15:00:00'),
(5, 'Charlie Black', 33445566, 6, 45, 'charlieblack@example.com', '2023-06-05 16:00:00'),
(6, 'Diana White', 44556677, 4, 29, 'dianawhite@example.com', '2023-06-06 17:00:00'),
(7, 'Edward Green', 55667788, 7, 50, 'edwardgreen@example.com', '2023-06-07 18:00:00'),
(8, 'Fiona Blue', 66778899, 9, 36, 'fionablue@example.com', '2023-06-08 19:00:00'),
(9, 'George Red', 77889900, 0, 33, 'georgered@example.com', '2023-06-09 20:00:00'),
(10, 'Hannah Yellow', 88990011, 8, 27, 'hannahyellow@example.com', '2023-06-10 21:00:00');

-- Inserts para la tabla 'specialty'
INSERT INTO specialty (id, name, description, created_at) VALUES
(1, 'Cardiología', 'Especialidad médica que se encarga del estudio, diagnóstico y tratamiento de las enfermedades del corazón y del aparato circulatorio.', '2023-06-01 12:00:00'),
(2, 'Pediatría', 'Rama de la medicina que se dedica al estudio de la infancia y la adolescencia y a su tratamiento.', '2023-06-02 13:00:00'),
(3, 'Dermatología', 'Especialidad médica que se encarga del estudio de la piel, el cabello y las uñas, así como de las enfermedades que los afectan.', '2023-06-03 14:00:00'),
(4, 'Neurología', 'Rama de la medicina que se ocupa del estudio de las enfermedades del sistema nervioso.', '2023-06-04 15:00:00'),
(5, 'Ginecología', 'Especialidad médica que se ocupa de', '2023-06-05 16:00:00'),
(6, 'Oftalmología', 'Rama de la medicina que se encarga del estudio de las enfermedades de los ojos y su tratamiento.', '2023-06-05 16:00:00'),
(7, 'Oncología', 'Rama de la medicina que se ocupa del estudio de los tumores (benignos o malignos), su diagnóstico, tratamiento y seguimiento.', '2023-06-06 17:00:00'),
(8, 'Endocrinología', 'Rama de la medicina que se dedica al estudio de las glándulas de secreción interna (glándulas endocrinas) y al tratamiento de sus enfermedades.', '2023-06-07 18:00:00'),
(9, 'Psiquiatría', 'Rama de la medicina que se dedica al estudio de los trastornos mentales, emocionales y de comportamiento y a su tratamiento.', '2023-06-08 19:00:00'),
(10, 'Traumatología', 'Rama de la medicina que se dedica al estudio de las lesiones del aparato locomotor. Su función es el tratamiento de las enfermedades traumáticas y las patologías congénitas o adquiridas.', '2023-06-09 20:00:00');


-- Inserts para la tabla 'doctor'
INSERT INTO doctor (id, person_id, specialty_id, email, phone_number, created_at) VALUES
(1, 1, 1, 'johndoe@example.com', '1234567890', '2023-06-01 12:00:00'),
(2, 2, 2, 'janesmith@example.com', '2345678901', '2023-06-02 13:00:00'),
(3, 3, 3, 'alicejohnson@example.com', '3456789012', '2023-06-03 14:00:00'),
(4, 4, 4, 'bobbrown@example.com', '4567890123', '2023-06-04 15:00:00'),
(5, 5, 5, 'charlieblack@example.com', '5678901234', '2023-06-05 16:00:00'),
(6, 6, 6, 'dianawhite@example.com', '6789012345', '2023-06-06 17:00:00'),
(7, 7, 7, 'edwardgreen@example.com', '7890123456', '2023-06-07 18:00:00'),
(8, 8, 8, 'fionablue@example.com', '8901234567', '2023-06-08 19:00:00'),
(9, 9, 9, 'georgered@example.com', '9012345678', '2023-06-09 20:00:00'),
(10, 10, 10, 'hannahyellow@example.com', '0123456789', '2023-06-10 21:00:00');

-- Inserts para la tabla 'user_role'
INSERT INTO user_role (id, role_name, description, created_at) VALUES
(1, 'doctor', 'Doctor de la institución médica', '2023-06-01 12:00:00'),
(2, 'paciente', 'Paciente de la institución médica', '2023-06-01 12:00:00');

-- Inserts para la tabla 'user'
INSERT INTO user (id, person_id, username, pass, role, created_at) VALUES
(1, 1, 'johndoe', 'password', 'doctor', '2023-06-01 12:00:00'),
(2, 2, 'janesmith', 'password', 'paciente', '2023-06-02 13:00:00'),
(3, 3, 'alicejohnson', 'password', 'doctor', '2023-06-03 14:00:00'),
(4, 4, 'bobbrown', 'password', 'paciente', '2023-06-04 15:00:00'),
(5, 5, 'charlieblack', 'password', 'doctor', '2023-06-05 16:00:00'),
(6, 6, 'dianawhite', 'password', 'paciente', '2023-06-06 17:00:00'),
(7, 7, 'edwardgreen', 'password', 'doctor', '2023-06-07 18:00:00'),
(8, 8, 'fionablue', 'password', 'paciente', '2023-06-08 19:00:00'),
(9, 9, 'georgered', 'password', 'doctor', '2023-06-09 20:00:00'),
(10, 10, 'hannahyellow', 'password', 'paciente', '2023-06-10 21:00:00');

-- Inserts para la tabla 'session'
INSERT INTO session (id, doctor_id, start_time, end_time, confirmed_by_doctor, available, created_at) VALUES
(1, 1, '2023-07-01 09:00:00', '2023-07-01 10:00:00', true, false, '2023-06-01 12:00:00'),
(2, 2, '2023-07-02 10:00:00', '2023-07-02 11:00:00', true, false, '2023-06-02 13:00:00'),
(3, 3, '2023-07-03 11:00:00', '2023-07-03 12:00:00', false, true, '2023-06-03 14:00:00'),
(4, 4, '2023-07-04 12:00:00', '2023-07-04 13:00:00', false, true, '2023-06-04 15:00:00'),
(5, 5, '2023-07-05 13:00:00', '2023-07-05 14:00:00', true, false, '2023-06-05 16:00:00'),
(6, 6, '2023-07-06 14:00:00', '2023-07-06 15:00:00', false, true, '2023-06-06 17:00:00'),
(7, 7, '2023-07-07 15:00:00', '2023-07-07 16:00:00', true, false, '2023-06-07 18:00:00'),
(8, 8, '2023-07-08 16:00:00', '2023-07-08 17:00:00', false, true, '2023-06-08 19:00:00'),
(9, 9, '2023-07-09 17:00:00', '2023-07-09 18:00:00', true, false, '2023-06-09 20:00:00'),
(10, 10, '2023-07-10 18:00:00', '2023-07-10 19:00:00', false, true, '2023-06-10 21:00:00');

-- Inserts para la tabla 'session_request'
INSERT INTO session_request (id, person_id, session_id, confirmed_by_patient, created_at) VALUES
(1, 2, 1, true, '2023-06-01 12:00:00'),
(2, 4, 2, false, '2023-06-02 13:00:00'),
(3, 6, 3, true, '2023-06-03 14:00:00'),
(4, 8, 4, false, '2023-06-04 15:00:00'),
(5, 10, 5, true, '2023-06-05 16:00:00'),
(6, 1, 6, false, '2023-06-06 17:00:00'),
(7, 3, 7, true, '2023-06-07 18:00:00'),
(8, 5, 8, false, '2023-06-08 19:00:00'),
(9, 7, 9, true, '2023-06-09 20:00:00'),
(10, 9, 10, false, '2023-06-10 21:00:00');

-- Inserts para la tabla 'session_record'
INSERT INTO session_record (id, session_id, session_date, observations, created_at) VALUES
(1, 1, '2023-07-01', 'Paciente con presión arterial alta.', '2023-06-01 12:00:00'),
(2, 2, '2023-07-02', 'Paciente con fiebre y tos.', '2023-06-02 13:00:00'),
(3, 3, '2023-07-03', 'Paciente con erupción cutánea.', '2023-06-03 14:00:00'),
(4, 4, '2023-07-04', 'Paciente con dolor abdominal.', '2023-06-04 15:00:00'),
(5, 5, '2023-07-05', 'Paciente con dolor de cabeza.', '2023-06-05 16:00:00'),
(6, 6, '2023-07-06', 'Paciente con visión borrosa.', '2023-06-06 17:00:00'),
(7, 7, '2023-07-07', 'Paciente con síntomas de depresión.', '2023-06-07 18:00:00'),
(8, 8, '2023-07-08', 'Paciente con problemas de tiroides.', '2023-06-08 19:00:00'),
(9, 9, '2023-07-09', 'Paciente con ansiedad y ataques de pánico.', '2023-06-09 20:00:00'),
(10, 10, '2023-07-10', 'Paciente con fractura de muñeca.', '2023-06-10 21:00:00');
