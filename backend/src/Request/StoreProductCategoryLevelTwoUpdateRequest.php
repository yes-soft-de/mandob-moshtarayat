<?php

namespace App\Request;

class StoreProductCategoryLevelTwoUpdateRequest
{
    private $id;

    private $productCategoryName;

    private $productCategoryImage;

    private $storeProductCategoryID;

    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }
}
