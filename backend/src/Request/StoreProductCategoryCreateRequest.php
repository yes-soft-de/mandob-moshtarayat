<?php

namespace App\Request;

class StoreProductCategoryCreateRequest
{
    private $userID;

    private $productCategoryName;

    private $storeOwnerProfileId;
   
    private $productCategoryImage;

    private $isLevel1;

    private $isLevel2;

    /**
     * @return mixed
     */
    public function getIsLevel1()
    {
        return $this->isLevel1;
    }

    /**
     * @param mixed $isLevel1
     */
    public function setIsLevel1($isLevel1): void
    {
        $this->isLevel1 = $isLevel1;
    }

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
     * Get the value of userID
     */
    public function getUserID()
    {
        return $this->userID;
    }

    /**
     * Set the value of userID
     *
     * @return  self
     */
    public function setUserID($userID)
    {
        $this->userID = $userID;

        return $this;
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
     * Get the value of storeOwnerProfileId
     */ 
    public function getStoreOwnerProfileId()
    {
        return $this->storeOwnerProfileId;
    }

    /**
     * Set the value of storeOwnerProfileId
     *
     * @return  self
     */ 
    public function setStoreOwnerProfileId($storeOwnerProfileId)
    {
        $this->storeOwnerProfileId = $storeOwnerProfileId;

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
