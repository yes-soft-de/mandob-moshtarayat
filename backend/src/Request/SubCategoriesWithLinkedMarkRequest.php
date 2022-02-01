<?php

namespace App\Request;

class SubCategoriesWithLinkedMarkRequest
{
    private $language;

    private $storeProductCategoryLevelTwoID;

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
    public function getStoreProductCategoryLevelTwoID()
    {
        return $this->storeProductCategoryLevelTwoID;
    }

}