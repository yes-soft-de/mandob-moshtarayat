<?php

namespace App\Request;

class ClientUpdateFavouriteCategoriesRequest
{
    private $clientID;

    private $favouriteCategories;

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