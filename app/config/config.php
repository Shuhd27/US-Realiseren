<?php
/**
 * De database verbindingsgegevens
 */
define('DB_HOST', 'localhost');
define('DB_NAME', 'jamin_b_new');
define('DB_USER', 'root');
define('DB_PASS', '');


/**
 * De naam van de virtualhost
 */
define('URLROOT', 'http://us-realiseren.nl');


/**
 * Het pad naar de folder app
 */
define('APPROOT', dirname(dirname(__FILE__)));

/**
 * Geef aan hoeveel items er per pagina getoond moeten worden
 */
define('LIMIT', 3);

/*
try {
    $pdo = new PDO("mysql:host=" . DB_HOST . ";dbname=" . DB_NAME, DB_USER, DB_PASS);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    echo "Verbinding met database succesvol!";
} catch (PDOException $e) {
    echo "Databasefout: " . $e->getMessage();
    exit();
}
*/