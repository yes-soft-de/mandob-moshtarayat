<?php

namespace App\Request;

class OrderUpdateByClientRequest
{
    private $orderNumber;
    
    private $storeOwnerProfileID;
    
    private $destination = [];
    
    private $deliveryDate;
    
    private $note;
    
    private $payment;
    
    private $recipientName;
    
    private $recipientPhone;
    
    private $products;
    
    private $orderCost;

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
    
     /**
     * @param mixed $storeOwnerProfileID
     */
    public function setStoreOwnerProfileID($storeOwnerProfileID): void
    {
        $this->storeOwnerProfileID = $storeOwnerProfileID;
    }

     /**
     * @return mixed
     */
    public function getStoreOwnerProfileID()
    {
        return $this->storeOwnerProfileID;
    }

    /**
     * Get the value of products
     */ 
    public function getProducts()
    {
        return $this->products;
    }

    /**
     * Set the value of products
     *
     * @return  self
     */ 
    public function setProducts($products)
    {
        $this->products = $products;

        return $this;
    }

    /**
     * Get the value of deliveryDate
     */ 
    public function getDeliveryDate()
    {
        return $this->deliveryDate;
    }

    /**
     * Set the value of deliveryDate
     *
     * @return  self
     */ 
    public function setDeliveryDate($deliveryDate)
    {
        $this->deliveryDate = $deliveryDate;

        return $this;
    }

    /**
     * Get the value of note
     */ 
    public function getNote()
    {
        return $this->note;
    }

    /**
     * Get the value of payment
     */ 
    public function getPayment()
    {
        return $this->payment;
    }

    /**
     * Set the value of payment
     *
     * @return  self
     */ 
    public function setPayment($payment)
    {
        $this->payment = $payment;

        return $this;
    }

    /**
     * Get the value of recipientName
     */ 
    public function getRecipientName()
    {
        return $this->recipientName;
    }

    /**
     * Set the value of recipientName
     *
     * @return  self
     */ 
    public function setRecipientName($recipientName)
    {
        $this->recipientName = $recipientName;

        return $this;
    }

    /**
     * Get the value of recipientPhone
     */ 
    public function getRecipientPhone()
    {
        return $this->recipientPhone;
    }

    /**
     * Set the value of recipientPhone
     *
     * @return  self
     */ 
    public function setRecipientPhone($recipientPhone)
    {
        $this->recipientPhone = $recipientPhone;

        return $this;
    }

    /**
     * Get the value of orderCost
     */ 
    public function getOrderCost()
    {
        return $this->orderCost;
    }

    /**
     * Set the value of orderCost
     *
     * @return  self
     */ 
    public function setOrderCost($orderCost)
    {
        $this->orderCost = $orderCost;

        return $this;
    }

    /**
     * Get the value of destination
     */ 
    public function getDestination()
    {
        return $this->destination;
    }

    /**
     * Set the value of destination
     *
     * @return  self
     */ 
    public function setDestination($destination)
    {
        $this->destination = $destination;

        return $this;
    }
}
