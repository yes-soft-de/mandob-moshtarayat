<?php

namespace App\Request;

class OrderClientCreateRequest
{
    private $storeOwnerProfileID;
   
    private $destination;
   
    private $deliveryDate;
   
    private $note;
   
    private $payment;
   
    private $state;
   
    private $roomID;
   
    private $clientID;
   
    private $products;
   
    private $orderCost;
   
    private $deliveryCost;

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

    public function getState(): ?string
    {
        return $this->state;
    }

    public function setState(?string $state): self
    {
        $this->state = $state;

        return $this;
    }

    public function getRoomID(): ?string
    {
        return $this->roomID;
    }

    public function setRoomID(?string $roomID): self
    {
        $this->roomID = $roomID;

        return $this;
    }

     /**
     * @param mixed $clientID
     */
    public function setClientID($clientID): void
    {
        $this->clientID = $clientID;
    }

     /**
     * @return mixed
     */
    public function getClientID()
    {
        return $this->clientID;
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
 
    public function getOrderCost()
    {
        return $this->orderCost;
    }
 
    public function setOrderCost($orderCost)
    {
        $this->orderCost = $orderCost;

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
