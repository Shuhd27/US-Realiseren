<?php
class AllergenenController extends BaseController {
    private $allergenenModel;

    public function __construct() {
        $this->allergenenModel = $this->model('AllergenenModel'); // ✅ Gebruik model loader
    }

    public function index() {
        $result = $this->allergenenModel->getAllergenenOverzicht();
        
        if (!$result) { 
            // ❌ Geen data? Geef een foutmelding
            $data = [
                'title' => 'Overzicht Allergenen',
                'message' => 'Geen allergenen gevonden!',
                'messageColor' => 'warning',
                'messageVisibility' => 'flex',
                'allergenen' => []
            ];
        } else {
            $data = [
                'title' => 'Overzicht Allergenen',
                'allergenen' => $result
            ];
        }

        $this->view('allergenen/index', $data);
    }

    public function filter($allergeenId) {
        $result = $this->allergenenModel->getAllergenenPerProduct($allergeenId);

        if (!$result) {
            $data = [
                'title' => 'Gefilterd Allergenen Overzicht',
                'message' => 'Geen producten gevonden met dit allergeen!',
                'messageColor' => 'danger',
                'messageVisibility' => 'flex',
                'allergenen' => []
            ];
        } else {
            $data = [
                'title' => 'Gefilterd Allergenen Overzicht',
                'allergenen' => $result
            ];
        }

        $this->view('allergenen/index', $data);
    }
}
