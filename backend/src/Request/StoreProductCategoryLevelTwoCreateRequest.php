<?php

namespace App\Request;

class StoreProductCategoryLevelTwoCreateRequest
{
    private $productCategoryName;

    private $productCategoryImage;

    private $isLevel2;

    private $storeProductCategoryID;

    /**
     * @return mixed
     */
    public function getIsLevel2()
    {
        return $this->isLevel2;
    }

    /**
     * @param mixed $isLevel2
     */
    public function setIsLevel2($isLevel2): void
    {
        $this->isLevel2 = $isLevel2;
    }

    /**
     * Get the value of ProductCategoryName
     */
    public function getProductCategoryName()
    {
        return $this->productCategoryName;
    }

    /**
     * Set the value of ProductCategoryName
     *
     * @return  self
     */
    public function setProductCategoryName($productCategoryName)
    {
        $this->productCategoryName = $productCategoryName;

        return $this;
    }

    /**
     * Get the value of storeProductCategoryID
     */
    public function getStoreProductCategoryID()
    {
        return $this->storeProductCategoryID;
    }

    /**
     * Set the value of storeProductCategoryID
     *
     * @return  self
     */
    public function setStoreProductCategoryID($storeProductCategoryID)
    {
        $this->storeProductCategoryID = $storeProductCategoryID;

        return $this;
    }

    /**
     * Get the value of ProductCategoryImage
     */
    public function getProductCategoryImage()
    {
        return $this->productCategoryImage;
    }

    /**
     * Set the value of ProductCategoryImage
     *
     * @return  self
     */
    public function setProductCategoryImage($productCategoryImage)
    {
        $this->productCategoryImage = $productCategoryImage;

        return $this;
    }
}
