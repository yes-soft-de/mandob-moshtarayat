<?php

namespace App\Response;

class ProductsByProductCategoryIdForStoreResponse
{
    public $id;

    public $productName;

    public $productPrice;

    public $productQuantity;

    public $storeProductCategoryID;

    public $image;

    public $discount;

    public $description;

    public $rate;

    public $soldCount;

    public $status;

    /*
     * For Store (for updating product)
     */
    public $isLevel1;

    public $isLevel2;
}