-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 02, 2025 at 09:32 PM
-- Server version: 8.3.0
-- PHP Version: 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `jamin_b_new`
--

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `GetGeleverdeProductenPerLeverancier`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetGeleverdeProductenPerLeverancier` (IN `leverancierId` INT)   BEGIN
    SELECT p.naam AS product_naam, 
           lp.aantal_geleverde_producten AS aantal_in_magazijn, 
           lp.laast_geleverde_datum AS laatst_geleverde_datum
    FROM leverancier_producten lp
    INNER JOIN producten p ON lp.product_id = p.product_id
    WHERE lp.leverancier_id = leverancierId
    ORDER BY lp.aantal_geleverde_producten DESC;
END$$

DROP PROCEDURE IF EXISTS `GetLeveranciersOverzicht`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetLeveranciersOverzicht` ()   BEGIN
    SELECT l.naam AS leverancier_naam, 
           COUNT(lp.product_id) AS aantal_producten,
           GROUP_CONCAT(p.naam ORDER BY p.naam ASC) AS producten
    FROM leveranciers l
    LEFT JOIN leverancier_producten lp ON l.leverancier_id = lp.leverancier_id
    LEFT JOIN producten p ON lp.product_id = p.product_id
    GROUP BY l.leverancier_id
    ORDER BY aantal_producten DESC;
END$$

DROP PROCEDURE IF EXISTS `spCheckLeverancierContact`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spCheckLeverancierContact` (IN `productId` INT)   BEGIN
    SELECT 
        l.Id AS LeverancierId,
        l.Naam AS LeverancierNaam,
        IFNULL(
            NULLIF(CONCAT('Mobiel: ', l.Mobiel, ' | Leveranciernummer: ', l.Leveranciernummer), 'Mobiel:  | Leveranciernummer: '),
            'Er zijn geen adresgegevens bekend'
        ) AS ContactInfo
    FROM ProductPerLeverancier AS ppl
    INNER JOIN Leverancier AS l ON ppl.LeverancierId = l.Id
    WHERE ppl.ProductId = productId;
END$$

DROP PROCEDURE IF EXISTS `spCreateCountry`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spCreateCountry` (IN `Name` VARCHAR(250), IN `CapitalCity` VARCHAR(250), IN `Continent` VARCHAR(250), IN `Population` INT UNSIGNED, IN `Zipcode` VARCHAR(6))   BEGIN
    
    INSERT INTO Country (
        Name
        ,CapitalCity
        ,Continent
        ,Population
        ,Zipcode)
    VALUES (
        Name
        ,CapitalCity
        ,Continent
        ,Population
        ,Zipcode
    );

END$$

DROP PROCEDURE IF EXISTS `spDeleteCountryById`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spDeleteCountryById` (IN `Id` INT UNSIGNED)   BEGIN

    DELETE 
    FROM Country AS COUN
    WHERE COUN.Id = Id;

END$$

DROP PROCEDURE IF EXISTS `spLeverancierOverzichtAantalProducten`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeverancierOverzichtAantalProducten` ()   BEGIN

    SELECT       LEVE.Id                             AS      LeverancierId
                ,LEVE.Naam                           AS      Naam
                ,LEVE.Contactpersoon                 AS      Contactpersoon
                ,LEVE.LeverancierNummer              AS      LeverancierNummer
                ,LEVE.Mobiel                         AS      Mobiel 
                ,COUNT(DISTINCT PPLE.ProductId)      AS      AantalProducten              

    FROM        Leverancier AS LEVE

    LEFT JOIN   ProductPerLeverancier AS PPLE
           ON   LEVE.Id = PPLE.LeverancierId

    GROUP BY    LEVE.Id

    ORDER BY    AantalProducten DESC;

END$$

