<?php

namespace App\Request;

class OrderUpdateStateForEachStoreByCaptainRequest
{
    private $id;

    private $orderNumber;

    private $state;

    private $storeOwnerProfileID;

    private $captainID;


    /**
     * Get the value of id
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set the value of id
     *
     * @return  self
     */
    public function setId($id)
    {
        $this->id = $id;

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

    public function setStoreOwnerProfileID($storeOwnerProfileID): void
    {
        $this->storeOwnerProfileID = $storeOwnerProfileID;
    }

    public function getStoreOwnerProfileID()
    {
        return $this->storeOwnerProfileID;
    }

    public function setCaptainID($captainID): void
    {
        $this->captainID = $captainID;
    }

    public function getCaptainID()
    {
        return $this->captainID;
    }
}