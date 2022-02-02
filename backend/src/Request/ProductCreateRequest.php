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

    private $commission;

    private $isCommission;

    private $isDeleted;

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

    public function getCommission()
    {
        return $this->commission;
    }

    public function setCommission($commission)
    {
        $this->commission = $commission;

        return $this;
    }

    public function getIsCommission()
    {
        return $this->isCommission;
    }

    public function setIsCommission($isCommission)
    {
        $this->isCommission = $isCommission;

        return $this;
    }

    /**
     * @return mixed
     */
    public function getIsDeleted()
    {
        return $this->isDeleted;
    }

    /**
     * @param mixed $isDeleted
     */
    public function setIsDeleted($isDeleted): void
    {
        $this->isDeleted = $isDeleted;
    }

}
