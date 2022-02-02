<?php

namespace App\Request;

class ProductCancelByStoreOwnerRequest
{
    private $id;

    private $status;

    /**
    /**
     * Get the value of id
     */
    public function getId()
    {
        return $this->id;
    }

    public function getStatus(): ?string
    {
        return $this->status;
    }

    public function setStatus(string $status): self
    {
        $this->status = $status;

        return $this;
    }
}