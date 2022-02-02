<?php

namespace App\Request;

class ClientByUserIdGetRequest
{
    private $clientID;

    /**
     * @param mixed $clientID
     */
    public function setClientID($clientID): void
    {
        $this->clientID = $clientID;
    }

    /**
     * @return mixed
     */
    public function getClientID()
    {
        return $this->clientID;
    }

}