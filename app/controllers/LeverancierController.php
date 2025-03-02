<?php

class LeverancierController extends BaseController
{
    private $leverancierModel;

    public function __construct()
    {
        $this->leverancierModel = $this->model('LeverancierModel'); // Laad het model
    }

    // ✅ Toon overzicht van leveranciers
    public function index($limit = LIMIT, $offset = 0)
    {
        $data = [
            'title' => 'Overzicht Leveranciers',
            'message' => null,
            'messageColor' => null,
            'messageVisibility' => 'none',
            'dataRows' => null,
            'pagination' => null
        ];

        $result = $this->leverancierModel->getAllLeveranciers($limit, $offset);

        if (!$result) {
            // ❌ Foutafhandeling
            $data['message'] = "Er is een fout opgetreden bij het ophalen van leveranciers.";
            $data['messageColor'] = "danger";
            $data['messageVisibility'] = "flex";
        } else {
            $data['dataRows'] = $result;
            $data['pagination'] = new Pagination($result[0]->TotalRows, $limit, $offset, CLASS, __FUNCTION);
        }

        $this->view('leverancier/index', $data); // ✅ Toon de leveranciers in de view
    }

    // ✅ Toon details van een specifieke leverancier
    public function readLeverancierById($leverancierId)
    {
        $data = [
            'title' => 'Leverancier Informatie',
            'message' => null,
            'messageColor' => null,
            'messageVisibility' => 'none',
            'dataRows' => null
        ];

        $result = $this->leverancierModel->getLeverancierById($leverancierId);

        if (!$result) {
            // ❌ Foutafhandeling
            $data['message'] = "Er is een fout opgetreden bij het ophalen van leveranciergegevens.";
            $data['messageColor'] = "danger";
            $data['messageVisibility'] = "flex";
        } else {
            $data['dataRows'] = $result;
        }

        $this->view('leverancier/readLeverancierById', $data);
    }

    // ✅ Haal geleverde producten per leverancier op
    public function geleverdeProducten($leverancierId)
    {
        $data = [
            'title' => 'Geleverde Producten',
            'message' => null,
            'messageColor' => null,
            'messageVisibility' => 'none',
            'dataRows' => null
        ];

        $result = $this->leverancierModel->getGeleverdeProductenPerLeverancier($leverancierId);

        if (!$result) {
            // ❌ Foutafhandeling
            $data['message'] = "Er zijn geen geleverde producten gevonden voor deze leverancier.";
            $data['messageColor'] = "warning";
            $data['messageVisibility'] = "flex";
        } else {
            $data['dataRows'] = $result;
        }

        $this->view('leverancier/geleverdeProducten', $data);
    }

    // ✅ Voeg een nieuwe leverancier toe
    public function addLeverancier()
    {
        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            $naam = trim($_POST['naam']);
            $adres = trim($_POST['adres']);
            $contact = trim($_POST['contact']);

            if (empty($naam) || empty($adres) || empty($contact)) {
                echo "Vul alle velden in!";
                return;
            }

            $result = $this->leverancierModel->addLeverancier($naam, $adres, $contact);

            if ($result) {
                header('Location: ' . URLROOT . '/LeverancierController/index');
                exit();
            } else {
                // ❌ Foutafhandeling bij toevoegen
                echo "Er is een fout opgetreden bij het toevoegen van de leverancier.";
            }
        } else {
            // ✅ Toon formulier voor het toevoegen van een leverancier
            $this->view('leverancier/addLeverancier');
        }
    }
}