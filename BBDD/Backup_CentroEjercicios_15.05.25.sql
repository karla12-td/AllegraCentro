CREATE DATABASE  IF NOT EXISTS `centroejercicio` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `centroejercicio`;
-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: centroejercicio
-- ------------------------------------------------------
-- Server version	8.4.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `administrador`
--

DROP TABLE IF EXISTS `administrador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `administrador` (
  `IdAdministrador` int NOT NULL AUTO_INCREMENT,
  `NombreAdmin` varchar(50) NOT NULL,
  `ApellidoPaterno` varchar(50) DEFAULT NULL,
  `ApellidoMaterno` varchar(50) DEFAULT NULL,
  `FechaNacimiento` date DEFAULT NULL,
  `Telefono` varchar(50) DEFAULT NULL,
  `FechaContratacion` date DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `IdUsuario` int DEFAULT NULL,
  PRIMARY KEY (`IdAdministrador`),
  KEY `IdUsuario` (`IdUsuario`),
  CONSTRAINT `administrador_ibfk_1` FOREIGN KEY (`IdUsuario`) REFERENCES `usuarios` (`IdUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrador`
--

LOCK TABLES `administrador` WRITE;
/*!40000 ALTER TABLE `administrador` DISABLE KEYS */;
INSERT INTO `administrador` VALUES (1,'Roberto','Diaz','Ruiz','1980-11-10','3453453456','2020-05-01','roberto.diaz@example.com',1);
/*!40000 ALTER TABLE `administrador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `calendariosemana`
--

