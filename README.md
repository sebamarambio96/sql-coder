### Proyecto coder SQL

**Razón del Proyecto:**
Me gustaría desarrollar un sistema donde mi esposa pueda registrar las fichas de sus pacientes y donde los pacientes puedan reservar sus citas disponibles.

**Necesidades a Suplir:**
- Gestión de horas de pacientes.
- Registro de pacientes.
- Registro de expedientes.
- Gestión de pagos de sesiones.
### Person

Registra los datos de las personas para ser asociados a distintas tablas como doctor y usuario, su objetivo es guardar la información personal de las personas pertenecientes al sistema.

| Columna               | Tipo        | Restricciones                  |
|-----------------------|-------------|--------------------------------|
| id                    | integer     | PRIMARY KEY                    |
| name                  | varchar(255)|                                |
| dni                   | integer     | UNIQUE                         |
| dni_verification_digit| integer     |                                |
| age                   | integer     |                                |
| email                 | varchar(255)|                                |
| created_at            | timestamp   |                                |

### Doctor

Registra el personal medico que podría estar disponible.

| Columna               | Tipo        | Restricciones                  |
|-----------------------|-------------|--------------------------------|
| id                    | integer     | PRIMARY KEY                    |
| person_id             | integer     | FOREIGN KEY (person_id) REFERENCES person(id) |
| specialty_id          | integer     | FOREIGN KEY (specialty_id) REFERENCES specialty(id) |
| email                 | varchar(255)|                                |
| phone_number          | varchar(20) |                                |
| created_at            | timestamp   |                                |

### Specialty

Registra los tipos de especialidades disponibles en el centro medico

| Columna               | Tipo        | Restricciones                  |
|-----------------------|-------------|--------------------------------|
| id                    | integer     | PRIMARY KEY                    |
| name                  | varchar(255)| UNIQUE                         |
| description           | text        |                                |
| created_at            | timestamp   |                                |

### User

Registra las credenciales usadas en el sistema

| Columna               | Tipo        | Restricciones                  |
|-----------------------|-------------|--------------------------------|
| id                    | integer     | PRIMARY KEY                    |
| person_id             | integer     | FOREIGN KEY (person_id) REFERENCES person(id) |
| username              | varchar     |                                |
| pass                  | varchar     |                                |
| role                  | varchar     | FOREIGN KEY (role) REFERENCES user_role(role_name) |
| created_at            | timestamp   |                                |

### User_role

Registra los tipos de roles de usuarios disponibles como: paciente, doctor, admin,etc

| Columna               | Tipo        | Restricciones                  |
|-----------------------|-------------|--------------------------------|
| role_name             | varchar(255)| PRIMARY KEY                    |
| description           | text        |                                |
| created_at            | timestamp   |                                |

### Session

Registra las horas disponibles de sesiones medicas.

| Columna               | Tipo        | Restricciones                  |
|-----------------------|-------------|--------------------------------|
| id                    | integer     | PRIMARY KEY                    |
| doctor_id             | integer     | FOREIGN KEY (doctor_id) REFERENCES doctor(id) |
| start_time            | timestamp   |                                |
| end_time              | timestamp   |                                |
| confirmed_by_doctor   | boolean     | DEFAULT: false                 |
| available             | boolean     | DEFAULT: false                 |
| created_at            | timestamp   |                                |

### Session_request

Registra las peticiones de sesiones por parte de pacientes.

| Columna               | Tipo        | Restricciones                  |
|-----------------------|-------------|--------------------------------|
| id                    | integer     | PRIMARY KEY                    |
| person_id             | integer     | FOREIGN KEY (person_id) REFERENCES person(id) |
| session_id            | integer     | FOREIGN KEY (session_id) REFERENCES session(id) |
| confirmed_by_patient  | boolean     | DEFAULT: false                 |
| created_at            | timestamp   |                                |

### Session_record

Registra la ficha medica, como detalles de la sesion y anotaciones del medico.

| Columna               | Tipo        | Restricciones                  |
|-----------------------|-------------|--------------------------------|
| id                    | integer     | PRIMARY KEY                    |
| session_id            | integer     | FOREIGN KEY (session_id) REFERENCES session(id) |
| session_date          | timestamp   |                                |
| observations          | text        |                                |
| created_at            | timestamp   |                                |


### Diagrama

![SQL Coder Image](https://www.dropbox.com/scl/fi/dkgl930qsvzpnmjl7hrfi/Sql-coder-1.png?rlkey=c0hr8vpseer7802jshs6ceoa5&st=4kdixzb7&=0&raw=1)

## Seeders
En la creación de la tabla se incluyen datos a insertar pero de todas maneras para practicar he creado archivos `JSON` para importar datos.

A continuación detallaré como importar datos de los archivos `JSON` que adjuntaré a la documentación del proyecto.

### Instrucciones

1. Abrir worbench, seleccionar una tabla y abrir la herramienta "Import record from external file".
2. Encontrar el archivo `JSON` que contiene la información de la tabla seleccionada.
3. Ahora seleccionar la tabla y seleccionar tabla existente.
4. Luego apretar "Next" hasta que se genere la importación, revisar que se hayan insertado 10 rows.

A continuación el orden en el que deben importarse los archivos:
1. `SpecialtySeeder`
2. `UserRoleSeeder`
3. `PersonSeeder`
4. `DoctorSeeder`
5. `UserSeeder`
6. `SessionSeeder`
7. `SessionRequestSeeder`
8. `SessionRecordSeeder`

**Considerar**: Aplicar estas importaciones antes de configurar los triggers.

