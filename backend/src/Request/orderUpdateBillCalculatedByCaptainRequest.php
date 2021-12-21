<?php

namespace App\Request;

class orderUpdateBillCalculatedByCaptainRequest
{
    private $id;

    private $captainID;

    private $orderNumber;

    private $isBillCalculated;


    public function getId()
    {
        return $this->id;
    }

    public function setId($id): void
    {
        $this->id = $id;
    }

    public function getCaptainID()
    {
        return $this->captainID;
    }

    public function setCaptainID($captainID)
    {
        $this->captainID = $captainID;

        return $this;
    }

    public function getOrderNumber()
    {
        return $this->orderNumber;
    }

    public function setOrderNumber($orderNumber)
    {
        $this->orderNumber = $orderNumber;

        return $this;
    }

    /**
     * @return mixed
     */
    public function getIsBillCalculated()
    {
        return $this->isBillCalculated;
    }

    /**
     * @param mixed $isBillCalculated
     */
    public function setIsBillCalculated($isBillCalculated): void
    {
        $this->isBillCalculated = $isBillCalculated;
    }
}
