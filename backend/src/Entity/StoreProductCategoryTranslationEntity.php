<?php

namespace App\Entity;

use App\Repository\StoreProductCategoryTranslationEntityRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=StoreProductCategoryTranslationEntityRepository::class)
 */
class StoreProductCategoryTranslationEntity
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="integer")
     */
    private $storeProductCategoryID;

    /**
     * @ORM\Column(type="string", length=100)
     */
    private $productCategoryName;

    /**
     * @ORM\Column(type="string", length=20)
     */
    private $language;

    public function getId(): ?int
    {
        return $this->id;
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

    public function getProductCategoryName(): ?string
    {
        return $this->productCategoryName;
    }

    public function setProductCategoryName(string $productCategoryName): self
    {
        $this->productCategoryName = $productCategoryName;

        return $this;
    }

    public function getLanguage(): ?string
    {
        return $this->language;
    }

    public function setLanguage(string $language): self
    {
        $this->language = $language;

        return $this;
    }
}
