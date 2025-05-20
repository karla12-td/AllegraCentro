#Karla Trejo Delgadillo, Luis Lagos Camacho y Swietenia Medina Gasca - Proyecto
#Base de datos de un centro de ejercicio

#garantiza acceso exclusivo a las tablas involucradas para realizar verificaciones e inscripciones sin interferencias, 
#asegurando consistencia en un entorno concurrente.

#Valores para el cliente y la clase
SET @vIdCliente = 2;
SET @vIdClaseProgramada = 5;

#Bloquea tablas, verifica y realiza la inscripción
LOCK TABLES Pagos READ, ClaseCliente WRITE, Clases READ;

#Verifica 

#Membresía activa
SELECT EstadoPago
FROM Pagos
WHERE IdCliente = @vIdCliente AND EstadoPago = TRUE
ORDER BY FechaPago DESC
LIMIT 1;

#Capacidad de la clase
SELECT Capacidad, 
       (SELECT COUNT(*) FROM ClaseCliente WHERE IdClaseProgramada = @vIdClaseProgramada) AS Inscritos
FROM Clases
WHERE IdClaseProgramada = @vIdClaseProgramada;

#Si es válida, inserta inscripción
INSERT INTO ClaseCliente (IdCliente, IdClaseProgramada, FechaInscripcion)
VALUES (@vIdCliente, @vIdClaseProgramada, CURDATE());


UNLOCK TABLES;
