<?php

namespace App\Request;

class ActivateMandobAccountByAdminRequest
{
    public $id;

    public $status;

    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }
}