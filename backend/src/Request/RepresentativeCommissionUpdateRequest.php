<?php

namespace App\Request;

class RepresentativeCommissionUpdateRequest
{   
    private $id;
   
    private $representativeCommission;
 
    public function getId()
    {
        return $this->id;
    }
 
    // public function setId($id)
    // {
    //     $this->id = $id;

    //     return $this;
    // }
}
