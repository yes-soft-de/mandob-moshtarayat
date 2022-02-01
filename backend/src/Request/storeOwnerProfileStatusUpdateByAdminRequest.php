<?php

namespace App\Request;

class storeOwnerProfileStatusUpdateByAdminRequest
{
    private $id;

    private $status;

    private $commission;


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

    public function getCommission()
    {
        return $this->commission;
    }

    public function setCommission($commission)
    {
        $this->commission = $commission;

        return $this;
    }
}