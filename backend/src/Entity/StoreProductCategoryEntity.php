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
     * @ORM\Column(type="integer")
     */
    private $storeOwnerProfileId;
    
     /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $productCategoryImage;


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

}
