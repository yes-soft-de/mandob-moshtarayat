<?php

namespace App\Request;

class StoreProductCategoryTranslationCreateRequest
{
    private $storeProductCategoryID;

    private $productCategoryName;
  
    private $description;

    private $language;

    /**
     * @param mixed $storeProductCategoryID
     */
    public function setStoreProductCategoryID($storeProductCategoryID): void
    {
        $this->storeProductCategoryID = $storeProductCategoryID;
    }

    /**
     * @return mixed
     */
    public function getProductCategoryName()
    {
        return $this->productCategoryName;
    }

    /**
     * @param mixed $productCategoryName
     */
    public function setProductCategoryName($productCategoryName): void
    {
        $this->productCategoryName = $productCategoryName;
    }

    /**
     * Get the value of description
     */ 
    public function getDescription()
    {
        return $this->description;
    }

    /**
     * Set the value of description
     *
     * @return  self
     */ 
    public function setDescription($description)
    {
        $this->description = $description;

        return $this;
    }

    /**
     * @param mixed $language
     */
    public function setLanguage($language): void
    {
        $this->language = $language;
    }

}
