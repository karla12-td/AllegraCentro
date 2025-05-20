#Karla Trejo Delgadillo, Luis Lagos Camacho y Swietenia Medina Gasca - Proyecto
#Base de datos de un centro de ejercicio

# Procedimiento para registrar un pago 

DROP PROCEDURE IF EXISTS RegistrarPago;

DELIMITER //
CREATE PROCEDURE RegistrarPago(
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
END //
DELIMITER ;


#CALL RegistrarPago(vIdCliente, vIdPlan, vIdFormaPago, vMonto);
CALL RegistrarPago(1, 2, 1, 1000.00);
CALL RegistrarPago(17, 2, 1, 1080.00);
