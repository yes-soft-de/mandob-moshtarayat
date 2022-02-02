<?php

namespace App\Request;

class OrderUpdateStateByCaptainRequest
{
    private $id;
    
    private $orderNumber;

    private $state;

    private $updatedAt;
    
    private $kilometer;

    private $captainID;

    private $deliveryCost;

    
    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * @param mixed $id
     */
    public function setId($id): void
    {
        $this->id = $id;
    }

    /**
     * @return mixed
     */ 
    public function getState()
    {
        return $this->state;
    }

    /**
     * @return mixed
     */  
    public function getKilometer()
    {
        return $this->kilometer;
    }

    /**
     * Set the value of kilometer
     *
     * @return  self
     */ 
    public function setKilometer($kilometer)
    {
        $this->kilometer = $kilometer;

        return $this;
    }

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

    /**
     * Get the value of orderNumber
     */ 
    public function getOrderNumber()
    {
        return $this->orderNumber;
    }

    /**
     * Set the value of orderNumber
     *
     * @return  self
     */ 
    public function setOrderNumber($orderNumber)
    {
        $this->orderNumber = $orderNumber;

        return $this;
    }

    public function getDeliveryCost()
    {
        return $this->deliveryCost;
    }
 
    public function setDeliveryCost($deliveryCost)
    {
        $this->deliveryCost = $deliveryCost;

        return $this;
    }
}
