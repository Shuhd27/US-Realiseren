<?php

class Magazijn extends BaseController
{
    private $magazijnModel;

    public function __construct()
    {
        $this->magazijnModel = $this->model('MagazijnModel');
    }

    public function index($limit = LIMIT, $offset = 0)
    {
        $data = [
            'title' => 'Overzicht Magazijn Jamin',
            'message' => NULL,
            'messageColor' => NULL,
            'messageVisibility' => 'none',
            'dataRows' => NULL,
            'pagination' => NULL
        ];

        $result = $this->magazijnModel->getAllMagazijnProducts($limit, $offset);



        if (is_null($result)) {
            // Fout afhandelen
            $data['message'] = "Er is een fout opgetreden in de database";
            $data['messageColor'] = "danger";
            $data['messageVisibility'] = "flex";
            $data['dataRows'] = NULL;

            header('Refresh:3; url=' . URLROOT . '/Homepages/index');
        } else {
            $data['dataRows'] = $result;
            $data['pagination'] = new Pagination($result[0]->TotalRows, $limit, $offset, __CLASS__, __FUNCTION__);
        }

        $this->view('magazijn/index', $data);
    }

    public function readProductPerLeverancierById($productId)
    {
        $data = [
            'title' => 'Levering Informatie',
            'message' => NULL,
            'messageColor' => NULL,
            'messageVisibility' => 'none',
            'dataRows' => NULL
        ];

        $result = $this->magazijnModel->getProductPerLeverancierById($productId);

        if (is_null($result)) {
            // Fout afhandelen
            $data['message'] = "Er is een fout opgetreden in de database";
            $data['messageColor'] = "danger";
            $data['messageVisibility'] = "flex";
            $data['dataRows'] = NULL;

            header('Refresh:3; url=' . URLROOT . '/Homepages/index');
        } else {
            $data['dataRows'] = $result;
        }

        $this->view('magazijn/readProductPerLeverancierById', $data);
    }

    public function Allergeninfo($productId)
    {
        $data = [
            'title' => 'Overzicht Allergenen',
            'message' => NULL,
            'messageColor' => NULL,
            'messageVisibility' => 'none',
            'dataRows' => NULL
        ];

        $result = $this->magazijnModel->getAllergeenPerProductById($productId);

        if (is_null($result)) {
            // Fout afhandelen
            $data['message'] = "Er is een fout opgetreden in de database";
            $data['messageColor'] = "danger";
            $data['messageVisibility'] = "flex";
            $data['dataRows'] = NULL;

            header('Refresh:3; url=' . URLROOT . '/Magazijn/index');
        } else if(empty($result)) {
            echo "Hoi";

            $result = $this->magazijnModel->getProductById($productId);

            var_dump($result);

            $data['dataRows'] = $result;
        } else {
            $data['dataRows'] = $result;
        }

        $this->view('magazijn/AllergenenInfo', $data);
    }
}