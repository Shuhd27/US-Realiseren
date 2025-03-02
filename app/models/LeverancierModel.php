<?php

class LeverancierModel
{
    private $db;

    public function __construct()
    {
        $this->db = new Database(); // Database object, verbinding maken met MySQL
    }

    // ✅ Haal alle leveranciers op
    public function getAllLeveranciers($limit, $offset)
    {
        try {
            $sql = "CALL spReadLeveranciers(:limit, :offset)";

            $this->db->query($sql);
            $this->db->bind(':limit', $limit, PDO::PARAM_INT);
            $this->db->bind(':offset', $offset, PDO::PARAM_INT);

            return $this->db->resultSet();
        } catch (Exception $e) {
            logger(LINE, __METHOD, __FILE_, $e->getMessage()); // Log foutmelding
            return null;
        }
    }

    // ✅ Haal een leverancier op aan de hand van een ID
    public function getLeverancierById($leverancierId)
    {
        try {
            $sql = "CALL spReadLeverancierById(:leverancierId)";
            
            $this->db->query($sql);
            $this->db->bind(':leverancierId', $leverancierId, PDO::PARAM_INT);

            return $this->db->single();
        } catch (Exception $e) {
            logger(LINE, __METHOD, __FILE_, $e->getMessage()); // Log foutmelding
            return null;
        }
    }

    // ✅ Haal geleverde producten per leverancier op
    public function getGeleverdeProductenPerLeverancier($leverancierId)
    {
        try {
            $sql = "CALL GetGeleverdeProductenPerLeverancier(:leverancierId)";
            
            $this->db->query($sql);
            $this->db->bind(':leverancierId', $leverancierId, PDO::PARAM_INT);

            return $this->db->resultSet();
        } catch (Exception $e) {
            logger(LINE, __METHOD, __FILE_, $e->getMessage()); // Log foutmelding
            return null;
        }
    }

    // ✅ Voeg een nieuwe leverancier toe
    public function addLeverancier($naam, $adres, $contact)
    {
        try {
            $sql = "CALL spInsertLeverancier(:naam, :adres, :contact)";
            
            $this->db->query($sql);
            $this->db->bind(':naam', $naam);
            $this->db->bind(':adres', $adres);
            $this->db->bind(':contact', $contact);
            
            return $this->db->execute();
        } catch (Exception $e) {
            logger(LINE, __METHOD, __FILE_, $e->getMessage()); // Log foutmelding
            return false;
        }
    }
}
