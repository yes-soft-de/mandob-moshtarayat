<?php

namespace App\Response;

class ProductsByStoreOwnerProfileIdResponse
{
    public $id;

    public $productName;

    public $productPrice;

    public $productQuantity;

    public $storeOwnerProfileID;

    public $storeProductCategoryID;

    public $image;

    public $discount;

    public $description;

    public $rate;

    public $soldCount;

    public $status;

    public $store;

    /*
     * product commission - used for dashboard
     */
    public $commission;
}