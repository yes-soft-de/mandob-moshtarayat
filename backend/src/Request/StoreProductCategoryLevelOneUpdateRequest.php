<?php

namespace App\Request;

class StoreProductCategoryLevelOneUpdateRequest
{
    private $id;

    private $productCategoryName;

    private $productCategoryImage;

    private $storeCategoryID;

    private $isLevel1;

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
    public function getId()
    {
        return $this->id;
    }

}