<?php

namespace App\Request;

class OrderClientSpecialCreateRequest
{
    
    private $storeOwnerProfileID;
   
    private $destination;
   
    private $deliveryDate;
   
    private $note;
   
    private $payment;
   
    private $state;
   
    private $roomID;
   
    private $clientID;
   
    private $detail;

     /**
     * @param mixed $ownerID
     */
    public function setOwnerID($ownerID): void
    {
        $this->ownerID = $ownerID;
    }

     /**
     * @return mixed
     */
    public function getOwnerID()
    {
        return $this->ownerID;
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

    public function getStoreOwnerProfileID()
    {
        return $this->storeOwnerProfileID;
    }
 
    public function setStoreOwnerProfileID($storeOwnerProfileID)
    {
        $this->storeOwnerProfileID = $storeOwnerProfileID;

        return $this;
    }
}
