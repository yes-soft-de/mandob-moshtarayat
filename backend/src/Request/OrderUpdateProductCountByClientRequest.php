<?php

namespace App\Request;

class OrderUpdateProductCountByClientRequest
{
    private $orderNumber;
    
    private $productID;

    private $countProduct;

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
     * Get the value of $productId
     */ 
    public function getProductId()
    {
        return $this->productID;
    }

    /**
     * Set the value of $productId
     *
     * @return  self
     */ 
    public function setProductId($productID)
    {
        $this->productID = $productID;

        return $this;
    }

    /**
     * Get the value of $countProduct
     */
    public function getCountProduct()
    {
        return $this->countProduct;
    }

    /**
     * Set the value of $countProduct
     *
     * @return  self
     */
    public function setCountProduct($countProduct)
    {
        $this->countProduct = $countProduct;

        return $this;
    }
}
