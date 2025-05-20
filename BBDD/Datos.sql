#Karla Trejo Delgadillo, Luis Lagos Camacho y Swietenia Medina Gasca - Proyecto
#Base de datos de un centro de ejercicio

#Script para insertar valores en las tablas

USE CentroEjercicio;

INSERT INTO TipoUsuario (Tipo) Values
('Administrador'),
('Encargado'),
('Coach'),
('Cliente');

SELECT * FROM tipoUsuario;

INSERT INTO Usuarios (Usuario, Contraseña, Tipo) VALUES
('admin1', 'pass123', 1 ),
('encargado1', 'pas123',2),
('encargado2', 'pas123',2),
('coach1', 'pass456', 3 ),
('coach2', 'pass789', 3 ),
('coach3', 'pass896', 3 ),
('coach4', 'pass006', 3 ),
('coach5', 'pass345', 3 ),
('coach6', 'pass234', 3 ),
('coach7', 'pass234', 3 ),
('coach8', 'pass234', 3 ),
('cliente1', 'password1', 4 ),
('cliente2', 'password2', 4),
('cliente3', 'password3', 4),
('cliente4', 'password4', 4),
('cliente5', 'password5', 4),
('cliente6', 'password6', 4),
('cliente7', 'password7', 4),
('cliente8', 'password8', 4),
('cliente9', 'password9', 4),
('cliente10', 'password10', 4),
('cliente11', 'password11', 4),
('cliente12', 'password12', 4),
('cliente13', 'password13', 4),
('cliente14', 'password14', 4),
('cliente15', 'password15', 4),
('cliente16', 'password16', 4),
('cliente17', 'password17', 4),
('cliente18', 'password18', 4),
('cliente19', 'password19', 4),
('cliente20', 'password20', 4);

SELECT * FROM Usuarios;

