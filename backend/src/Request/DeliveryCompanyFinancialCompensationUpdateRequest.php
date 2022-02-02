<?php

namespace App\Request;

class DeliveryCompanyFinancialCompensationUpdateRequest
{
    private $id;
   
    private $kilometers;
   
    private $maxKilometerBonus;
   
    private $minKilometerBonus;

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
