<?php

namespace App\Request;

class ProductAvailableAndQuantityAvailableRequest
{
    private $productDetails;

    /**
     * @return mixed
     */
    public function getProductDetails()
    {
        return $this->productDetails;
    }

    /**
     * @param mixed $productDetails
     */
    public function setProductDetails($productDetails): void
    {
        $this->productDetails = $productDetails;
    }

}