INSERT INTO Especialidad (NombreEspecialidad, Descripcion) VALUES
('Pilates Reformer', 'Fortalece tu núcleo y mejora tu postura, con la ayuda de una máquina especializada. 
Ejercicios adaptables para todos los niveles.'),
('Pilates Mat', 'Entrena con tu propio peso corporal en colchonetas. Mejora el control, la alineación y 
la flexibilidad en cada sesión.'),
('Pilates Springboard', 'Desafía tu cuerpo, con una tabla y resortes. Trabaja fuerza y estabilidad a través
de ejercicios dinámicos y variados.'),
('Barre', 'Tonifica y fortalece con movimientos inspirados en el ballet. Utiliza barras para mejorar tu postura
 y flexibilidad mientras te diviertes.'),
('Yoga','Conéctate contigo mismo a través de posturas, respiración y meditación. Encuentra equilibrio y bienestar
 en nuestros diversos estilos.'),
('Spinning','Siente la energía del ciclismo en interiores. Mejora tu condición cardiovascular y tonifica tus piernas
 con música motivadora y un instructor que te guía.');
SELECT * FROM Especialidad;

INSERT INTO Coach (NombreCoach, ApellidoPaterno, ApellidoMaterno, FechaNacimiento, Telefono, FechaContratacion, Email, IdUsuario) VALUES
('Carlos', 'Pérez', 'Ramírez', '1985-03-15', '5551234567', '2021-01-10', 'carlos.perez@example.com', 2),
('Ana', 'López', 'García', '1990-07-20', '5552345678', '2020-05-15', 'ana.lopez@example.com', 3),
('Luis', 'Hernández', 'Martínez', '1988-09-10', '5553456789', '2022-03-01', 'luis.hernandez@example.com', 4),
('María', 'Gómez', 'Sánchez', '1992-11-25', '5554567890', '2019-10-20', 'maria.gomez@example.com', 5),
('Roberto', 'Díaz', 'Jiménez', '1986-01-05', '5555678901', '2018-12-05', 'roberto.diaz@example.com', 6),
('Lucía', 'Torres', 'Vega', '1994-06-18', '5556789012', '2023-02-15', 'lucia.torres@example.com', 7),
('Carlos', 'Gomez', 'Sanchez', '1985-02-15', '1234567890', '2022-01-10', 'carlos.gomez@example.com', 8),
('Ana', 'Lopez', 'Martinez', '1990-07-25', '0987654321', '2023-03-05', 'ana.lopez@example.com', 9);
SELECT * FROM Coach;

INSERT INTO CoachEspecialidad (IdCoach, IdEspecialidad) VALUES
(1,1),
(1,2),
(2,2),
(3,2),
(3,3),
(3,4),
(4,1),
(5,5),
(6,6),
(7,1),
(8,2);
SELECT * FROM CoachEspecialidad;


INSERT INTO Clientes (NombreCliente, ApellidoPaterno, ApellidoMaterno, FechaNacimiento, Telefono, Email, IdUsuario, FechaRegistro) VALUES
('Juan', 'Pérez', 'López', '1990-01-15', '555-1234', 'juan.perez@example.com', 1, '2024-01-01'),
('María', 'Gómez', 'Ramírez', '1985-03-22', '555-2345', 'maria.gomez@example.com', 2, '2024-01-02'),
('Carlos', 'Hernández', 'Martínez', '1992-05-10', '555-3456', 'carlos.hernandez@example.com', 3, '2024-01-03'),
('Ana', 'Ruiz', 'Sánchez', '1994-07-18', '555-4567', 'ana.ruiz@example.com', 4, '2024-01-04'),
('Luis', 'Díaz', 'Flores', '1988-09-25', '555-5678', 'luis.diaz@example.com', 5, '2024-01-05'),
('Sofía', 'Morales', 'Jiménez', '1991-11-30', '555-6789', 'sofia.morales@example.com', 6, '2024-01-06'),
('Miguel', 'Ortiz', 'Vargas', '1987-02-14', '555-7890', 'miguel.ortiz@example.com', 7, '2024-01-07'),
('Laura', 'López', 'Mendoza', '1993-04-20', '555-8901', 'laura.lopez@example.com', 8, '2024-01-08'),
('Jorge', 'Ramírez', 'Salazar', '1986-06-15', '555-9012', 'jorge.ramirez@example.com', 9, '2024-01-09'),
('Elena', 'Romero', 'Cruz', '1990-08-10', '555-0123', 'elena.romero@example.com', 10, '2024-01-10'),
('Ricardo', 'Santos', 'Luna', '1995-10-05', '555-1234', 'ricardo.santos@example.com', 11, '2024-01-11'),
('Paula', 'Torres', 'Molina', '1989-12-15', '555-2345', 'paula.torres@example.com', 12, '2024-01-12'),
('Gabriel', 'Castillo', 'Paredes', '1992-03-25', '555-3456', 'gabriel.castillo@example.com', 13, '2024-01-13'),
('Valeria', 'Silva', 'Pérez', '1988-05-18', '555-4567', 'valeria.silva@example.com', 14, '2024-01-14'),
('Diego', 'García', 'Fernández', '1994-07-07', '555-5678', 'diego.garcia@example.com', 15, '2024-01-15'),
('Carmen', 'Soto', 'Blanco', '1985-09-27', '555-6789', 'carmen.soto@example.com', 16, '2024-01-16'),
('Alberto', 'Ramos', 'Campos', '1991-01-19', '555-7890', 'alberto.ramos@example.com', 17, '2024-01-17'),
('Luisa', 'Molina', 'Quintero', '1987-03-03', '555-8901', 'luisa.molina@example.com', 18, '2024-01-18'),
('Esteban', 'Vega', 'Estrada', '1993-06-09', '555-9012', 'esteban.vega@example.com', 19, '2024-01-19'),
('Mónica', 'Herrera', 'Guerrero', '1989-08-21', '555-0123', 'monica.herrera@example.com', 20, '2024-01-20');

SELECT * FROM Clientes;

INSERT INTO Administrador (NombreAdmin, ApellidoPaterno, ApellidoMaterno, FechaNacimiento, Telefono, FechaContratacion, Email, IdUsuario) VALUES
('Roberto', 'Diaz', 'Ruiz', '1980-11-10', '3453453456', '2020-05-01', 'roberto.diaz@example.com', 1);
SELECT * FROM Administrador;

INSERT INTO CatalogoClases (NombreClase, Descripcion, Duracion, Costo) VALUES
('Pilates Reformer', 'Fortalece tu núcleo y mejora tu postura, con la ayuda de una máquina especializada. Ejercicios adaptables para todos los niveles.', '1:00', 230),
('Pilates Mat', 'Entrena con tu propio peso corporal en colchonetas. Mejora el control, la alineación y la flexibilidad en cada sesión.', '0:50', 230),
('Pilates Springboard', 'Desafía tu cuerpo, con una tabla y resortes. Trabaja fuerza y estabilidad a través de ejercicios dinámicos y variados.', '1:30', 230),
('Barre', 'Tonifica y fortalece con movimientos inspirados en el ballet. Utiliza barras para mejorar tu postura y flexibilidad mientras te diviertes.', '1:00', 230),
('Yoga', 'Conéctate contigo mismo a través de posturas, respiración y meditación. Encuentra equilibrio y bienestar en nuestros diversos estilos.', '1:15', 230),
('Spinning', 'Siente la energía del ciclismo en interiores. Mejora tu condición cardiovascular y tonifica tus piernas con música motivadora y un instructor que te guía.', '0:50', 230);

SELECT * FROM CatalogoClases;

INSERT INTO Salones (NombreSalon, Capacidad) VALUES
('Salón Flex', 12),
('Barre Flow', 20),
('Cycle Beat', 30);
SELECT * FROM Salones;

INSERT INTO Clases (IdClase, IdCoach, FechaHora, Capacidad, IdSalon) VALUES
-- Clases que ya pasaron
(1, 2, '2024-11-20 08:00:00', 20, 1),
(2, 3, '2024-11-25 10:00:00', 15, 2),
(3, 4, '2024-12-01 18:00:00', 25, 3),
(4, 5, '2024-12-05 07:00:00', 18, 1),

-- Clases por pasar
(5, 6, '2025-04-15 09:00:00', 20, 2),
(1, 7, '2025-04-18 17:00:00', 15, 3),
(2, 2, '2025-04-20 06:30:00', 25, 1),
(3, 3, '2025-04-22 12:00:00', 22, 3),
(4, 4, '2025-04-23 19:00:00', 18, 2),
(5, 5, '2025-04-25 08:00:00', 24, 1);
SELECT * FROM Clases;

INSERT INTO ClaseCliente (IdCliente, IdClaseProgramada, FechaInscripcion) VALUES
(1, 1, '2024-11-10'),
(2, 2, '2024-11-11'),
(3, 3, '2024-11-12'),
(1, 1, CURDATE()),
(2, 1, CURDATE()),
(5, 2, '2024-11-12'),
(4, 3, CURDATE()),
(2,5,'2024-11-06'),

(1, 1, '2024-11-15'),
(2, 2, '2024-11-20'),
(3, 3, '2024-11-28'),
(4, 4, '2024-12-01'),


(5, 5, '2024-12-10'),
(6, 6, '2024-12-12'),
(7, 7, '2024-12-10'),
(8, 8, '2024-12-09'),
(9, 9, '2024-12-08'),
(10, 10, '2024-12-05'),

(11, 5, '2024-12-09'),
(12, 6, '2024-12-07'),
(13, 7, '2024-12-08'),
(14, 8, '2024-12-10'),
(15, 9, '2024-12-10'),
(16, 10, '2024-12-07'),
(17, 5, '2024-12-11'),
(18, 6, '2024-12-10'),
(19, 7, '2024-12-10'),
(20, 8, '2024-12-10');


SELECT * FROM ClaseCliente WHERE IdCliente =2;

INSERT INTO CatalogoPlanes (NombrePlan, Descripcion, Costo) VALUES
('Clase suelta', 'Válido en todas las clases, Vigencia: 15 días', 150),
('8 clases', 'Válido en todas las clases, Vigencia: 45 días', 1080),
('12 clases', 'Válido en todas las clases, Vigencia: 45 días', 1620),
('1 mes', 'Válido en todas las clases, Máximo 2 clases por día, Vigencia: 30 días', 3000),
('6 meses', 'Válido en todas las clases, Máximo 2 clases por día, Vigencia: 180 días', 18000);


SELECT * FROM CatalogoPlanes;

INSERT INTO FormaPago (NombreFormaPago, Descripcion) VALUES 
    ('Tarjeta de Crédito', 'Pago mediante tarjeta de crédito'),
    ('Transferencia Bancaria', 'Pago mediante transferencia bancaria'),
    ('Efectivo', 'Pago en efectivo en el centro de ejercicio');
    
SELECT * FROM FormaPago;

INSERT INTO Pagos (IdCliente, IdPlan, IdFormaPago, Monto, FechaPago, EstadoPago) VALUES
(1, 1, 1, 150, '2023-04-01', true),
(2, 2, 2, 1080, '2023-04-15', true),
(3, 3, 3, 1620, '2023-05-01', true),
(4, 4, 1, 3000, '2023-05-15', true),
(5, 5, 2, 18000, '2023-06-01', true),
(6, 1, 3, 150, '2023-06-15', false),
(7, 2, 1, 1080, '2023-07-01', false),
(8, 3, 2, 1620, '2023-07-15', true),
(9, 4, 3, 3000, '2023-08-01', true),
(10, 5, 1, 18000, '2023-08-15', false),
(11, 1, 2, 150, '2023-09-01', true),
(12, 2, 3, 1080, '2023-09-15', true),
(13, 3, 1, 1620, '2023-10-01', false),
(14, 4, 2, 3000, '2023-10-15', true),
(15, 5, 3, 18000, '2023-11-01', true);

    
SELECT * FROM Pagos;