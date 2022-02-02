<?php

namespace App\Request;

class DeliveryCompanyFinancialRequest
{  
      private $deliveryCost;

      /**
       * Get the value of deliveryCost
       */ 
      public function getDeliveryCost()
      {
            return $this->deliveryCost;
      }

      /**
       * Set the value of deliveryCost
       *
       * @return  self
       */ 
      public function setDeliveryCost($deliveryCost)
      {
            $this->deliveryCost = $deliveryCost;

            return $this;
      }
}
