<?php

namespace App\Request;

class OrderUpdateInvoiceByCaptainRequest
{
    private $orderNumber;

    private $orderDetailID;

    private $captainID;

    private $storeOwnerProfileID;

    private $invoiceAmount;

    private $invoiceImage;

    private $orderInvoice;

    public function getOrderNumber()
    {
        return $this->orderNumber;
    }

    public function setOrderNumber($orderNumber)
    {
        $this->orderNumber = $orderNumber;
        return $this;
    }

    public function getOrderDetailID()
    {
        return $this->orderDetailID;
    }

    public function setOrderDetailID($orderDetailID)
    {
        $this->orderDetailID = $orderDetailID;
        return $this;
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

    public function getStoreOwnerProfileID()
    {
        return $this->storeOwnerProfileID;
    }

    public function setStoreOwnerProfileID($storeOwnerProfileID)
    {
        $this->storeOwnerProfileID = $storeOwnerProfileID;

        return $this;
    }

    public function getOrderInvoiceId(): ?int
    {
        return $this->orderInvoiceId;
    }

    public function setOrderInvoiceId(int $orderInvoiceId): self
    {
        $this->orderInvoiceId = $orderInvoiceId;

        return $this;
    }

}
