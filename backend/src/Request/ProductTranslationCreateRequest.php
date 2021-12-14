<?php

namespace App\Request;

class ProductTranslationCreateRequest
{
    private $productID;

    private $productName;

    private $description;

    private $status;

    private $language;

    /**
     * @param mixed $productID
     */
    public function setProductID($productID): void
    {
        $this->productID = $productID;
    }

}