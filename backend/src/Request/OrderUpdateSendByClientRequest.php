<?php

namespace App\Request;

class OrderUpdateSendByClientRequest
{
    private $orderNumber;
   
    private $source;
   
    private $destination;
   
    private $deliveryDate;
   
    private $note;
   
    private $payment;
   
    private $recipientName;
   
    private $recipientPhone;
   
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
    
    public function getSource()
    {
        return $this->source;
    }
 
    public function setSource($source)
    {
        $this->source = $source;

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

    public function setNote($note)
    {
        $this->note = $note;

        return $this;
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

    public function getRecipientName()
    {
        return $this->recipientName;
    }

    public function setRecipientName($recipientName)
    {
        $this->recipientName = $recipientName;

        return $this;
    }
 
    public function getRecipientPhone()
    {
        return $this->recipientPhone;
    }
 
    public function setRecipientPhone($recipientPhone)
    {
        $this->recipientPhone = $recipientPhone;

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
