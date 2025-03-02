-- ****************************************************************
-- Doel: Opvragen van records uit de tabel
--       Allergeen, Product en AllergeenPerProduct
-- ************************************************
-- Versie:    Datum:            Auteur:              Details
-- *******    ******            *******              ******* 
-- 01         15-11-2024        Arjan de Ruijter     SP voor select
-- 02         21-11-2024        Arjan de Ruijter     Afmaken SP
-- ****************************************************************     

-- Noem de database voor de stored procedure
use `jamin_b`;

-- Verwijder de bestaande stored procedure
DROP PROCEDURE IF EXISTS spReadAllergeenPerProductById;

DELIMITER //

CREATE PROCEDURE spReadAllergeenPerProductById
(
    IN ProductId INT UNSIGNED 
)
BEGIN

   SELECT  PROD.Naam                    AS ProductNaam        
          ,PROD.Barcode
          ,ALLE.Naam                    As AllergeenNaam
          ,ALLE.Omschrijving

   FROM Product AS PROD

   LEFT JOIN ProductPerAllergeen AS PPA
           ON PPA.ProductId = PROD.Id

   LEFT JOIN Allergeen AS ALLE
           ON PPA.AllergeenId = ALLE.Id

   WHERE      PROD.Id = ProductId

   ORDER BY  ALLE.Naam ASC;


END //
DELIMITER ;

-- **********debug code stored procedure***************
-- CALL spReadAllergeenPerProductById(1);
-- ****************************************************/