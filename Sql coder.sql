CREATE TABLE `person` (
  `id` integer PRIMARY KEY,
  `name` varchar(255),
  `dni` integer UNIQUE,
  `dni_verification_digit` integer,
  `age` integer,
  `email` varchar(255),
  `created_at` timestamp
);

CREATE TABLE `doctor` (
  `id` INTEGER PRIMARY KEY,
  `person_id` integer,
  `specialty_id` integer,
  `email` VARCHAR(255),
  `phone_number` VARCHAR(20),
  `created_at` TIMESTAMP
);

CREATE TABLE `specialty` (
  `id` INTEGER PRIMARY KEY,
  `name` VARCHAR(255) UNIQUE,
  `description` TEXT,
  `created_at` TIMESTAMP
);

CREATE TABLE `user` (
  `id` integer PRIMARY KEY,
  `person_id` integer,
  `username` varchar(255),
  `pass` varchar(255),
  `role` varchar(255),
  `created_at` timestamp
);

CREATE TABLE `user_role` (
  `id` INTEGER PRIMARY KEY,
  `role_name` VARCHAR(255) UNIQUE,
  `description` TEXT,
  `created_at` TIMESTAMP
);

CREATE TABLE `session` (
  `id` integer PRIMARY KEY,
  `doctor_id` integer,
  `start_time` timestamp,
  `end_time` timestamp,
  `confirmed_by_doctor` boolean DEFAULT false,
  `available` boolean DEFAULT false,
  `created_at` timestamp
);

CREATE TABLE `session_request` (
  `id` integer PRIMARY KEY,
  `person_id` integer,
  `session_id` integer,
  `confirmed_by_patient` boolean DEFAULT false,
  `created_at` timestamp
);

CREATE TABLE `session_record` (
  `id` integer PRIMARY KEY,
  `session_id` integer,
  `session_date` TIMESTAMP,
  `observations` TEXT,
  `created_at` TIMESTAMP
);

ALTER TABLE `user` ADD FOREIGN KEY (`person_id`) REFERENCES `person` (`id`);

ALTER TABLE `session` ADD FOREIGN KEY (`doctor_id`) REFERENCES `doctor` (`id`);

ALTER TABLE `doctor` ADD FOREIGN KEY (`person_id`) REFERENCES `person` (`id`);

ALTER TABLE `doctor` ADD FOREIGN KEY (`specialty_id`) REFERENCES `specialty` (`id`);

ALTER TABLE `user` ADD FOREIGN KEY (`role`) REFERENCES `user_role` (`role_name`);

ALTER TABLE `session_record` ADD FOREIGN KEY (`session_id`) REFERENCES `session` (`id`);

ALTER TABLE `person` ADD FOREIGN KEY (`id`) REFERENCES `session_request` (`person_id`);

ALTER TABLE `session_request` ADD FOREIGN KEY (`session_id`) REFERENCES `session` (`id`);
