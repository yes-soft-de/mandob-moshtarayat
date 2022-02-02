<?php

namespace App\Response;

class ProductsByProductCategoryIdResponse
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

    public $productPriceWithOutCommission;

    public $costDetails;

    /*
     * product commission - used for dashboard
     */
    public $commission;

    /*
     * For Store (for updating product)
     */
    public $isLevel1;

    public $isLevel2;

    public $isCommission;

    public $categoryLink;
}
