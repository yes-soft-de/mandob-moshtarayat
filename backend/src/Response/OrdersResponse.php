<?php

namespace App\Response;

class OrdersResponse
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
    public $acceptedOrder;
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
