<?php

namespace App\Request;

class RepresentativeStoreLinkCreateRequest
{
    private $storeOwnerIP;

    private $representativeUserID;

    public function setStoreOwnerIP($storeOwnerIP): void
    {
        $this->storeOwnerIP = $storeOwnerIP;
    }
}
