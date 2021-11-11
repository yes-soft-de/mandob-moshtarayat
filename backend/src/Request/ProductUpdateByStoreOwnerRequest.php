<?php

namespace App\Request;

class ProductUpdateByStoreOwnerRequest
{
    private $id;

    private $productName;

    private $productImage;

    private $productPrice;

    private $storeProductCategoryID;

    private $discount;

    private $description;

    /**
     * Get the value of ProductCategoryID
     */
    public function getProductCategoryID()
    {
        return $this->ProductCategoryID;
    }

    /**
     * Set the value of ProductCategoryID
     *
     * @return  self
     */
    public function setProductCategoryID($ProductCategoryID)
    {
        $this->ProductCategoryID = $ProductCategoryID;

        return $this;
    }

    /**
     * Get the value of id
     */
    public function getId()
    {
        return $this->id;
    }
}
