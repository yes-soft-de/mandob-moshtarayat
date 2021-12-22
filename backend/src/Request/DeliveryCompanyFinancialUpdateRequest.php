<?php

namespace App\Request;

class DeliveryCompanyFinancialUpdateRequest
{   
     private $id;
   
     private $deliveryCost;
 
     public function getId()
     {
          return $this->id;
     }
 
     public function setId($id)
     {
          $this->id = $id;

          return $this;
     }
}