DROP PROCEDURE IF EXISTS `spReadAllergeenPerProductById`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReadAllergeenPerProductById` (IN `ProductId` INT UNSIGNED)   BEGIN

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


END$$

DROP PROCEDURE IF EXISTS `spReadAllergenenOverzicht`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReadAllergenenOverzicht` ()   BEGIN
    SELECT 
        p.Id AS ProductId,
        p.Naam AS ProductNaam,
        p.Barcode,
        a.Naam AS AllergeenNaam,
        a.Omschrijving
    FROM Product p
    INNER JOIN ProductPerAllergeen ppa ON p.Id = ppa.ProductId
    INNER JOIN Allergeen a ON ppa.AllergeenId = a.Id
    ORDER BY p.Naam ASC;
END$$

DROP PROCEDURE IF EXISTS `spReadAllergenenPerProduct`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReadAllergenenPerProduct` (IN `allergeenId` INT)   BEGIN
    SELECT 
        p.Id AS ProductId,
        p.Naam AS ProductNaam,
        p.Barcode,
        a.Naam AS AllergeenNaam,
        a.Omschrijving
    FROM Product p
    INNER JOIN ProductPerAllergeen ppa ON p.Id = ppa.ProductId
    INNER JOIN Allergeen a ON ppa.AllergeenId = a.Id
    WHERE a.Id = allergeenId
    ORDER BY p.Naam ASC;
END$$

DROP PROCEDURE IF EXISTS `spReadCountries`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReadCountries` ()   BEGIN

    SELECT COUN.Id
           ,COUN.Name
           ,COUN.CapitalCity
           ,COUN.Continent
           ,COUN.Population
           ,COUN.Zipcode
    FROM   Country AS COUN
    Order BY COUN.Id;



END$$

DROP PROCEDURE IF EXISTS `spReadCountryById`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReadCountryById` (IN `Id` INT UNSIGNED)   BEGIN

    SELECT  COUN.Id
            ,COUN.Name
            ,COUN.CapitalCity
            ,COUN.Continent
            ,COUN.Population
            ,COUN.Zipcode
    FROM Country AS COUN
    WHERE COUN.Id = Id;

END$$

DROP PROCEDURE IF EXISTS `spReadLeverancierByProductId`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReadLeverancierByProductId` (IN `productId` INT)   BEGIN
    SELECT 
        l.Id AS LeverancierId,
        l.Naam AS LeverancierNaam,
        l.Contactpersoon,
        l.Leveranciernummer,
        l.Mobiel
    FROM ProductPerLeverancier AS ppl
    INNER JOIN Leverancier AS l ON ppl.LeverancierId = l.Id
    WHERE ppl.ProductId = productId;
END$$

DROP PROCEDURE IF EXISTS `spReadMagazijnProduct`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReadMagazijnProduct` (IN `pLimit` TINYINT UNSIGNED, IN `pOffset` SMALLINT UNSIGNED)   BEGIN

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


END$$

DROP PROCEDURE IF EXISTS `spReadProductById`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReadProductById` (IN `ProductId` INT UNSIGNED)   BEGIN

   SELECT  PROD.Naam               
          ,PROD.Barcode

   FROM   Product AS PROD

   WHERE  PROD.Id = ProductId;


END$$

