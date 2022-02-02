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

    private $status;

    /**
     * Get the value of id
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * @param mixed $productName
     */
    public function setProductName($productName): void
    {
        $this->productName = $productName;
    }

}
