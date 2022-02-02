<?php

namespace App\Request;

class FilterStoreProductCategoryLevelOne
{
    private $storeCategoryID;

    private $language;

    /**
     * @return mixed
     */
    public function getStoreCategoryID()
    {
        return $this->storeCategoryID;
    }

    /**
     * @return mixed
     */
    public function getLanguage()
    {
        return $this->language;
    }

}