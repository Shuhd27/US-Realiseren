<?php

class Pagination
{
    public $totalRows;
    public $limit;
    public $offset;
    public $totalPages;
    public $class;
    public $method;


    public function __construct($totalRows, $limit, $offset, $class, $method)
    {
        $this->totalRows = $totalRows;
        $this->limit = $limit;
        $this->offset = $offset;
        $this->class = $class;
        $this->method = $method;
        $this->totalPages = ceil($totalRows / $limit);

    }

    public function previousPage()
    {
        if ($this->offset > 0) {
            return $this->offset - $this->limit;
        } else {
            return 0;
        }
    }

    public function nextPage()
    {
        if ($this->offset + $this->limit < $this->totalRows) {
            return $this->offset + $this->limit;
        } else {
            return $this->offset;
        }
    }

    public function paginationView()
    {

        $paginationView  = '<nav aria-label="Page navigation example">';
        $paginationView .= '<ul class="pagination pagination-sm justify-content-end">';
        $paginationView .= '<li class="page-item"><a class="page-link" href="' . URLROOT . '/' . $this->class . '/' . $this->method . '/' . $this->limit. '/' . $this->previousPage() . '">Previous</a></li>';

        for ($i = 1; $i <= $this->totalPages; $i++) {
            $paginationView .= '<li class="page-item"><a class="page-link" href="' . URLROOT . '/' . $this->class . '/' . $this->method . '/' . $this->limit . '/' . $this->limit * ($i-1) . '">' . $i . '</a></li>';
        }
        
        $paginationView .= '<li class="page-item"><a class="page-link" href="' . URLROOT . '/' . $this->class . '/' . $this->method . '/' . $this->limit. '/' . $this->nextPage() . '">Next</a></li>';
        $paginationView .= '</ul>';
        $paginationView .= '</nav>';

        return $paginationView;

    }
}