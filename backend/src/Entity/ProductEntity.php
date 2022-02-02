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
}
