#Karla Trejo Delgadillo, Luis Lagos Camacho y Swietenia Medina Gasca - Proyecto
#Base de datos de un centro de ejercicio

#Script para vistas

USE CentroEjercicio;

#Vista de las clases disponibles de hoy en adelante
Drop view if exists ClasesDisponibles;
CREATE VIEW ClasesDisponibles AS
SELECT *
FROM (
	SELECT Clases.idClaseProgramada, CatalogoClases.NombreClase , Coach.NombreCoach, FechaHora, Clases.capacidad, salones.NombreSalon, 
    count(idInscripcion) as inscritos
	FROM Clases
	JOIN Salones ON Clases.IdSalon = Salones.idSalon
    JOIN CatalogoClases ON Clases.IdClase = CatalogoClases.idClase
    JOIN Coach ON Clases.idCoach = Coach.IdCoach
	Left JOIN ClaseCliente on Clases.idClaseProgramada = ClaseCliente.idClaseProgramada
	where Clases.fechaHora > curdate() 
	group by Clases.idClaseProgramada,CatalogoClases.NombreClase, Coach.NombreCoach, fechahora, Clases.capacidad, salones.NombreSalon
	HAVING inscritos > 0
) AS Disponibilidad
where Disponibilidad.capacidad >= Disponibilidad.inscritos;

SELECT * FROM ClasesDisponibles;

-- -- -- --
#vista que muestre las clases que tiene un cliente en la semana actual
Drop view if exists CalendarioSemana;
CREATE VIEW CalendarioSemana AS
Select * from(
Select clasecliente.IdCliente ,Clientes.NombreCliente as Nombre, Clases.IdClaseProgramada, CatalogoClases.NombreClase, 
Clases.FechaHora, Coach.NombreCoach,Salones.NombreSalon
FROM ClaseCliente
JOIN Clases ON ClaseCliente.IdClaseProgramada = Clases.IdClaseProgramada
JOIN CatalogoClases ON Clases.IdClase = CatalogoClases.IdClase
Join Clientes ON ClaseCliente.IdCliente = Clientes.IdCliente
JOIN Coach ON Clases.IdCoach = Coach.IdCoach
JOIN Salones ON Clases.IdSalon = Salones.IdSalon
) as calendario
WHERE calendario.FechaHora BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 15 DAY)
AND calendario.IdCliente = IdCliente;

SELECT * FROM CalendarioSemana WHERE idCliente = 2;


-- -- -- --
#Vista del historial de clases que ha tomado un cliente
Drop view if exists HistorialCliente;
CREATE VIEW HistorialCliente AS
SELECT *
FROM(
SELECT
Clientes.IdCliente, Clientes.NombreCliente, CatalogoClases.NombreClase, Coach.NombreCoach, Clases.FechaHora AS FechaClase 
FROM Clientes
JOIN ClaseCliente ON Clientes.IdCliente = ClaseCliente.IdCliente
JOIN Clases ON ClaseCliente.IdClaseProgramada = Clases.IdClaseProgramada
JOIN CatalogoClases ON Clases.IdClase = CatalogoClases.IdClase
JOIN Coach ON Clases.IdCoach = Coach.IdCoach
)Historial
WHERE Historial.IdCliente = IdCliente;

SELECT * FROM HistorialCliente WHERE idCliente = 2;


-- -- -- -- --
#Vista para verificar membresía activa y el plan actual de cada cliente
Drop view if exists MembresiaActiva;
CREATE VIEW MembresiaActiva AS
SELECT Clientes.IdCliente, Clientes.NombreCliente, Clientes.ApellidoPaterno, Clientes.ApellidoMaterno, 
IF(pagos.EstadoPago = TRUE, 'Activa', 'Inactiva') AS MembresiaActiva,
Catalogoplanes.NombrePlan AS PlanActual
FROM Clientes
JOIN Pagos ON Clientes.IdCliente = Pagos.IdCliente
JOIN CatalogoPlanes ON pagos.IdPlan = catalogoplanes.IdPlan
WHERE pagos.FechaPago = (SELECT MAX(FechaPago) FROM Pagos WHERE IdCliente = clientes.IdCliente);

SELECT * FROM MembresiaActiva WHERE idCliente = 2;


-- -- -- --
#Vista para mostrar clientes como Activos o Inactivos según su membresía
Drop view if exists ClientesActivos;
CREATE VIEW ClientesActivos AS
SELECT clientes.IdCliente,clientes.NombreCliente, clientes.ApellidoPaterno, clientes.ApellidoMaterno,
IF(pagos.EstadoPago = TRUE, 'Activo', 'Inactivo') AS EstadoUsuario
FROM Clientes 
LEFT JOIN Pagos ON clientes.IdCliente = pagos.IdCliente
AND pagos.FechaPago = (SELECT MAX(FechaPago) FROM Pagos WHERE IdCliente = clientes.IdCliente);

SELECT * FROM ClientesActivos WHERE idCliente = 2;

-- -- -- --
#Vista para mostrar a los coaches con sus diferentes especialidades
CREATE VIEW CoachEspecialidades AS
SELECT 
    c.IdCoach,
    CONCAT(c.NombreCoach, ' ', COALESCE(c.ApellidoPaterno, ''), ' ', COALESCE(c.ApellidoMaterno, '')) AS NombreCompleto,
    e.IdEspecialidad,
    e.NombreEspecialidad,
    e.Descripcion
FROM Coach c
JOIN CoachEspecialidad ce ON c.IdCoach = ce.IdCoach
JOIN Especialidad e ON ce.IdEspecialidad = e.IdEspecialidad;

SELECT * FROM CoachEspecialidad;