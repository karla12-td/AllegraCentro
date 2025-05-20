#Karla Trejo Delgadillo, Luis Lagos Camacho y Swietenia Medina Gasca - Proyecto
#Base de datos de un centro de ejercicio

DELIMITER //

CREATE PROCEDURE CheckInClase(
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
END //

DELIMITER ;



-- PROBAR LAS CLASES DISPONIBLES CON CUPO
SELECT 
    c.IdClaseProgramada,
    cat.NombreClase, 
    c.Capacidad,
    COUNT(cc.IdCliente) AS Inscritos,
    c.Capacidad - COUNT(cc.IdCliente) AS CuposDisponibles
FROM Clases c
LEFT JOIN ClaseCliente cc ON c.IdClaseProgramada = cc.IdClaseProgramada
LEFT JOIN CatalogoClases cat ON c.IdClase = cat.IdClase 
WHERE c.FechaHora > NOW()  
GROUP BY c.IdClaseProgramada
HAVING CuposDisponibles > 0;


-- EJEMPLO DEL CHECK IN
CALL CheckInClase(10, 5);