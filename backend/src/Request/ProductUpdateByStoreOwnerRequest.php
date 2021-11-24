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

    private $productQuantity;

    /**
     * Get the value of id
     */
    public function getId()
    {
        return $this->id;
    }

}
