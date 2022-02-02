<?php

namespace App\Response;

class OrderResponse
{
    public $id;
    public $ownerID;
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
    public $location;
    public $branchName;
    public $branchCity;
    public $acceptedOrder;
    public $log;
    public $completionTime;
    public $roomID;
    public $countOrdersInMonth;
    public $countOrdersInDay;
    public $owner;
    public $image;
    public $imageURL;
    public $baseURL;
    public $kilometer;
    public $rating;
    public $currentStage;
    public $createdAt;
    public $productID;
    public $product;
}
