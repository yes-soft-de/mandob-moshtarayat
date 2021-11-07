<?php

namespace App\Entity;

use App\Repository\StoreProductCategoryEntityRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=StoreProductCategoryEntityRepository::class)
 */
class StoreProductCategoryEntity
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
    private $productCategoryName;

    /**
     * @ORM\Column(type="integer", nullable=true)
     */
    private $storeOwnerProfileId;
    
     /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $productCategoryImage;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $isLevel1;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $isLevel2;

    /**
     * @ORM\Column(type="integer", length=100, nullable=true)
     */
    private $storeCategoryID;

    /**
     * @ORM\Column(type="integer", length=100, nullable=true)
     */
    private $storeProductCategoryID;

    public function getId(): ?int
    {
        return $this->id;
    }
    
    public function getProductCategoryName(): ?string
    {
        return $this->productCategoryName;
    }

    public function setProductCategoryName(?string $productCategoryName): self
    {
        $this->productCategoryName = $productCategoryName;

        return $this;
    }

    public function getStoreOwnerProfileId(): ?int
    {
        return $this->storeOwnerProfileId;
    }

    public function setStoreOwnerProfileId(int $storeOwnerProfileId): self
    {
        $this->storeOwnerProfileId = $storeOwnerProfileId;

        return $this;
    }

    public function getProductCategoryImage(): ?string
    {
        return $this->productCategoryImage;
    }

    public function setProductCategoryImage(?string $productCategoryImage): self
    {
        $this->productCategoryImage = $productCategoryImage;

        return $this;
    }

    public function getIsLevel1(): ?bool
    {
        return $this->isLevel1;
    }

    public function setIsLevel1(int $isLevel1): self
    {
        $this->isLevel1 = $isLevel1;

        return $this;
    }

    public function getIsLevel2(): ?bool
    {
        return $this->isLevel2;
    }
    public function setIsLevel2(?bool $isLevel2): self
    {
        $this->isLevel2 = $isLevel2;

        return $this;
    }

    public function getStoreCategoryID(): ?int
    {
        return $this->storeCategoryID;
    }

    public function setStoreCategoryID(int $storeCategoryID): self
    {
        $this->storeCategoryID = $storeCategoryID;

        return $this;
    }

    public function getStoreProductCategoryID(): ?int
    {
        return $this->storeProductCategoryID;
    }

    public function setStoreProductCategoryID(int $storeProductCategoryID): self
    {
        $this->storeProductCategoryID = $storeProductCategoryID;

        return $this;
    }
}
