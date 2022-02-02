<?php

namespace App\Request;

class StoreCategoriesWithLinkedMarkRequest
{
    private $language;

    private $storeProductCategoryLevelOneID;

    /**
     * @return mixed
     */
    public function getLanguage()
    {
        return $this->language;
    }

    /**
     * @return mixed
     */
    public function getStoreProductCategoryLevelOneID()
    {
        return $this->storeProductCategoryLevelOneID;
    }

}