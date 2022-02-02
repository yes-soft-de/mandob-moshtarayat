<?php

namespace App\Entity;

use App\Repository\StoreCategoryTranslationEntityRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=StoreCategoryTranslationEntityRepository::class)
 */
class StoreCategoryTranslationEntity
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
    private $storeCategoryID;

    /**
     * @ORM\Column(type="string", length=10)
     */
    private $language;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $storeCategoryName;

    /**
     * @ORM\Column(type="text", nullable=true)
     */
    private $description;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getStoreCategoryID(): ?int
    {
        return $this->storeCategoryID;
    }

    public function setStoreCategoryID(?int $storeCategoryID): self
    {
        $this->storeCategoryID = $storeCategoryID;

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

    public function getStoreCategoryName(): ?string
    {
        return $this->storeCategoryName;
    }

    public function setStoreCategoryName(string $storeCategoryName): self
    {
        $this->storeCategoryName = $storeCategoryName;

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
}
