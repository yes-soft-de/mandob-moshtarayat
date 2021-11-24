<?php

namespace App\Request;

class StoreProductCategoryLevelTwoUpdateRequest
{
    private $id;

    private $productCategoryName;

    private $productCategoryImage;

    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }
}
