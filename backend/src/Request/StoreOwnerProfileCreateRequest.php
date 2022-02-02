<?php

namespace App\Request;

class StoreOwnerProfileCreateRequest
{
    private $storeOwnerID;

    private $storeOwnerName;

    private $image;

    private $is_best;
    
    private $city;

    private $roomID;
    
    private $phone;

    private $storeCategoryId;

    private $privateOrders;

    private $hasProducts;

    /**
     * @return mixed
     */
    public function getStoreOwnerID()
    {
        return $this->storeOwnerID;
    }

    /**
     * @param mixed $storeOwnerID
     */
    public function setStoreOwnerID($storeOwnerID): void
    {
        $this->storeOwnerID = $storeOwnerID;
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
}