DROP TABLE IF EXISTS `calendariosemana`;
/*!50001 DROP VIEW IF EXISTS `calendariosemana`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `calendariosemana` AS SELECT 
 1 AS `IdCliente`,
 1 AS `Nombre`,
 1 AS `IdClaseProgramada`,
 1 AS `NombreClase`,
 1 AS `FechaHora`,
 1 AS `NombreCoach`,
 1 AS `NombreSalon`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `catalogoclases`
--

DROP TABLE IF EXISTS `catalogoclases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogoclases` (
  `IdClase` int NOT NULL AUTO_INCREMENT,
  `NombreClase` varchar(25) DEFAULT NULL,
  `Descripcion` text,
  `Duracion` time DEFAULT NULL,
  `Costo` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`IdClase`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogoclases`
--

LOCK TABLES `catalogoclases` WRITE;
/*!40000 ALTER TABLE `catalogoclases` DISABLE KEYS */;
INSERT INTO `catalogoclases` VALUES (1,'Pilates Reformer','Fortalece tu núcleo y mejora tu postura, con la ayuda de una máquina especializada. Ejercicios adaptables para todos los niveles.','01:00:00',230.00),(2,'Pilates Mat','Entrena con tu propio peso corporal en colchonetas. Mejora el control, la alineación y la flexibilidad en cada sesión.','00:50:00',230.00),(3,'Pilates Springboard','Desafía tu cuerpo, con una tabla y resortes. Trabaja fuerza y estabilidad a través de ejercicios dinámicos y variados.','01:30:00',230.00),(4,'Barre','Tonifica y fortalece con movimientos inspirados en el ballet. Utiliza barras para mejorar tu postura y flexibilidad mientras te diviertes.','01:00:00',230.00),(5,'Yoga','Conéctate contigo mismo a través de posturas, respiración y meditación. Encuentra equilibrio y bienestar en nuestros diversos estilos.','01:15:00',230.00),(6,'Spinning','Siente la energía del ciclismo en interiores. Mejora tu condición cardiovascular y tonifica tus piernas con música motivadora y un instructor que te guía.','00:50:00',230.00);
/*!40000 ALTER TABLE `catalogoclases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogoplanes`
--

DROP TABLE IF EXISTS `catalogoplanes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogoplanes` (
  `IdPlan` int NOT NULL AUTO_INCREMENT,
  `NombrePlan` varchar(25) DEFAULT NULL,
  `Descripcion` varchar(100) DEFAULT NULL,
  `Costo` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`IdPlan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogoplanes`
--

LOCK TABLES `catalogoplanes` WRITE;
/*!40000 ALTER TABLE `catalogoplanes` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalogoplanes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clasecliente`
--

DROP TABLE IF EXISTS `clasecliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clasecliente` (
  `IdInscripcion` int NOT NULL AUTO_INCREMENT,
  `IdCliente` int DEFAULT NULL,
  `IdClaseProgramada` int DEFAULT NULL,
  `FechaInscripcion` date DEFAULT NULL,
  PRIMARY KEY (`IdInscripcion`),
  KEY `IdCliente` (`IdCliente`),
  KEY `IdClaseProgramada` (`IdClaseProgramada`),
  CONSTRAINT `clasecliente_ibfk_1` FOREIGN KEY (`IdCliente`) REFERENCES `clientes` (`IdCliente`),
  CONSTRAINT `clasecliente_ibfk_2` FOREIGN KEY (`IdClaseProgramada`) REFERENCES `clases` (`IdClaseProgramada`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clasecliente`
--

LOCK TABLES `clasecliente` WRITE;
/*!40000 ALTER TABLE `clasecliente` DISABLE KEYS */;
INSERT INTO `clasecliente` VALUES (19,2,5,'2025-05-15');
/*!40000 ALTER TABLE `clasecliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clases`
--

DROP TABLE IF EXISTS `clases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clases` (
  `IdClaseProgramada` int NOT NULL AUTO_INCREMENT,
  `IdClase` int DEFAULT NULL,
  `IdCoach` int DEFAULT NULL,
  `FechaHora` datetime DEFAULT NULL,
  `Capacidad` int DEFAULT NULL,
  `IdSalon` int DEFAULT NULL,
  PRIMARY KEY (`IdClaseProgramada`),
  KEY `IdClase` (`IdClase`),
  KEY `IdCoach` (`IdCoach`),
  KEY `IdSalon` (`IdSalon`),
  CONSTRAINT `clases_ibfk_1` FOREIGN KEY (`IdClase`) REFERENCES `catalogoclases` (`IdClase`),
  CONSTRAINT `clases_ibfk_2` FOREIGN KEY (`IdCoach`) REFERENCES `coach` (`IdCoach`),
  CONSTRAINT `clases_ibfk_3` FOREIGN KEY (`IdSalon`) REFERENCES `salones` (`IdSalon`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clases`
--

LOCK TABLES `clases` WRITE;
/*!40000 ALTER TABLE `clases` DISABLE KEYS */;
INSERT INTO `clases` VALUES (1,1,2,'2024-11-20 08:00:00',20,1),(2,2,3,'2024-11-25 10:00:00',15,2),(3,3,4,'2024-12-01 18:00:00',25,3),(4,4,5,'2024-12-05 07:00:00',18,1),(5,5,6,'2025-04-15 09:00:00',20,2),(6,1,7,'2025-04-18 17:00:00',15,3),(7,2,2,'2025-04-20 06:30:00',25,1),(8,3,3,'2025-04-22 12:00:00',22,3),(9,4,4,'2025-04-23 19:00:00',18,2),(10,5,5,'2025-04-25 08:00:00',24,1);
/*!40000 ALTER TABLE `clases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `clasesdisponibles`
--

DROP TABLE IF EXISTS `clasesdisponibles`;
/*!50001 DROP VIEW IF EXISTS `clasesdisponibles`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `clasesdisponibles` AS SELECT 
 1 AS `idClaseProgramada`,
 1 AS `NombreClase`,
 1 AS `NombreCoach`,
 1 AS `FechaHora`,
 1 AS `capacidad`,
 1 AS `NombreSalon`,
 1 AS `inscritos`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `IdCliente` int NOT NULL AUTO_INCREMENT,
  `NombreCliente` varchar(50) NOT NULL,
  `ApellidoPaterno` varchar(50) DEFAULT NULL,
  `ApellidoMaterno` varchar(50) DEFAULT NULL,
  `FechaNacimiento` date DEFAULT NULL,
  `Telefono` varchar(50) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `IdUsuario` int DEFAULT NULL,
  `FechaRegistro` date DEFAULT NULL,
  PRIMARY KEY (`IdCliente`),
  KEY `IdUsuario` (`IdUsuario`),
  CONSTRAINT `clientes_ibfk_1` FOREIGN KEY (`IdUsuario`) REFERENCES `usuarios` (`IdUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Juan','Pérez','López','1990-01-15','555-1234','juan.perez@example.com',1,'2024-01-01'),(2,'María','Gómez','Ramírez','1985-03-22','555-2345','maria.gomez@example.com',2,'2024-01-02'),(3,'Carlos','Hernández','Martínez','1992-05-10','555-3456','carlos.hernandez@example.com',3,'2024-01-03'),(4,'Ana','Ruiz','Sánchez','1994-07-18','555-4567','ana.ruiz@example.com',4,'2024-01-04'),(5,'Luis','Díaz','Flores','1988-09-25','555-5678','luis.diaz@example.com',5,'2024-01-05'),(6,'Sofía','Morales','Jiménez','1991-11-30','555-6789','sofia.morales@example.com',6,'2024-01-06'),(7,'Miguel','Ortiz','Vargas','1987-02-14','555-7890','miguel.ortiz@example.com',7,'2024-01-07'),(8,'Laura','López','Mendoza','1993-04-20','555-8901','laura.lopez@example.com',8,'2024-01-08'),(9,'Jorge','Ramírez','Salazar','1986-06-15','555-9012','jorge.ramirez@example.com',9,'2024-01-09'),(10,'Elena','Romero','Cruz','1990-08-10','555-0123','elena.romero@example.com',10,'2024-01-10'),(11,'Ricardo','Santos','Luna','1995-10-05','555-1234','ricardo.santos@example.com',11,'2024-01-11'),(12,'Paula','Torres','Molina','1989-12-15','555-2345','paula.torres@example.com',12,'2024-01-12'),(13,'Gabriel','Castillo','Paredes','1992-03-25','555-3456','gabriel.castillo@example.com',13,'2024-01-13'),(14,'Valeria','Silva','Pérez','1988-05-18','555-4567','valeria.silva@example.com',14,'2024-01-14'),(15,'Diego','García','Fernández','1994-07-07','555-5678','diego.garcia@example.com',15,'2024-01-15'),(16,'Carmen','Soto','Blanco','1985-09-27','555-6789','carmen.soto@example.com',16,'2024-01-16'),(17,'Alberto','Ramos','Campos','1991-01-19','555-7890','alberto.ramos@example.com',17,'2024-01-17'),(18,'Luisa','Molina','Quintero','1987-03-03','555-8901','luisa.molina@example.com',18,'2024-01-18'),(19,'Esteban','Vega','Estrada','1993-06-09','555-9012','esteban.vega@example.com',19,'2024-01-19'),(20,'Mónica','Herrera','Guerrero','1989-08-21','555-0123','monica.herrera@example.com',20,'2024-01-20');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `clientesactivos`
--

DROP TABLE IF EXISTS `clientesactivos`;
/*!50001 DROP VIEW IF EXISTS `clientesactivos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `clientesactivos` AS SELECT 
 1 AS `IdCliente`,
 1 AS `NombreCliente`,
 1 AS `ApellidoPaterno`,
 1 AS `ApellidoMaterno`,
 1 AS `EstadoUsuario`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `coach`
--

DROP TABLE IF EXISTS `coach`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coach` (
  `IdCoach` int NOT NULL AUTO_INCREMENT,
  `NombreCoach` varchar(50) NOT NULL,
  `ApellidoPaterno` varchar(50) DEFAULT NULL,
  `ApellidoMaterno` varchar(50) DEFAULT NULL,
  `FechaNacimiento` date DEFAULT NULL,
  `Telefono` varchar(50) DEFAULT NULL,
  `FechaContratacion` date DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `IdUsuario` int DEFAULT NULL,
  PRIMARY KEY (`IdCoach`),
  KEY `IdUsuario` (`IdUsuario`),
  CONSTRAINT `coach_ibfk_1` FOREIGN KEY (`IdUsuario`) REFERENCES `usuarios` (`IdUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coach`
--

LOCK TABLES `coach` WRITE;
/*!40000 ALTER TABLE `coach` DISABLE KEYS */;
INSERT INTO `coach` VALUES (1,'Carlos','Pérez','Ramírez','1985-03-15','5551234567','2021-01-10','carlos.perez@example.com',2),(2,'Ana','López','García','1990-07-20','5552345678','2020-05-15','ana.lopez@example.com',3),(3,'Luis','Hernández','Martínez','1988-09-10','5553456789','2022-03-01','luis.hernandez@example.com',4),(4,'María','Gómez','Sánchez','1992-11-25','5554567890','2019-10-20','maria.gomez@example.com',5),(5,'Roberto','Díaz','Jiménez','1986-01-05','5555678901','2018-12-05','roberto.diaz@example.com',6),(6,'Lucía','Torres','Vega','1994-06-18','5556789012','2023-02-15','lucia.torres@example.com',7),(7,'Carlos','Gomez','Sanchez','1985-02-15','1234567890','2022-01-10','carlos.gomez@example.com',8),(8,'Ana','Lopez','Martinez','1990-07-25','0987654321','2023-03-05','ana.lopez@example.com',9);
/*!40000 ALTER TABLE `coach` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coachespecialidad`
--

DROP TABLE IF EXISTS `coachespecialidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coachespecialidad` (
  `IdCoach` int NOT NULL,
  `IdEspecialidad` int NOT NULL,
  PRIMARY KEY (`IdCoach`,`IdEspecialidad`),
  KEY `IdEspecialidad` (`IdEspecialidad`),
  CONSTRAINT `coachespecialidad_ibfk_1` FOREIGN KEY (`IdCoach`) REFERENCES `coach` (`IdCoach`),
  CONSTRAINT `coachespecialidad_ibfk_2` FOREIGN KEY (`IdEspecialidad`) REFERENCES `especialidad` (`IdEspecialidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coachespecialidad`
--

LOCK TABLES `coachespecialidad` WRITE;
/*!40000 ALTER TABLE `coachespecialidad` DISABLE KEYS */;
INSERT INTO `coachespecialidad` VALUES (1,1),(4,1),(7,1),(1,2),(2,2),(3,2),(8,2),(3,3),(3,4),(5,5),(6,6);
/*!40000 ALTER TABLE `coachespecialidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `coachespecialidades`
--

DROP TABLE IF EXISTS `coachespecialidades`;
/*!50001 DROP VIEW IF EXISTS `coachespecialidades`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `coachespecialidades` AS SELECT 
 1 AS `IdCoach`,
 1 AS `NombreCompleto`,
 1 AS `IdEspecialidad`,
 1 AS `NombreEspecialidad`,
 1 AS `Descripcion`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `encargado`
--

DROP TABLE IF EXISTS `encargado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `encargado` (
  `IdEncargado` int NOT NULL AUTO_INCREMENT,
  `NombreEncargado` varchar(50) NOT NULL,
  `ApellidoPaterno` varchar(50) DEFAULT NULL,
  `ApellidoMaterno` varchar(50) DEFAULT NULL,
  `FechaNacimiento` date DEFAULT NULL,
  `Telefono` varchar(50) DEFAULT NULL,
  `FechaContratacion` date DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `IdUsuario` int DEFAULT NULL,
  PRIMARY KEY (`IdEncargado`),
  KEY `IdUsuario` (`IdUsuario`),
  CONSTRAINT `encargado_ibfk_1` FOREIGN KEY (`IdUsuario`) REFERENCES `usuarios` (`IdUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encargado`
--

LOCK TABLES `encargado` WRITE;
/*!40000 ALTER TABLE `encargado` DISABLE KEYS */;
/*!40000 ALTER TABLE `encargado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `especialidad`
--

DROP TABLE IF EXISTS `especialidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `especialidad` (
  `IdEspecialidad` int NOT NULL AUTO_INCREMENT,
  `NombreEspecialidad` varchar(50) DEFAULT NULL,
  `Descripcion` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`IdEspecialidad`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `especialidad`
--

LOCK TABLES `especialidad` WRITE;
/*!40000 ALTER TABLE `especialidad` DISABLE KEYS */;
INSERT INTO `especialidad` VALUES (1,'Pilates Reformer','Fortalece tu núcleo y mejora tu postura, con la ayuda de una máquina especializada. \nEjercicios adaptables para todos los niveles.'),(2,'Pilates Mat','Entrena con tu propio peso corporal en colchonetas. Mejora el control, la alineación y \nla flexibilidad en cada sesión.'),(3,'Pilates Springboard','Desafía tu cuerpo, con una tabla y resortes. Trabaja fuerza y estabilidad a través\nde ejercicios dinámicos y variados.'),(4,'Barre','Tonifica y fortalece con movimientos inspirados en el ballet. Utiliza barras para mejorar tu postura\n y flexibilidad mientras te diviertes.'),(5,'Yoga','Conéctate contigo mismo a través de posturas, respiración y meditación. Encuentra equilibrio y bienestar\n en nuestros diversos estilos.'),(6,'Spinning','Siente la energía del ciclismo en interiores. Mejora tu condición cardiovascular y tonifica tus piernas\n con música motivadora y un instructor que te guía.');
/*!40000 ALTER TABLE `especialidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `formapago`
--

DROP TABLE IF EXISTS `formapago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `formapago` (
  `IdFormaPago` int NOT NULL AUTO_INCREMENT,
  `NombreFormaPago` varchar(25) DEFAULT NULL,
  `Descripcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`IdFormaPago`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `formapago`
--

LOCK TABLES `formapago` WRITE;
/*!40000 ALTER TABLE `formapago` DISABLE KEYS */;
/*!40000 ALTER TABLE `formapago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `historialcliente`
--

DROP TABLE IF EXISTS `historialcliente`;
/*!50001 DROP VIEW IF EXISTS `historialcliente`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `historialcliente` AS SELECT 
 1 AS `IdCliente`,
 1 AS `NombreCliente`,
 1 AS `NombreClase`,
 1 AS `NombreCoach`,
 1 AS `FechaClase`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `membresiaactiva`
--

DROP TABLE IF EXISTS `membresiaactiva`;
/*!50001 DROP VIEW IF EXISTS `membresiaactiva`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `membresiaactiva` AS SELECT 
 1 AS `IdCliente`,
 1 AS `NombreCliente`,
 1 AS `ApellidoPaterno`,
 1 AS `ApellidoMaterno`,
 1 AS `MembresiaActiva`,
 1 AS `PlanActual`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `pagos`
--

DROP TABLE IF EXISTS `pagos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagos` (
  `IdPago` int NOT NULL AUTO_INCREMENT,
  `IdCliente` int DEFAULT NULL,
  `IdPlan` int DEFAULT NULL,
  `IdFormaPago` int DEFAULT NULL,
  `Monto` decimal(8,2) DEFAULT NULL,
  `FechaPago` datetime DEFAULT NULL,
  `EstadoPago` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`IdPago`),
  KEY `IdCliente` (`IdCliente`),
  KEY `IdPlan` (`IdPlan`),
  KEY `IdFormaPago` (`IdFormaPago`),
  CONSTRAINT `pagos_ibfk_1` FOREIGN KEY (`IdCliente`) REFERENCES `clientes` (`IdCliente`),
  CONSTRAINT `pagos_ibfk_2` FOREIGN KEY (`IdPlan`) REFERENCES `catalogoplanes` (`IdPlan`),
  CONSTRAINT `pagos_ibfk_3` FOREIGN KEY (`IdFormaPago`) REFERENCES `formapago` (`IdFormaPago`),
  CONSTRAINT `pagos_chk_1` CHECK ((`Monto` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagos`
--

LOCK TABLES `pagos` WRITE;
/*!40000 ALTER TABLE `pagos` DISABLE KEYS */;
/*!40000 ALTER TABLE `pagos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salones`
--

DROP TABLE IF EXISTS `salones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salones` (
  `IdSalon` int NOT NULL AUTO_INCREMENT,
  `NombreSalon` varchar(25) NOT NULL,
  `Capacidad` int DEFAULT NULL,
  PRIMARY KEY (`IdSalon`),
  CONSTRAINT `salones_chk_1` CHECK ((`Capacidad` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salones`
--

LOCK TABLES `salones` WRITE;
/*!40000 ALTER TABLE `salones` DISABLE KEYS */;
INSERT INTO `salones` VALUES (1,'Salón Flex',12),(2,'Barre Flow',20),(3,'Cycle Beat',30);
/*!40000 ALTER TABLE `salones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipousuario`
--

DROP TABLE IF EXISTS `tipousuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipousuario` (
  `IdTipo` int NOT NULL AUTO_INCREMENT,
  `Tipo` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`IdTipo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipousuario`
--

LOCK TABLES `tipousuario` WRITE;
/*!40000 ALTER TABLE `tipousuario` DISABLE KEYS */;
INSERT INTO `tipousuario` VALUES (1,'Administrador'),(2,'Encargado'),(3,'Coach'),(4,'Cliente');
/*!40000 ALTER TABLE `tipousuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `IdUsuario` int NOT NULL AUTO_INCREMENT,
  `Usuario` varchar(50) NOT NULL,
  `Contraseña` varchar(50) NOT NULL,
  `Tipo` int DEFAULT NULL,
  PRIMARY KEY (`IdUsuario`),
  KEY `Tipo` (`Tipo`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`Tipo`) REFERENCES `tipousuario` (`IdTipo`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'admin1','pass123',1),(2,'encargado1','pas123',2),(3,'encargado2','pas123',2),(4,'coach1','pass456',3),(5,'coach2','pass789',3),(6,'coach3','pass896',3),(7,'coach4','pass006',3),(8,'coach5','pass345',3),(9,'coach6','pass234',3),(10,'coach7','pass234',3),(11,'coach8','pass234',3),(12,'cliente1','password1',4),(13,'cliente2','password2',4),(14,'cliente3','password3',4),(15,'cliente4','password4',4),(16,'cliente5','password5',4),(17,'cliente6','password6',4),(18,'cliente7','password7',4),(19,'cliente8','password8',4),(20,'cliente9','password9',4),(21,'cliente10','password10',4),(22,'cliente11','password11',4),(23,'cliente12','password12',4),(24,'cliente13','password13',4),(25,'cliente14','password14',4),(26,'cliente15','password15',4),(27,'cliente16','password16',4),(28,'cliente17','password17',4),(29,'cliente18','password18',4),(30,'cliente19','password19',4),(31,'cliente20','password20',4);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'centroejercicio'
--

--
-- Dumping routines for database 'centroejercicio'
--
/*!50003 DROP PROCEDURE IF EXISTS `CancelarCita` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CancelarCita`(
    IN vIdCliente INT,
    IN vIdClaseProgramada INT
)
BEGIN
    DECLARE vFechaHora DATETIME;
    DECLARE vExiste INT;
    

    SELECT COUNT(*) INTO vExiste
    FROM ClaseCliente
    WHERE IdCliente = vIdCliente AND IdClaseProgramada = vIdClaseProgramada;
    
    IF vExiste = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Usted no está inscrito en esta clase';
    ELSE
        SELECT FechaHora INTO vFechaHora
        FROM Clases
        WHERE IdClaseProgramada = vIdClaseProgramada;
        
        IF vFechaHora < NOW() THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Ya ha ocurrido esta clase';
        ELSE
            DELETE FROM ClaseCliente
            WHERE IdCliente = vIdCliente AND IdClaseProgramada = vIdClaseProgramada;
            
            SELECT 'Inscripción cancelada' AS Mensaje;
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CheckInClase` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CheckInClase`(
    IN p_IdCliente INT,
    IN p_IdClaseProgramada INT
)
BEGIN
    DECLARE v_CapacidadMax INT;
    DECLARE v_Inscritos INT;
    DECLARE v_FechaClase DATETIME;
    DECLARE v_ExisteInscripcion INT;

    -- Obtener la capacidad de la clase y la fecha programada
    SELECT Capacidad, FechaHora INTO v_CapacidadMax, v_FechaClase
    FROM Clases
    WHERE IdClaseProgramada = p_IdClaseProgramada;

    -- Contar cuántos clientes están inscritos en la clase
    SELECT COUNT(*) INTO v_Inscritos
    FROM ClaseCliente
    WHERE IdClaseProgramada = p_IdClaseProgramada;

    -- Verificar si el cliente ya está inscrito
    SELECT COUNT(*) INTO v_ExisteInscripcion
    FROM ClaseCliente
    WHERE IdCliente = p_IdCliente AND IdClaseProgramada = p_IdClaseProgramada;

    -- Validaciones
    IF v_FechaClase <= NOW() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No puedes registrarte en una clase pasada.';
    ELSEIF v_Inscritos >= v_CapacidadMax THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La clase ya está llena.';
    ELSEIF v_ExisteInscripcion > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ya estás registrado en esta clase.';
    ELSE
        -- Insertar la inscripción si pasa las validaciones
        INSERT INTO ClaseCliente (IdCliente, IdClaseProgramada, FechaInscripcion)
        VALUES (p_IdCliente, p_IdClaseProgramada, NOW());
        SELECT 'Check-in exitoso' AS Mensaje;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InscribirCliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InscribirCliente`(
    IN vIdCliente INT,
    IN vIdClaseProgramada INT
)
BEGIN
    DECLARE vCapacidad INT;
    DECLARE vInscritos INT;
    DECLARE vExiste INT;
    DECLARE vFechaHora DATETIME;
    DECLARE vMembresiaActiva BOOLEAN;

    -- Verificar si el cliente tiene una membresía activa
    SELECT EstadoPago INTO vMembresiaActiva
    FROM Pagos
    WHERE IdCliente = vIdCliente AND EstadoPago = TRUE
    ORDER BY FechaPago DESC
    LIMIT 1;

    -- Si no tiene membresía activa, se cancela la inscripción
    IF vMembresiaActiva IS NULL OR vMembresiaActiva = FALSE THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El cliente no tiene una membresía activa, no puede inscribirse en la clase';
    ELSE
        -- Obtener la fecha y hora de la clase programada
        SELECT FechaHora INTO vFechaHora
        FROM Clases
        WHERE IdClaseProgramada = vIdClaseProgramada;

        -- Verificar si la clase ya ha pasado
        IF vFechaHora < NOW() THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'La clase ya pasó, no se puede inscribir';
        ELSE
            -- Verificar si el cliente ya está inscrito en la clase
            SELECT COUNT(*) INTO vExiste
            FROM ClaseCliente
            WHERE IdCliente = vIdCliente AND IdClaseProgramada = vIdClaseProgramada;

            IF vExiste > 0 THEN
                SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Ya estás inscrito en esta clase';
            ELSE
                -- Obtener la capacidad de la clase programada
                SELECT Capacidad INTO vCapacidad
                FROM Clases
                WHERE IdClaseProgramada = vIdClaseProgramada;

                -- Contar cuántos clientes ya están inscritos en la clase
                SELECT COUNT(*) INTO vInscritos
                FROM ClaseCliente
                WHERE IdClaseProgramada = vIdClaseProgramada;

                -- Verificar si hay cupo disponible
                IF vInscritos < vCapacidad THEN
                    -- Si hay espacio, insertar la inscripción
                    INSERT INTO ClaseCliente (IdCliente, IdClaseProgramada, FechaInscripcion)
                    VALUES (vIdCliente, vIdClaseProgramada, CURDATE());
                ELSE
                    -- Si no hay espacio, mostrar un mensaje de error
                    SIGNAL SQLSTATE '45000'
                        SET MESSAGE_TEXT = 'La clase ha alcanzado su capacidad máxima y no se pueden inscribir más alumnos';
                END IF;
            END IF;
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RegistrarPago` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistrarPago`(
    IN vIdCliente INT,
    IN vIdPlan INT,
    IN vIdFormaPago INT,
    IN vMonto DECIMAL(8,2)
)
BEGIN
    DECLARE vCostoPlan DECIMAL(8,2);
    DECLARE vPlanActivo INT;

    START TRANSACTION;

    SELECT COUNT(*) INTO vPlanActivo
    FROM Pagos
    WHERE IdCliente = vIdCliente AND EstadoPago = TRUE;

    IF vPlanActivo > 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El cliente ya tiene un plan activo y no puede adquirir otro.';
    ELSE
       
        SELECT Costo INTO vCostoPlan
        FROM CatalogoPlanes
        WHERE IdPlan = vIdPlan;

        IF vMonto >= vCostoPlan THEN
            -- Registrar el pago en la tabla Pagos
            INSERT INTO Pagos (IdCliente, IdPlan, IdFormaPago, Monto, FechaPago, EstadoPago)
            VALUES (vIdCliente, vIdPlan, vIdFormaPago, vMonto, NOW(), TRUE);

            COMMIT;
        ELSE
		
            ROLLBACK;
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'El monto es insuficiente para el costo del plan seleccionado';
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `calendariosemana`
--

/*!50001 DROP VIEW IF EXISTS `calendariosemana`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `calendariosemana` AS select `calendario`.`IdCliente` AS `IdCliente`,`calendario`.`Nombre` AS `Nombre`,`calendario`.`IdClaseProgramada` AS `IdClaseProgramada`,`calendario`.`NombreClase` AS `NombreClase`,`calendario`.`FechaHora` AS `FechaHora`,`calendario`.`NombreCoach` AS `NombreCoach`,`calendario`.`NombreSalon` AS `NombreSalon` from (select `clasecliente`.`IdCliente` AS `IdCliente`,`clientes`.`NombreCliente` AS `Nombre`,`clases`.`IdClaseProgramada` AS `IdClaseProgramada`,`catalogoclases`.`NombreClase` AS `NombreClase`,`clases`.`FechaHora` AS `FechaHora`,`coach`.`NombreCoach` AS `NombreCoach`,`salones`.`NombreSalon` AS `NombreSalon` from (((((`clasecliente` join `clases` on((`clasecliente`.`IdClaseProgramada` = `clases`.`IdClaseProgramada`))) join `catalogoclases` on((`clases`.`IdClase` = `catalogoclases`.`IdClase`))) join `clientes` on((`clasecliente`.`IdCliente` = `clientes`.`IdCliente`))) join `coach` on((`clases`.`IdCoach` = `coach`.`IdCoach`))) join `salones` on((`clases`.`IdSalon` = `salones`.`IdSalon`)))) `calendario` where ((`calendario`.`FechaHora` between curdate() and (curdate() + interval 15 day)) and (`calendario`.`IdCliente` = `calendario`.`IdCliente`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `clasesdisponibles`
--

/*!50001 DROP VIEW IF EXISTS `clasesdisponibles`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `clasesdisponibles` AS select `disponibilidad`.`idClaseProgramada` AS `idClaseProgramada`,`disponibilidad`.`NombreClase` AS `NombreClase`,`disponibilidad`.`NombreCoach` AS `NombreCoach`,`disponibilidad`.`FechaHora` AS `FechaHora`,`disponibilidad`.`capacidad` AS `capacidad`,`disponibilidad`.`NombreSalon` AS `NombreSalon`,`disponibilidad`.`inscritos` AS `inscritos` from (select `clases`.`IdClaseProgramada` AS `idClaseProgramada`,`catalogoclases`.`NombreClase` AS `NombreClase`,`coach`.`NombreCoach` AS `NombreCoach`,`clases`.`FechaHora` AS `FechaHora`,`clases`.`Capacidad` AS `capacidad`,`salones`.`NombreSalon` AS `NombreSalon`,count(`clasecliente`.`IdInscripcion`) AS `inscritos` from ((((`clases` join `salones` on((`clases`.`IdSalon` = `salones`.`IdSalon`))) join `catalogoclases` on((`clases`.`IdClase` = `catalogoclases`.`IdClase`))) join `coach` on((`clases`.`IdCoach` = `coach`.`IdCoach`))) left join `clasecliente` on((`clases`.`IdClaseProgramada` = `clasecliente`.`IdClaseProgramada`))) where (`clases`.`FechaHora` > curdate()) group by `clases`.`IdClaseProgramada`,`catalogoclases`.`NombreClase`,`coach`.`NombreCoach`,`clases`.`FechaHora`,`clases`.`Capacidad`,`salones`.`NombreSalon` having (`inscritos` > 0)) `disponibilidad` where (`disponibilidad`.`capacidad` >= `disponibilidad`.`inscritos`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `clientesactivos`
--

/*!50001 DROP VIEW IF EXISTS `clientesactivos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `clientesactivos` AS select `clientes`.`IdCliente` AS `IdCliente`,`clientes`.`NombreCliente` AS `NombreCliente`,`clientes`.`ApellidoPaterno` AS `ApellidoPaterno`,`clientes`.`ApellidoMaterno` AS `ApellidoMaterno`,if((`pagos`.`EstadoPago` = true),'Activo','Inactivo') AS `EstadoUsuario` from (`clientes` left join `pagos` on(((`clientes`.`IdCliente` = `pagos`.`IdCliente`) and (`pagos`.`FechaPago` = (select max(`pagos`.`FechaPago`) from `pagos` where (`pagos`.`IdCliente` = `clientes`.`IdCliente`)))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `coachespecialidades`
--

/*!50001 DROP VIEW IF EXISTS `coachespecialidades`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `coachespecialidades` AS select `c`.`IdCoach` AS `IdCoach`,concat(`c`.`NombreCoach`,' ',coalesce(`c`.`ApellidoPaterno`,''),' ',coalesce(`c`.`ApellidoMaterno`,'')) AS `NombreCompleto`,`e`.`IdEspecialidad` AS `IdEspecialidad`,`e`.`NombreEspecialidad` AS `NombreEspecialidad`,`e`.`Descripcion` AS `Descripcion` from ((`coach` `c` join `coachespecialidad` `ce` on((`c`.`IdCoach` = `ce`.`IdCoach`))) join `especialidad` `e` on((`ce`.`IdEspecialidad` = `e`.`IdEspecialidad`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `historialcliente`
--

/*!50001 DROP VIEW IF EXISTS `historialcliente`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `historialcliente` AS select `historial`.`IdCliente` AS `IdCliente`,`historial`.`NombreCliente` AS `NombreCliente`,`historial`.`NombreClase` AS `NombreClase`,`historial`.`NombreCoach` AS `NombreCoach`,`historial`.`FechaClase` AS `FechaClase` from (select `clientes`.`IdCliente` AS `IdCliente`,`clientes`.`NombreCliente` AS `NombreCliente`,`catalogoclases`.`NombreClase` AS `NombreClase`,`coach`.`NombreCoach` AS `NombreCoach`,`clases`.`FechaHora` AS `FechaClase` from ((((`clientes` join `clasecliente` on((`clientes`.`IdCliente` = `clasecliente`.`IdCliente`))) join `clases` on((`clasecliente`.`IdClaseProgramada` = `clases`.`IdClaseProgramada`))) join `catalogoclases` on((`clases`.`IdClase` = `catalogoclases`.`IdClase`))) join `coach` on((`clases`.`IdCoach` = `coach`.`IdCoach`)))) `historial` where (`historial`.`IdCliente` = `historial`.`IdCliente`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `membresiaactiva`
--

/*!50001 DROP VIEW IF EXISTS `membresiaactiva`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `membresiaactiva` AS select `clientes`.`IdCliente` AS `IdCliente`,`clientes`.`NombreCliente` AS `NombreCliente`,`clientes`.`ApellidoPaterno` AS `ApellidoPaterno`,`clientes`.`ApellidoMaterno` AS `ApellidoMaterno`,if((`pagos`.`EstadoPago` = true),'Activa','Inactiva') AS `MembresiaActiva`,`catalogoplanes`.`NombrePlan` AS `PlanActual` from ((`clientes` join `pagos` on((`clientes`.`IdCliente` = `pagos`.`IdCliente`))) join `catalogoplanes` on((`pagos`.`IdPlan` = `catalogoplanes`.`IdPlan`))) where (`pagos`.`FechaPago` = (select max(`pagos`.`FechaPago`) from `pagos` where (`pagos`.`IdCliente` = `clientes`.`IdCliente`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-15  0:26:04
