<?php

namespace App\Request;

class FilterStoreProductCategoryLevelTwo
{
    private $storeProductCategoryID;

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
    public function getLanguage()
    {
        return $this->language;
    }

}