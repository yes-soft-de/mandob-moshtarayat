<?php

namespace App\Response;

class AcceptedOrderResponse
{
    public $id;
    public $storeOwnerName;
    public $source = [];
    public $destination;
    public $deliveryDate;
    public $note;
    public $payment;
    public $recipientName;
    public $recipientPhone;
    public $state;
    public $orderDetail;
    public $deliveryCost;
    public $orderType;
    public $orderNumber;
}
