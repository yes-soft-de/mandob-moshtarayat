<?php

namespace App\Request;

class ClientPaymentCreateRequest
{
    private $captainID;
   
    private $clientID;
   
    private $orderID;
   
    private $amount;

   

    /**
     * Get the value of captainID
     */ 
    public function getCaptainID()
    {
        return $this->captainID;
    }

    /**
     * Set the value of captainID
     *
     * @return  self
     */ 
    public function setCaptainID($captainID)
    {
        $this->captainID = $captainID;

        return $this;
    }
}
