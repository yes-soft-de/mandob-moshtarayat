<?php

namespace App\Response;

class OrderDetailProductsForAdminResponse
{
    public $productName;
    public $productImage;
    //price with discount
    public $productPrice;
    //price with discount and commission
    public $productPriceAndCommission;
    public $countProduct;
    public $productCategoryID;
    public $orderNumber;
    public $productID;
}