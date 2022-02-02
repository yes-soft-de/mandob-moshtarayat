<?php

namespace App\Request;

class StoreOwnerUpdateByAdminRequest
{
    private $id;

    private $storeOwnerName;

    private $status;

    private $is_best;

    private $image;

    private $storeCategoryId;

    private $privateOrders;

    private $hasProducts;
      
    private $openingTime;

    private $closingTime;
    
    /**
     * Get the value of id
     */ 
    public function getId()
    {
        return $this->id;
    }

    public function getOpeningTime()
    {
        return $this->openingTime;
    }

    public function setOpeningTime($openingTime)
    {
        $this->openingTime = $openingTime;

        return $this;
    }

    public function getClosingTime()
    {
        return $this->closingTime;
    }

    public function setClosingTime($closingTime)
    {
        $this->closingTime = $closingTime;

        return $this;
    }
}
