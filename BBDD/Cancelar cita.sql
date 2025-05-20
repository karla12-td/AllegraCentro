#Karla Trejo Delgadillo, Luis Lagos Camacho y Swietenia Medina Gasca - Proyecto
#Base de datos de un centro de ejercicio

USE CentroEjercicio;

DROP PROCEDURE IF EXISTS CancelarCita;

DELIMITER //
CREATE PROCEDURE CancelarCita(
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
END //
DELIMITER ;



-- Ejemplos de cancelación
-- checar bien el numero 
CALL CancelarCita(2, 32);
CALL CancelarCita(3, 36);
CALL CancelarCita(1, 9);


