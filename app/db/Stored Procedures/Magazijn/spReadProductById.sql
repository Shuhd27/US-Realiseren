-- ****************************************************************
-- Doel: Opvragen van records uit de tabel
--       Product bij gegeven Id
-- ************************************************
-- Versie:    Datum:            Auteur:              Details
-- *******    ******            *******              ******* 
-- 01         21-11-2024        Arjan de Ruijter     SP Maken
-- ****************************************************************     

-- Noem de database voor de stored procedure
use `jamin_b`;

-- Verwijder de bestaande stored procedure
DROP PROCEDURE IF EXISTS spReadProductById;

DELIMITER //

CREATE PROCEDURE spReadProductById
(
    IN ProductId INT UNSIGNED 
)
BEGIN

   SELECT  PROD.Naam               
          ,PROD.Barcode

   FROM   Product AS PROD

   WHERE  PROD.Id = ProductId;


END //
DELIMITER ;

-- **********debug code stored procedure***************
-- CALL spReadAllergeenPerProductById(1);
-- ****************************************************/