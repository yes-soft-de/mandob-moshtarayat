<?php

namespace App\Entity;

use App\Repository\ProductEntityRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=ProductEntityRepository::class)
 */
class ProductEntity
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $productName;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $productImage;

    /**
     * @ORM\Column(type="float", nullable=true)
     */
    private $productPrice;

    /**
     * @ORM\Column(type="integer", nullable=true)
     */
    private $storeOwnerProfileID;

    /**
     * @ORM\Column(type="integer", nullable=true)
     */
    private $storeProductCategoryID;

    /**
     * @ORM\Column(type="integer", nullable=true)
     */
    private $discount;

    /**
     * @ORM\Column(type="text", nullable=true)
     */
    private $description;

    /**
     * @ORM\Column(type="string", length=100)
     */
    private $status;

    /**
     * @ORM\Column(type="integer", nullable=true)
     */
    private $productQuantity;

    /**
     * @ORM\Column(type="string", length=10, nullable=true)
     */
    private $language;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $isCommission;

    /**
     * @ORM\Column(type="float", nullable=true)
     */
    private $commission;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $isDeleted;


    public function getId(): ?int
    {
        return $this->id;
    }

    public function getProductName(): ?string
    {
        return $this->productName;
    }

    public function setProductName(?string $productName): self
    {
        $this->productName = $productName;

        return $this;
    }

    public function getProductImage(): ?string
    {
        return $this->productImage;
    }

    public function setProductImage(?string $productImage): self
    {
        $this->productImage = $productImage;

        return $this;
    }

    public function getProductPrice(): ?float
    {
        return $this->productPrice;
    }

    public function setProductPrice(?float $productPrice): self
    {
        $this->productPrice = $productPrice;

        return $this;
    }

    public function getStoreOwnerProfileID(): ?int
    {
        return $this->storeOwnerProfileID;
    }

    public function setStoreOwnerProfileID(?int $storeOwnerProfileID): self
    {
        $this->storeOwnerProfileID = $storeOwnerProfileID;

        return $this;
    }

    public function getStoreProductCategoryID(): ?int
    {
        return $this->storeProductCategoryID;
    }

    public function setStoreProductCategoryID(?int $storeProductCategoryID): self
    {
        $this->storeProductCategoryID = $storeProductCategoryID;

        return $this;
    }

    public function getDiscount(): ?int
    {
        return $this->discount;
    }

    public function setDiscount(?int $discount): self
    {
        $this->discount = $discount;

        return $this;
    }

    public function getDescription(): ?string
    {
        return $this->description;
    }

    public function setDescription(?string $description): self
    {
        $this->description = $description;

        return $this;
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

    public function getProductQuantity(): ?int
    {
        return $this->productQuantity;
    }

    public function setProductQuantity(?int $productQuantity): self
    {
        $this->productQuantity = $productQuantity;

        return $this;
    }

    public function getLanguage(): ?string
    {
        return $this->language;
    }

    public function setLanguage(?string $language): self
    {
        $this->language = $language;

        return $this;
    }

    public function getIsCommission(): ?bool
    {
        return $this->isCommission;
    }

    public function setIsCommission(?bool $isCommission): self
    {
        $this->isCommission = $isCommission;

        return $this;
    }

    public function getCommission(): ?float
    {
        return $this->commission;
    }

    public function setCommission(?float $commission): self
    {
        $this->commission = $commission;

        return $this;
    }

    public function getIsDeleted(): ?bool
    {
        return $this->isDeleted;
    }

    public function setIsDeleted(?bool $isDeleted): self
    {
        $this->isDeleted = $isDeleted;

        return $this;
    }
}
