#Karla Trejo Delgadillo, Luis Lagos Camacho y Swietenia Medina Gasca - Proyecto
#Base de datos de un centro de ejercicio

#Script para crear base de datos y tablas

DROP DATABASE IF EXISTS CentroEjercicio;
CREATE DATABASE CentroEjercicio;

USE CentroEjercicio;

#Tabla Tipos de usuarios ("Admin", "Encargado", "Coach", "Cliente")
CREATE TABLE IF NOT EXISTS TipoUsuario(
IdTipo INT AUTO_INCREMENT PRIMARY KEY,
Tipo VARCHAR(10)
);


#Tabla Usuarios
CREATE TABLE IF NOT EXISTS Usuarios(
IdUsuario INT AUTO_INCREMENT PRIMARY KEY,
Usuario VARCHAR(50) NOT NULL,
Contraseña VARCHAR(50) NOT NULL,
Tipo INT,
FOREIGN KEY (Tipo) REFERENCES TipoUsuario(IdTipo)
);

#Tabla Especialidad - Define las áreas de especialidad de los coaches ("Pilates", "Barre", "Yoga", "Spinning")
CREATE TABlE IF NOT EXISTS Especialidad(
IdEspecialidad INT AUTO_INCREMENT PRIMARY KEY,
NombreEspecialidad VARCHAR(50),
Descripcion VARCHAR(250)
);

#Tabla Coach
CREATE TABLE IF NOT EXISTS Coach(
IdCoach INT AUTO_INCREMENT PRIMARY KEY,
NombreCoach VARCHAR(50) NOT NULL,
ApellidoPaterno VARCHAR(50),
ApellidoMaterno VARCHAR(50),
FechaNacimiento DATE,
Telefono VARCHAR(50),
FechaContratacion DATE ,
Email VARCHAR(50),
IdUsuario INT,
FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario)
);

#Tabla que relaciona a los coaches con su especialidad, asi pueden tener más de una
CREATE TABLE IF NOT EXISTS CoachEspecialidad(
IdCoach INT,
IdEspecialidad INT,
PRIMARY KEY (IDCoach, IdEspecialidad),
FOREIGN KEY (IdCoach) REFERENCES Coach(IdCoach),
FOREIGN KEY (IdEspecialidad) REFERENCES Especialidad(IdEspecialidad)
);

#Tabla Clientes
CREATE TABLE IF NOT EXISTS Clientes(
IdCliente INT AUTO_INCREMENT PRIMARY KEY,
NombreCliente VARCHAR(50) NOT NULL,
ApellidoPaterno VARCHAR(50),
ApellidoMaterno VARCHAR(50),
FechaNacimiento DATE,
Telefono VARCHAR(50),
Email VARCHAR(50),
IdUsuario INT,
FechaRegistro DATE, 
FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario)
);

#Tabla Administrador
CREATE TABLE IF NOT EXISTS Administrador(
IdAdministrador INT AUTO_INCREMENT PRIMARY KEY,
NombreAdmin VARCHAR(50) NOT NULL,
ApellidoPaterno VARCHAR(50),
ApellidoMaterno VARCHAR(50),
FechaNacimiento DATE,
Telefono VARCHAR(50),
FechaContratacion DATE,
Email VARCHAR(50),
IdUsuario INT,
FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario)
);

CREATE TABLE IF NOT EXISTS Encargado(
IdAdministrador INT AUTO_INCREMENT PRIMARY KEY,
NombreEncargado VARCHAR(50) NOT NULL,
ApellidoPaterno VARCHAR(50),
ApellidoMaterno VARCHAR(50),
FechaNacimiento DATE,
Telefono VARCHAR(50),
FechaContratacion DATE,
Email VARCHAR(50),
IdUsuario INT,
FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario)
);

#Tabla Salones ("Salón Flex", "Cycle Beat", "Cycle Beat")
CREATE TABLE IF NOT EXISTS Salones(
IdSalon INT AUTO_INCREMENT PRIMARY KEY ,
NombreSalon VARCHAR(25) NOT NULL,
Capacidad INT CHECK( Capacidad >0 )
);

#Tabla de catalogo de clases - define y organiza los diferentes tipos de clases que el centro ofrece a los clientes
CREATE TABlE IF NOT EXISTS CatalogoClases(
IdClase INT AUTO_INCREMENT PRIMARY KEY,
NombreClase VARCHAR (25),
Descripcion VARCHAR(100),
Duracion TIME,
Costo DECIMAL(8,2)
);

#Tablas Clases - define las clases específicas que se llevarán a cabo, es decir las clases que estan programadas, 
#incluye el instructor, el salón asignado y la capacidad máxima de asistentes
CREATE TABlE IF NOT EXISTS Clases(
IdClaseProgramada INT AUTO_INCREMENT PRIMARY KEY,
IdClase INT, 
IdCoach INT, 
FechaHora DATETIME,
Capacidad INT,
IdSalon INT, #Foreign key salones
FOREIGN KEY (IdClase) REFERENCES CatalogoClases(IdClase),
FOREIGN KEY (IdCoach) REFERENCES Coach(IdCoach),
FOREIGN KEY (IdSalon) REFERENCES Salones(IdSalon)
);


#Tabla de relación entre las clases y los clientes, es decir clientes inscritos en una clase
#almacena las inscripciones de los clientes en clases programadas
CREATE TABlE IF NOT EXISTS ClaseCliente(
IdInscripcion INT AUTO_INCREMENT PRIMARY KEY,
IdCliente INT, 
IdClaseProgramada INT, 
FechaInscripcion DATE,
FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente),
FOREIGN KEY (IdClaseProgramada) REFERENCES Clases(IdClaseProgramada)
);

#Tablas de pagos

#Tabla de los planes que existen en el centro
CREATE TABLE IF NOT EXISTS CatalogoPlanes(
IdPlan INT AUTO_INCREMENT PRIMARY KEY,
NombrePlan VARCHAR(25),
Descripcion VARCHAR(100),
Costo DECIMAL(8,2)
);

#Tabla de las formas de realizar un pago 
CREATE TABLE IF NOT EXISTS FormaPago(
IdFormaPago INT AUTO_INCREMENT PRIMARY KEY,
NombreFormaPago VARCHAR(25), #Tarjeta, transferencia, efectivo
Descripcion VARCHAR(100)
);

#Pagos que se han realizado
CREATE TABLE IF NOT EXISTS Pagos(
IdPago INT AUTO_INCREMENT PRIMARY KEY,
IdCliente INT, 
IdPlan INT, 
IdFormaPago INT,
Monto DECIMAL(8,2) CHECK(Monto>0),
FechaPago DATETIME,
EstadoPago Boolean, #True = pagado, False = no pagado
FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente),
FOREIGN KEY (IdPlan) REFERENCES CatalogoPlanes(IdPlan),
FOREIGN KEY (IdFormaPago) REFERENCES FormaPago(IdFormaPago)
);













