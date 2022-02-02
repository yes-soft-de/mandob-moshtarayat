<?php

namespace App\Response;

class OrderClientStatusResponse
{
    public $id;
    public $orderID;
    public $productName;
    public $productImage;
    public $productPrice;
    public $countProduct;
    public $storeOwnerProfileID;
    public $ProductCategoryID;
    public $ownerID;
    public $source = [];
    public $destination;
    public $deliveryDate;
    public $updatedAt;
    public $note;
    public $payment;
    public $recipientName;
    public $recipientPhone;
    public $state;
    public $kilometer;
  
}
