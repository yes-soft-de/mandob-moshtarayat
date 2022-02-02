<?php

namespace App\Request;

class OrderUpdateSpecialByClientRequest
{
    private $orderNumber;
    
    private $storeOwnerProfileID;
    
    private $destination = [];
    
    private $deliveryDate;
    
    private $note;
    
    private $payment;
    
    private $detail;

    
    public function getOrderNumber()
    {
        return $this->orderNumber;
    }

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
 
    public function getDeliveryDate()
    {
        return $this->deliveryDate;
    }

    public function setDeliveryDate($deliveryDate)
    {
        $this->deliveryDate = $deliveryDate;

        return $this;
    }

    public function getNote()
    {
        return $this->note;
    }
 
    public function getPayment()
    {
        return $this->payment;
    }

    public function setPayment($payment)
    {
        $this->payment = $payment;

        return $this;
    }
 
    public function getOrderCost()
    {
        return $this->orderCost;
    }

    public function setOrderCost($orderCost)
    {
        $this->orderCost = $orderCost;

        return $this;
    }

    public function getDestination()
    {
        return $this->destination;
    }
 
    public function setDestination($destination)
    {
        $this->destination = $destination;

        return $this;
    }

    public function getDetail()
    {
        return $this->detail;
    }

    public function setDetail($detail)
    {
        $this->detail = $detail;

        return $this;
    }
}
