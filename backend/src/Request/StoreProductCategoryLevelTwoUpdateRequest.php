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

    /**
     * @param mixed $productCategoryName
     */
    public function setProductCategoryName($productCategoryName): void
    {
        $this->productCategoryName = $productCategoryName;
    }

}
