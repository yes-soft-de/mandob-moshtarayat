<?php

namespace App\Request;

class ProductCommissionByAdminUpdateRequest
{
    private $id;
  
    private $commission;

    private $isCommission;

    /**
     * Get the value of id
     */ 
    public function getId()
    {
        return $this->id;
    }
}
