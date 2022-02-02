<?php

namespace App\Request;

class StoreProductCategoriesLevelOneAllGetRequest
{
    private $language;

    /**
     * @return mixed
     */
    public function getLanguage()
    {
        return $this->language;
    }
}
