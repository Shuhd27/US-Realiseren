/************************************************
-- Doel: Opvragen alle records uit de tabel
--       Magazijn en Product.
************************************************
-- Versie: 01
-- Datum:  23-10-2024
-- Auteur: Arjan de Ruijter
-- Details: Stored procedure voor index model method
************************************************/

-- Noem de database voor de stored procedure
use `jamin_b`;

-- Verwijder de bestaande stored procedure
DROP PROCEDURE IF EXISTS spReadMagazijnProduct;

DELIMITER //

CREATE PROCEDURE spReadMagazijnProduct
(
     IN  pLimit    TINYINT    UNSIGNED
    ,IN  pOffset   SMALLINT   UNSIGNED
)
BEGIN

    SELECT       MAGA.Id                    AS      MagazijnId
                ,MAGA.ProductId             AS      MagazijnProductId
                ,MAGA.Verpakkingseenheid
                ,MAGA.AantalAanwezig
                ,PROD.Id                    AS      ProductId
                ,PROD.Naam
                ,PROD.Barcode
                ,COUNT(*) OVER()            AS      TotalRows

    FROM        Magazijn AS MAGA

    INNER JOIN Product AS PROD
            ON PROD.Id = MAGA.ProductId

    ORDER BY PROD.Barcode ASC

    LIMIT pLimit OFFSET pOffset;


END //
DELIMITER ;

/**********debug code stored procedure***************
CALL spReadMagazijnProduct();
****************************************************/