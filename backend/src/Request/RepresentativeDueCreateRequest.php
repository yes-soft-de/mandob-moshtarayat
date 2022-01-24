<?php

namespace App\Request;

class RepresentativeDueCreateRequest
{
    private $representativeUserID;

    private $dueAmount;

    private $storeOwnerUserID;

    public function setRepresentativeUserID($representativeUserID)
    {
        $this->representativeUserID = $representativeUserID;
    }

    public function setStoreOwnerUserID($storeOwnerUserID)
    {
        $this->storeOwnerUserID = $storeOwnerUserID;
    }
}
