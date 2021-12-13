<?php

namespace App\Request;

class OrderUpdateInvoiceByCaptainRequest
{
    private $orderDetailID;

    private $captainID;

    private $invoiceAmount;

    private $invoiceImage;

    private $updatedAt;

    public function getOrderDetailID()
    {
        return $this->orderDetailID;
    }

    public function getCaptainID()
    {
        return $this->captainID;
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
