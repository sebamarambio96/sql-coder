-- Funciones

-- Calcula el tiempo que se demoran las sesiones, importante para poder gestionar el tiempo de mejor manera.
DELIMITER //

CREATE FUNCTION get_patient_session_requests(p_person_id INTEGER)
RETURNS INTEGER
BEGIN
    DECLARE session_requests INTEGER;
    
    SELECT COUNT(*) INTO session_requests FROM session_request WHERE person_id = p_person_id;
    
    RETURN session_requests;
END//

DELIMITER ;

-- Cantidad de sesiones por doctor: Utilizaremos esta función para mostrar calcular cuales doctores son los que más trabajan en el centro
DELIMITER //

CREATE FUNCTION get_session_count(p_doctor_id INTEGER)
RETURNS INTEGER
BEGIN
    DECLARE session_count INTEGER;
    SELECT COUNT(*) INTO session_count FROM session WHERE doctor_id = p_doctor_id;
    RETURN session_count;
END//

-- Vistas

-- Solicitudes de sesiones por pacientes
CREATE VIEW patient_session_requests AS
SELECT person.id AS person_id, get_patient_session_requests(person.id) AS session_requests
FROM person;

-- Cantidad de sesiones por doctor
CREATE VIEW doctor_count_sessions AS
SELECT
    d.id AS doctor_id,
    p.name AS doctor_name,
    get_session_count(d.id) AS session_count
FROM
    doctor d
JOIN
    person p ON d.person_id = p.id;

-- Muestra los roles de los usuarios
CREATE VIEW user_roles AS
SELECT
    u.id AS user_id,
    p.name AS user_name,
    u.username,
    ur.role_name,
    ur.description AS role_description,
    u.created_at AS user_created_at
FROM
    user u
JOIN
    person p ON u.person_id = p.id
JOIN
    user_role ur ON u.role = ur.role_name;


-- Muestra las sesiones de los doctores
CREATE VIEW doctor_sessions AS
SELECT
    d.id AS doctor_id,
    p.name AS doctor_name,
    s.id AS session_id,
    s.start_time,
    s.end_time,
    s.confirmed_by_doctor,
    s.available,
    s.created_at AS session_created_at
FROM
    doctor d
JOIN
    person p ON d.person_id = p.id
JOIN
    session s ON d.id = s.doctor_id;

-- Stored Procedures

-- Aprobar solicitud de sesión, está función facilita enormemente la aprovación de sesiones por parte de los doctores
DELIMITER //

CREATE PROCEDURE confirm_by_patient(
    IN p_request_id INTEGER
)
BEGIN
    UPDATE session_request
    SET confirmed_by_patient = TRUE
    WHERE id = p_request_id;
END//

DELIMITER ;

-- Crear solicitud de sesió, está función agiliza la creación de sesiones por parte de la gestión del centro
DELIMITER //

CREATE PROCEDURE create_session(
    IN p_doctor_id INTEGER,
    IN p_start_time TIMESTAMP,
    IN p_end_time TIMESTAMP,
    IN p_confirmed_by_doctor BOOLEAN,
    IN p_available BOOLEAN
)
BEGIN
    INSERT INTO session (doctor_id, start_time, end_time, confirmed_by_doctor, available)
    VALUES (p_doctor_id, p_start_time, p_end_time, p_confirmed_by_doctor, p_available);
END//

DELIMITER ;

-- Triggers
-- Registrar una registro de sesión cada vez que se inserta un nuevo registro en la tabla session:
DELIMITER //

CREATE TRIGGER create_session_record AFTER INSERT ON session
FOR EACH ROW
BEGIN
    INSERT INTO session_record (session_id, session_date, observations, created_at)
    VALUES (NEW.id, NEW.start_time, 'Ingrese observación aquí', CURRENT_TIMESTAMP);
END//

DELIMITER ;

-- Registrar un nuevo usuario cuando se inserta un nuevo registro en la tabla person

DELIMITER //

CREATE TRIGGER create_user_after_person_insert AFTER INSERT ON person
FOR EACH ROW
BEGIN
    INSERT INTO user (person_id, username, pass, role, created_at)
    VALUES (NEW.id, CONCAT('user_', NEW.id), 'default_password', 'paciente', CURRENT_TIMESTAMP);
END//

DELIMITER ;