<?php

namespace App\Response;

class OrderDetailResponse
{
    public $id;
    public $orderID;
    public $productName;
    public $productImage;
    public $productPrice;
    public $countProduct;
    public $storeOwnerProfileID;
    public $ProductCategoryID;
    public $orderNumber;
    public $productID;
  

    /**
     * Get the value of id
     */ 
    public function getId()
    {
        return $this->id;
    }

    /**
     * Get the value of productID
     */ 
    public function getProductID()
    {
        return $this->productID;
    }

    /**
     * Set the value of productID
     *
     * @return  self
     */ 
    public function setProductID($productID)
    {
        $this->productID = $productID;

        return $this;
    }

    /**
     * Get the value of orderID
     */ 
    public function getOrderID()
    {
        return $this->orderID;
    }
}
