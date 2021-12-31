<?php

namespace App\Request;

class ClientProfileNeedSupportUpdateRequest
{
    private $clientID;

    private $needSupport;

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