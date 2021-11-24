<?php

namespace App\Request;

class ProductCreateRequest
{
    private $productName;

    private $productImage;

    private $productPrice;

    private $storeOwnerProfileID;

    private $storeProductCategoryID;

    private $discount;

    private $description;

    private $status;

    private $productQuantity;

    /**
     * @return mixed
     */
    public function getStoreOwnerProfileID()
    {
        return $this->storeOwnerProfileID;
    }

    /**
     * @param mixed storeOwnerProfileID
     */
    public function setStoreOwnerProfileID($storeOwnerProfileID): void
    {
        $this->storeOwnerProfileID = $storeOwnerProfileID;
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
