<?php

namespace App\Request;

class OrderDetailUpdateByClientRequest
{
    private $id;
    
    private $orderNumber;
    
    private $orderID;
    
    private $productID ;
    
    private $countProduct;
    

    /**
     * Get the value of id
     */ 
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set the value of id
     *
     * @return  self
     */ 
    public function setId($id)
    {
        $this->id = $id;

        return $this;
    }

    /**
     * Get the value of orderNumber
     */ 
    public function getOrderNumber()
    {
        return $this->orderNumber;
    }

    /**
     * Set the value of orderNumber
     *
     * @return  self
     */ 
    public function setOrderNumber($orderNumber)
    {
        $this->orderNumber = $orderNumber;

        return $this;
    }

    /**
     * Get the value of orderID
     */ 
    public function getOrderID()
    {
        return $this->orderID;
    }

    /**
     * Set the value of orderID
     *
     * @return  self
     */ 
    public function setOrderID($orderID)
    {
        $this->orderID = $orderID;

        return $this;
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
     * Get the value of countProduct
     */ 
    public function getCountProduct()
    {
        return $this->countProduct;
    }

    /**
     * Set the value of countProduct
     *
     * @return  self
     */ 
    public function setCountProduct($countProduct)
    {
        $this->countProduct = $countProduct;

        return $this;
    }
}