DROP PROCEDURE IF EXISTS `spReadProductPerLeverancierById`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReadProductPerLeverancierById` (IN `ProductId` INT UNSIGNED)   BEGIN

   SELECT        DATE_FORMAT(PPL.DatumLevering, "%d-%m-%Y") AS  DatumLevering
                ,DATE_FORMAT(PPL.DatumEerstVolgendeLevering, "%d-%m-%Y") AS     DatumEerstVolgendeLevering
                ,PPL.Aantal
                ,PROD.Naam                          AS ProductNaam
                ,LEVE.Naam                          AS LeverancierNaam
                ,LEVE.Contactpersoon
                ,LEVE.Leveranciernummer
                ,LEVE.Mobiel
                ,MAGA.AantalAanwezig

   FROM         ProductPerLeverancier AS PPL

   INNER JOIN   Product AS PROD
           ON   PPL.ProductId = PROD.Id

   INNER JOIN   Leverancier AS LEVE
           ON   PPL.LeverancierId = Leve.Id

   INNER JOIN   Magazijn AS MAGA
           ON   MAGA.ProductId = PROD.Id

   WHERE      PROD.Id = ProductId

   ORDER BY  PPL.Datumlevering ASC;


END$$

DROP PROCEDURE IF EXISTS `spUpdateCountryById`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spUpdateCountryById` (IN `Id` INT UNSIGNED, IN `Name` VARCHAR(250), IN `CapitalCity` VARCHAR(250), IN `Continent` VARCHAR(250), IN `Population` INT UNSIGNED, IN `Zipcode` VARCHAR(6))   BEGIN
    
    UPDATE Country AS COUN
    SET  COUN.Name = Name
        ,COUN.CapitalCity = CapitalCity
        ,COUN.Continent = Continent
        ,COUN.Population = Population
        ,COUN.Zipcode = Zipcode
    WHERE COUN.Id = Id;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `allergeen`
--

