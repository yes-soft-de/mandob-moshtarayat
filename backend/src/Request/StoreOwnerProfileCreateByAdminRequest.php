<?php

namespace App\Request;

class StoreOwnerProfileCreateByAdminRequest
{
    private $userID;

    private $storeOwnerName;

    private $image;

    private $is_best;
    
    private $city;

    private $roomID;
    
    private $phone;

    private $storeCategoryId;

    private $privateOrders;

    private $hasProducts;

    private $storeOwnerProfileID;

    private $location = [];

    private $branchName;
    
    private $isActive;
    
    private $openingTime;

    private $closingTime;


    /**
     * @return mixed
     */
    public function getUserID()
    {
        return $this->userID;
    }

    public function setUserID($userID): void
    {
        $this->userID = $userID;
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

    public function getRoomID(): ?string
    {
        return $this->roomID;
    }

    public function setRoomID(?string $roomID): self
    {
        $this->roomID = $roomID;

        return $this;
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

    /**
     * Get the value of is_best
     */ 
    public function getIs_best()
    {
        return $this->is_best;
    }

    /**
     * Set the value of is_best
     *
     * @return  self
     */ 
    public function setIs_best($is_best)
    {
        $this->is_best = $is_best;

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

    public function getStoreOwnerProfileID()
    {
        return $this->storeOwnerProfileID;
    }

    public function setStoreOwnerProfileID($storeOwnerProfileID)
    {
        $this->storeOwnerProfileID = $storeOwnerProfileID;

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
 
    public function getIsActive()
    {
        return $this->isActive;
    }
 
    public function setIsActive($isActive)
    {
        $this->isActive = $isActive;

        return $this;
    }
}
