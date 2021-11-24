<?php

namespace App\Request;

class StoreProductCategoryLevelOneUpdateRequest
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