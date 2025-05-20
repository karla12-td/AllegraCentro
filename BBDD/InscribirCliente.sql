#Karla Trejo Delgadillo, Luis Lagos Camacho y Swietenia Medina Gasca - Proyecto
#Base de datos de un centro de ejercicio

#Procedimiento para inscribir un cliente a clase 

USE CentroEjercicio;

DROP PROCEDURE IF EXISTS InscribirCliente;

DELIMITER //
CREATE PROCEDURE InscribirCliente(
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
END //
DELIMITER ;


#CALL InscribirCliente(IdCliente,IdClaseProgramada)
CALL InscribirCliente(10,3);
CALL InscribirCliente(1,9);
CALL InscribirCliente(10,3);

CALL InscribirCliente(2,6);
CALL InscribirCliente(2,7);
CALL InscribirCliente(2,8);

