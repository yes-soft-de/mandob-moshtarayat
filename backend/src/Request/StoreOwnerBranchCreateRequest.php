<?php

namespace App\Request;

class StoreOwnerBranchCreateRequest
{
    private $storeOwnerProfileID;
   
    private $location = [];
   
    private $city;
   
    private $branchName;
   
    private $isActive;
      
    /**
    * @param mixed $storeOwnerProfileID
    */
    public function setStoreOwnerProfileID($storeOwnerProfileID): void
    {
        $this->storeOwnerProfileID = $storeOwnerProfileID;
    }

    /**
    * @return mixed
    */
    public function getStoreOwnerProfileID()
    {
        return $this->storeOwnerProfileID;
    }
}
