<?php

namespace App\Request;

class RepresentativeStoreLinkCreateRequest
{
    private $storeOwnerIP;

    private $representativeUserID;

    /**
     * @return mixed
     */
    public function getStoreOwnerIP()
    {
        return $this->storeOwnerIP;
    }

    /**
     * @return mixed
     */
    public function getRepresentativeUserID()
    {
        return $this->representativeUserID;
    }

    public function setStoreOwnerIP($storeOwnerIP): void
    {
        $this->storeOwnerIP = $storeOwnerIP;
    }
}
