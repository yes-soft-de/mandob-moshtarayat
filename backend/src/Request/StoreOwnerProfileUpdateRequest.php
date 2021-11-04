<?php

namespace App\Request;

class StoreOwnerProfileUpdateRequest
{
    private $userID;

    private $storeOwnerName;

    private $image;

    private $phone;

    private $storeCategoryId;

    private $privateOrders;

    private $hasProducts;

    private $openingTime;

    private $closingTime;

    private $location = [];

    private $branchName;

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
     * @return mixed
     */
    public function getStoreOwnerName()
    {
        return $this->storeOwnerName;
    }

    /**
     * @param mixed $storeOwnerName
     */
    public function setStoreOwnerName($storeOwnerName): void
    {
        $this->storeOwnerName = $storeOwnerName;
    }

    /**
     * @return mixed
     */
    public function getImage()
    {
        return $this->image;
    }

    /**
     * @param mixed $image
     */
    public function setImage($image): void
    {
        $this->image = $image;
    }


    /**
     * Get the value of storeCategoryId
     */
    public function getStoreCategoryId()
    {
        return $this->storeCategoryId;
    }

    /**
     * Set the value of storeCategoryId
     *
     * @return  self
     */
    public function setStoreCategoryId($storeCategoryId)
    {
        $this->storeCategoryId = $storeCategoryId;

        return $this;
    }

    public function getPrivateOrders()
    {
        return $this->privateOrders;
    }

    public function setPrivateOrders($privateOrders)
    {
        $this->privateOrders = $privateOrders;

        return $this;
    }

    public function getHasProducts()
    {
        return $this->hasProducts;
    }

    public function setHasProducts($hasProducts)
    {
        $this->hasProducts = $hasProducts;

        return $this;
    }

    public function getLocation()
    {
        return $this->location;
    }

    public function setLocation($location)
    {
        $this->location = $location;

        return $this;
    }

    public function getBranchName()
    {
        return $this->branchName;
    }

    public function setBranchName($branchName)
    {
        $this->branchName = $branchName;

        return $this;
    }

}
