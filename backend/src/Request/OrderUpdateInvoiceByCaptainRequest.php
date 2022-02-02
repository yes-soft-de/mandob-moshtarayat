<?php

namespace App\Request;

class OrderUpdateInvoiceByCaptainRequest
{
    private $id;

    private $captainID;
    
    private $orderNumber;

    private $invoiceAmount;

    private $invoiceImage;

    private $updatedAt;
    
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

    public function getInvoiceAmount()
    {
        return $this->invoiceAmount;
    }

    public function setInvoiceAmount($invoiceAmount)
    {
        $this->invoiceAmount = $invoiceAmount;

        return $this;
    }

    public function getInvoiceImage()
    {
        return $this->invoiceImage;
    }

    public function setInvoiceImage($invoiceImage)
    {
        $this->invoiceImage = $invoiceImage;

        return $this;
    }
}
