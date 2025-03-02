<?php
class AllergenenModel {
    private $db;

    public function __construct() {
        $this->db = new Database(); // ✅ Maak database connectie
    }

    public function getAllergenenOverzicht() {
        try {
            $this->db->query("CALL spReadAllergenenOverzicht()");
            
            // ✅ Print debug informatie
            echo "<pre>Query uitgevoerd: CALL spReadAllergenenOverzicht();</pre>";
    
            $result = $this->db->resultSet();
            
            return $result;
        } catch (Exception $e) {
            echo "Database error: " . $e->getMessage();
            exit();
        }
    }

    public function getAllergenenPerProduct($allergeenId) {
        try {
            $this->db->query("CALL spReadAllergenenPerProduct(:allergeenId)");
            $this->db->bind(':allergeenId', $allergeenId, PDO::PARAM_INT);
            return $this->db->resultSet();
        } catch (Exception $e) {
            logger(_LINE, __METHOD, __FILE_, $e->getMessage()); // ❌ Log fouten
            return null;
        }
    }
}
