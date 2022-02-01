<?php

namespace App\Request;

class RepresentativeStoreLinkUpdateRequest
{
    private $id;

    private $linkStatus;

    private $storeOwnerUserID;

    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * @param mixed $linkStatus
     */
    public function setLinkStatus($linkStatus): void
    {
        $this->linkStatus = $linkStatus;
    }

    /**
     * @param mixed $storeOwnerUserID
     */
    public function setStoreOwnerUserID($storeOwnerUserID): void
    {
        $this->storeOwnerUserID = $storeOwnerUserID;
    }
}
