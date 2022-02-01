<?php

namespace App\Request;

class ProductTranslationUpdateRequest
{
    private $productID;

    private $productName;

    private $description;

    private $status;

    private $language;

    /**
     * @return mixed
     */
    public function getProductID()
    {
        return $this->productID;
    }

    /**
     * @return mixed
     */
    public function getLanguage()
    {
        return $this->language;
    }

}