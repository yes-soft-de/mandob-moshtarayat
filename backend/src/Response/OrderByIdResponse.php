<?php

namespace App\Response;

class OrderByIdResponse
{
    public $id;
    public $ownerID;//remove in future
    public $storeOwnerName;
    public $source = [];
    public $destination;
    public $deliveryDate;
    public $updatedAt;
    public $note;
    public $payment;
    public $recipientName;
    public $recipientPhone;
    public $state;
    public $branchId;
    public $acceptedOrder;
    public $log;
    public $roomID;
    public $kilometer;
    public $rating;
    public $createdAt;
}