DROP TABLE IF EXISTS `allergeen`;
CREATE TABLE IF NOT EXISTS `allergeen` (
  `Id` tinyint UNSIGNED NOT NULL AUTO_INCREMENT,
  `Naam` varchar(50) NOT NULL,
  `Omschrijving` varchar(255) NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerkingen` varchar(255) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL,
  `DatumGewijzigd` datetime(6) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `allergeen`
--

INSERT INTO `allergeen` (`Id`, `Naam`, `Omschrijving`, `IsActief`, `Opmerkingen`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 'Gluten', 'Dit product bevat gluten', b'1', NULL, '2024-12-05 08:18:28.004337', '2024-12-05 08:18:28.004340'),
(2, 'Gelatine', 'Dit product bevat gelatine', b'1', NULL, '2024-12-05 08:18:28.004384', '2024-12-05 08:18:28.004384'),
(3, 'AZO-Kleurstof', 'Dit product bevat AZO-kleurstoffen', b'1', NULL, '2024-12-05 08:18:28.004406', '2024-12-05 08:18:28.004406'),
(4, 'Lactose', 'Dit product bevat lactose', b'1', NULL, '2024-12-05 08:18:28.004413', '2024-12-05 08:18:28.004413'),
(5, 'Soja', 'Dit product bevat soja', b'1', NULL, '2024-12-05 08:18:28.004418', '2024-12-05 08:18:28.004419');

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
CREATE TABLE IF NOT EXISTS `country` (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `Name` varchar(250) NOT NULL,
  `CapitalCity` varchar(250) NOT NULL,
  `Continent` varchar(250) NOT NULL,
  `Population` int UNSIGNED NOT NULL,
  `Zipcode` varchar(6) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `country`
--

INSERT INTO `country` (`Id`, `Name`, `CapitalCity`, `Continent`, `Population`, `Zipcode`) VALUES
(2, 'Argentini&euml;', 'Buenos Aires', 'Zuid-Amerika', 4294967294, '2309CC'),
(4, 'Japan', 'Tokio', 'Azi&euml;', 125700000, '8761EE'),
(5, 'Zwitserlandd', 'Bern', 'Europa', 8703000, '2345RR'),
(6, 'Noorwegen', 'Oslo', 'Europa', 5550203, '2314UT'),
(11, 'Litouwen', 'Vilnius', 'Europa', 340000000, '9382YY'),
(15, 'Marokko', 'Rabat', 'Afrika', 37500000, '1243HH'),
(16, 'Nepal', 'Kathmandu', 'Azi&euml;', 30000000, '6534GG'),
(17, 'Chili', 'Santiago', 'Zuid-Amerika', 18276870, '8347AA'),
(18, 'Japan', 'Tokio', 'Azi&euml;', 125700000, '2342TT');

-- --------------------------------------------------------

--
-- Table structure for table `leverancier`
--

DROP TABLE IF EXISTS `leverancier`;
CREATE TABLE IF NOT EXISTS `leverancier` (
  `Id` smallint UNSIGNED NOT NULL AUTO_INCREMENT,
  `Naam` varchar(60) NOT NULL,
  `Contactpersoon` varchar(60) NOT NULL,
  `Leveranciernummer` varchar(11) NOT NULL,
  `Mobiel` varchar(11) NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerkingen` varchar(255) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL,
  `DatumGewijzigd` datetime(6) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `leverancier`
--

INSERT INTO `leverancier` (`Id`, `Naam`, `Contactpersoon`, `Leveranciernummer`, `Mobiel`, `IsActief`, `Opmerkingen`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 'Venco', 'Bert van Linge', 'L1029384719', '06-28493827', b'1', NULL, '2024-12-05 08:18:27.806601', '2024-12-05 08:18:27.806605'),
(2, 'Astra Sweets', 'Jasper del Monte', 'L1029284315', '06-39398734', b'1', NULL, '2024-12-05 08:18:27.806670', '2024-12-05 08:18:27.806671'),
(3, 'Haribo', 'Sven Stalman', 'L1029324748', '06-24383291', b'1', NULL, '2024-12-05 08:18:27.806703', '2024-12-05 08:18:27.806703'),
(4, 'Basset', 'Joyce Stelterberg', 'L1023845773', '06-48293823', b'1', NULL, '2024-12-05 08:18:27.806716', '2024-12-05 08:18:27.806716'),
(5, 'De Bron', 'Remco Veenstra', 'L1023857736', '06-34291234', b'1', NULL, '2024-12-05 08:18:27.806725', '2024-12-05 08:18:27.806726');

-- --------------------------------------------------------

--
-- Table structure for table `leveranciers`
--

DROP TABLE IF EXISTS `leveranciers`;
CREATE TABLE IF NOT EXISTS `leveranciers` (
  `leverancier_id` int NOT NULL AUTO_INCREMENT,
  `naam` varchar(255) NOT NULL,
  `adres` varchar(255) DEFAULT NULL,
  `telefoonnummer` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `IsActief` bit(1) DEFAULT NULL,
  `Opmerking` varchar(255) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) DEFAULT NULL,
  `DatumGewijzigd` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`leverancier_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `leverancier_producten`
--

DROP TABLE IF EXISTS `leverancier_producten`;
CREATE TABLE IF NOT EXISTS `leverancier_producten` (
  `leverancier_id` int NOT NULL,
  `product_id` int NOT NULL,
  `aantal_geleverde_producten` int DEFAULT '0',
  `laatst_geleverde_datum` date DEFAULT NULL,
  `IsActief` bit(1) DEFAULT NULL,
  `Opmerking` varchar(255) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) DEFAULT NULL,
  `DatumGewijzigd` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`leverancier_id`,`product_id`),
  KEY `product_id` (`product_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `magazijn`
--

DROP TABLE IF EXISTS `magazijn`;
CREATE TABLE IF NOT EXISTS `magazijn` (
  `Id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT,
  `ProductId` mediumint UNSIGNED NOT NULL,
  `VerpakkingsEenheid` decimal(4,1) NOT NULL,
  `AantalAanwezig` smallint UNSIGNED NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerkingen` varchar(255) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL,
  `DatumGewijzigd` datetime(6) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_Magazijn_ProductId_Product_Id` (`ProductId`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `magazijn`
--

INSERT INTO `magazijn` (`Id`, `ProductId`, `VerpakkingsEenheid`, `AantalAanwezig`, `IsActief`, `Opmerkingen`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 1, 5.0, 453, b'1', NULL, '2024-12-05 08:18:27.709523', '2024-12-05 08:18:27.709526'),
(2, 2, 2.5, 400, b'1', NULL, '2024-12-05 08:18:27.709592', '2024-12-05 08:18:27.709592'),
(3, 3, 5.0, 1, b'1', NULL, '2024-12-05 08:18:27.709620', '2024-12-05 08:18:27.709620'),
(4, 4, 1.0, 800, b'1', NULL, '2024-12-05 08:18:27.709638', '2024-12-05 08:18:27.709638'),
(5, 5, 3.0, 234, b'1', NULL, '2024-12-05 08:18:27.709664', '2024-12-05 08:18:27.709665'),
(6, 6, 2.0, 345, b'1', NULL, '2024-12-05 08:18:27.709685', '2024-12-05 08:18:27.709686'),
(7, 7, 1.0, 795, b'1', NULL, '2024-12-05 08:18:27.709702', '2024-12-05 08:18:27.709703'),
(8, 8, 10.0, 233, b'1', NULL, '2024-12-05 08:18:27.709717', '2024-12-05 08:18:27.709718'),
(9, 9, 2.5, 123, b'1', NULL, '2024-12-05 08:18:27.709733', '2024-12-05 08:18:27.709733'),
(10, 10, 3.0, 0, b'1', NULL, '2024-12-05 08:18:27.709748', '2024-12-05 08:18:27.709748'),
(11, 11, 2.0, 367, b'1', NULL, '2024-12-05 08:18:27.709762', '2024-12-05 08:18:27.709763'),
(12, 12, 1.0, 467, b'1', NULL, '2024-12-05 08:18:27.709777', '2024-12-05 08:18:27.709778'),
(13, 13, 5.0, 20, b'1', NULL, '2024-12-05 08:18:27.709792', '2024-12-05 08:18:27.709793');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `Id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT,
  `Naam` varchar(255) NOT NULL,
  `Barcode` varchar(13) NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerkingen` varchar(255) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL,
  `DatumGewijzigd` datetime(6) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`Id`, `Naam`, `Barcode`, `IsActief`, `Opmerkingen`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 'Mintnopjes', '8719587231278', b'1', NULL, '2024-12-05 08:18:27.581026', '2024-12-05 08:18:27.581030'),
(2, 'Schoolkrijt', '8719587326713', b'1', NULL, '2024-12-05 08:18:27.581099', '2024-12-05 08:18:27.581100'),
(3, 'Honingdrop', '8719587327836', b'1', NULL, '2024-12-05 08:18:27.581122', '2024-12-05 08:18:27.581123'),
(4, 'Zure Beren', '8719587321441', b'1', NULL, '2024-12-05 08:18:27.581131', '2024-12-05 08:18:27.581131'),
(5, 'Cola Flesjes', '8719587321237', b'1', NULL, '2024-12-05 08:18:27.581139', '2024-12-05 08:18:27.581139'),
(6, 'Turtles', '8719587322245', b'1', NULL, '2024-12-05 08:18:27.581147', '2024-12-05 08:18:27.581147'),
(7, 'Witte Muizen', '8719587328256', b'1', NULL, '2024-12-05 08:18:27.581154', '2024-12-05 08:18:27.581154'),
(8, 'Reuzen Slangen', '8719587325641', b'1', NULL, '2024-12-05 08:18:27.581162', '2024-12-05 08:18:27.581162'),
(9, 'Zoute Rijen', '8719587322739', b'1', NULL, '2024-12-05 08:18:27.581170', '2024-12-05 08:18:27.581170'),
(10, 'Winegums', '8719587327527', b'1', NULL, '2024-12-05 08:18:27.581177', '2024-12-05 08:18:27.581178'),
(11, 'Drop Munten', '8719587322345', b'1', NULL, '2024-12-05 08:18:27.581184', '2024-12-05 08:18:27.581185'),
(12, 'Kruis Drop', '8719587322265', b'1', NULL, '2024-12-05 08:18:27.581192', '2024-12-05 08:18:27.581192'),
(13, 'Zoute Ruitjes', '8719587323256', b'1', NULL, '2024-12-05 08:18:27.581200', '2024-12-05 08:18:27.581200');

-- --------------------------------------------------------

--
-- Table structure for table `producten`
--

DROP TABLE IF EXISTS `producten`;
CREATE TABLE IF NOT EXISTS `producten` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `naam` varchar(255) NOT NULL,
  `categorie` varchar(100) DEFAULT NULL,
  `prijs` decimal(10,2) DEFAULT NULL,
  `IsActief` bit(1) DEFAULT NULL,
  `Opmerking` varchar(255) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) DEFAULT NULL,
  `DatumGewijzigd` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `productperallergeen`
--

DROP TABLE IF EXISTS `productperallergeen`;
CREATE TABLE IF NOT EXISTS `productperallergeen` (
  `Id` smallint UNSIGNED NOT NULL AUTO_INCREMENT,
  `ProductId` mediumint UNSIGNED NOT NULL,
  `AllergeenId` tinyint UNSIGNED NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerkingen` varchar(255) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL,
  `DatumGewijzigd` datetime(6) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_ProductPerAllergeen_ProductId_Product_Id` (`ProductId`),
  KEY `FK_ProductPerAllergeen_AllergeenId_Allergeen_Id` (`AllergeenId`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `productperallergeen`
--

INSERT INTO `productperallergeen` (`Id`, `ProductId`, `AllergeenId`, `IsActief`, `Opmerkingen`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 1, 2, b'1', NULL, '2024-12-05 08:18:28.105440', '2024-12-05 08:18:28.105443'),
(2, 1, 1, b'1', NULL, '2024-12-05 08:18:28.105518', '2024-12-05 08:18:28.105519'),
(3, 1, 3, b'1', NULL, '2024-12-05 08:18:28.105550', '2024-12-05 08:18:28.105550'),
(4, 3, 4, b'1', NULL, '2024-12-05 08:18:28.105565', '2024-12-05 08:18:28.105565'),
(5, 6, 5, b'1', NULL, '2024-12-05 08:18:28.105577', '2024-12-05 08:18:28.105578'),
(6, 9, 2, b'1', NULL, '2024-12-05 08:18:28.105591', '2024-12-05 08:18:28.105591'),
(7, 9, 5, b'1', NULL, '2024-12-05 08:18:28.105608', '2024-12-05 08:18:28.105608'),
(8, 10, 2, b'1', NULL, '2024-12-05 08:18:28.105623', '2024-12-05 08:18:28.105623'),
(9, 12, 4, b'1', NULL, '2024-12-05 08:18:28.105636', '2024-12-05 08:18:28.105636'),
(10, 13, 1, b'1', NULL, '2024-12-05 08:18:28.105649', '2024-12-05 08:18:28.105649'),
(11, 13, 4, b'1', NULL, '2024-12-05 08:18:28.105663', '2024-12-05 08:18:28.105663'),
(12, 13, 5, b'1', NULL, '2024-12-05 08:18:28.105674', '2024-12-05 08:18:28.105675');

-- --------------------------------------------------------

--
-- Table structure for table `productperleverancier`
--

DROP TABLE IF EXISTS `productperleverancier`;
CREATE TABLE IF NOT EXISTS `productperleverancier` (
  `Id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT,
  `LeverancierId` smallint UNSIGNED NOT NULL,
  `ProductId` mediumint UNSIGNED NOT NULL,
  `DatumLevering` date NOT NULL,
  `Aantal` int UNSIGNED NOT NULL,
  `DatumEerstVolgendeLevering` date NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerkingen` varchar(255) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL,
  `DatumGewijzigd` datetime(6) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_ProductPerLeverancier_LeverancierId_Leverancier_Id` (`LeverancierId`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `productperleverancier`
--

INSERT INTO `productperleverancier` (`Id`, `LeverancierId`, `ProductId`, `DatumLevering`, `Aantal`, `DatumEerstVolgendeLevering`, `IsActief`, `Opmerkingen`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 1, 1, '2024-10-09', 23, '2024-10-16', b'1', NULL, '2024-12-05 08:18:27.935909', '2024-12-05 08:18:27.935912'),
(2, 1, 1, '2024-10-18', 21, '2024-10-25', b'1', NULL, '2024-12-05 08:18:27.935988', '2024-12-05 08:18:27.935988'),
(3, 1, 2, '2024-10-09', 12, '2024-10-16', b'1', NULL, '2024-12-05 08:18:27.936010', '2024-12-05 08:18:27.936011'),
(4, 1, 3, '2024-10-10', 11, '2024-10-17', b'1', NULL, '2024-12-05 08:18:27.936030', '2024-12-05 08:18:27.936031'),
(5, 2, 4, '2024-10-14', 16, '2024-10-21', b'1', NULL, '2024-12-05 08:18:27.936049', '2024-12-05 08:18:27.936049'),
(6, 2, 4, '2024-10-21', 23, '2024-10-28', b'1', NULL, '2024-12-05 08:18:27.936067', '2024-12-05 08:18:27.936067'),
(7, 2, 5, '2024-10-14', 45, '2024-10-21', b'1', NULL, '2024-12-05 08:18:27.936091', '2024-12-05 08:18:27.936091'),
(8, 2, 6, '2024-10-14', 30, '2024-10-21', b'1', NULL, '2024-12-05 08:18:27.936109', '2024-12-05 08:18:27.936109'),
(9, 3, 7, '2024-10-12', 12, '2024-10-19', b'1', NULL, '2024-12-05 08:18:27.936130', '2024-12-05 08:18:27.936130'),
(10, 3, 7, '2024-10-19', 23, '2024-10-26', b'1', NULL, '2024-12-05 08:18:27.936147', '2024-12-05 08:18:27.936147'),
(11, 3, 8, '2024-10-10', 12, '2024-10-17', b'1', NULL, '2024-12-05 08:18:27.936162', '2024-12-05 08:18:27.936163'),
(12, 3, 9, '2024-10-11', 1, '2024-10-18', b'1', NULL, '2024-12-05 08:18:27.936180', '2024-12-05 08:18:27.936181'),
(13, 4, 10, '2024-10-16', 24, '2024-10-30', b'1', NULL, '2024-12-05 08:18:27.936198', '2024-12-05 08:18:27.936198'),
(14, 5, 11, '2024-10-10', 47, '2024-10-17', b'1', NULL, '2024-12-05 08:18:27.936216', '2024-12-05 08:18:27.936217'),
(15, 5, 11, '2024-10-19', 60, '2024-10-26', b'1', NULL, '2024-12-05 08:18:27.936232', '2024-12-05 08:18:27.936233'),
(16, 5, 12, '2024-10-11', 45, '0000-00-00', b'1', NULL, '2024-12-05 08:18:27.936527', '2024-12-05 08:18:27.936530'),
(17, 5, 13, '2024-10-12', 23, '0000-00-00', b'1', NULL, '2024-12-05 08:18:27.936576', '2024-12-05 08:18:27.936576');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `magazijn`
--
ALTER TABLE `magazijn`
  ADD CONSTRAINT `FK_Magazijn_ProductId_Product_Id` FOREIGN KEY (`ProductId`) REFERENCES `product` (`Id`);

--
-- Constraints for table `productperallergeen`
--
ALTER TABLE `productperallergeen`
  ADD CONSTRAINT `FK_ProductPerAllergeen_AllergeenId_Allergeen_Id` FOREIGN KEY (`AllergeenId`) REFERENCES `allergeen` (`Id`),
  ADD CONSTRAINT `FK_ProductPerAllergeen_ProductId_Product_Id` FOREIGN KEY (`ProductId`) REFERENCES `product` (`Id`);

--
-- Constraints for table `productperleverancier`
--
ALTER TABLE `productperleverancier`
  ADD CONSTRAINT `FK_ProductPerLeverancier_LeverancierId_Leverancier_Id` FOREIGN KEY (`LeverancierId`) REFERENCES `leverancier` (`Id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
