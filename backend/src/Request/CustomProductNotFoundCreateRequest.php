<?php

namespace App\Request;

class CustomProductNotFoundCreateRequest
{
    private $clientID;

    private $productName;

    private $productImage;

    private $detail;

    /**
     * @return mixed
     */
    public function getClientID()
    {
        return $this->clientID;
    }

    /**
     * @param mixed $clientID
     */
    public function setClientID($clientID): void
    {
        $this->clientID = $clientID;
    }

}