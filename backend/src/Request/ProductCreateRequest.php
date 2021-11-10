<?php

namespace App\Request;

class ProductCreateRequest
{
    private $productName;

    private $productImage;

    private $productPrice;

    private $storeOwnerProfileID;

    private $storeProductCategoryID;

    private $discount;

    /**
     * @return mixed
     */
    public function getStoreOwnerProfileID()
    {
        return $this->storeOwnerProfileID;
    }

    /**
     * @param mixed storeOwnerProfileID
     */
    public function setStoreOwnerProfileID($storeOwnerProfileID): void
    {
        $this->storeOwnerProfileID = $storeOwnerProfileID;
    }
}
