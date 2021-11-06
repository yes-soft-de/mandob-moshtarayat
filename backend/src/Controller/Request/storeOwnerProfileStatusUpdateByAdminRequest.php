<?php

namespace App\Controller\Request;

class storeOwnerProfileStatusUpdateByAdminRequest
{
    private $id;

    private $status;


    /**
     * Get the value of id
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Get the value of status
     */
    public function getStatus(): ?string
    {
        return $this->status;
    }

    /**
     * Set the value of status
     *
     * @return  self
     */
    public function setStatus(string $status): self
    {
        $this->status = $status;

        return $this;
    }
}