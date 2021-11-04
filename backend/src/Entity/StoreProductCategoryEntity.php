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

    public function isLevel1(): ?bool
    {
        return $this->isLevel1;
    }

    public function isLevel2(?bool $isLevel2): self
    {
        $this->isLevel2 = $isLevel2;

        return $this;
    }
}
