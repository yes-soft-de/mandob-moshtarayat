<?php

namespace App\Request;

class UpdateProductQuantityRequest
{
    private $productID;

    private $productQuantity;


    /**
     * @param mixed $productID
     */
    public function setProductID($productID): void
    {
        $this->productID = $productID;
    }

    /**
     * @return mixed
     */
    public function getProductID()
    {
        return $this->productID;
    }

    /**
     * @return mixed
     */
    public function getProductQuantity()
    {
        return $this->productQuantity;
    }

    /**
     * @param mixed $productQuantity
     */
    public function setProductQuantity($productQuantity): void
    {
        $this->productQuantity = $productQuantity;
    }

}