<?php

namespace App\Request;

class StoreProductCategoryTranslationUpdateRequest
{
    private $storeProductCategoryID;

    private $productCategoryName;

    private $description;

    private $language;

    /**
     * @return mixed
     */
    public function getStoreProductCategoryID()
    {
        return $this->storeProductCategoryID;
    }

    /**
     * @return mixed
     */
    public function getProductCategoryName()
    {
        return $this->productCategoryName;
    }

    /**
     * Get the value of description
     */
    public function getDescription()
    {
        return $this->description;
    }

    /**
     * @return mixed
     */
    public function getLanguage()
    {
        return $this->language;
    }

}