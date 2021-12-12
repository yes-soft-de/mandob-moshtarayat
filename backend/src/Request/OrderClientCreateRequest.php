<?php

namespace App\Request;

class OrderClientCreateRequest
{
    private $destination;
   
    private $deliveryDate;
   
    private $note;
   
    private $payment;

    //create by backend by special rules
    private $state;
   
    private $roomID;
   
    private $clientID;
   
    private $orderDetails;
   
    private $orderCost;
   
    private $deliveryCost;


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
     * Get the value of orderDetails
     */ 
    public function getOrderDetails()
    {
        return $this->orderDetails;
    }

    /**
     * Set the value of orderDetails
     *
     * @return  self
     */ 
    public function setOrderDetails($orderDetails)
    {
        $this->orderDetails = $orderDetails;

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
