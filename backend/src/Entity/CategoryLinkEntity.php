<?php

namespace App\Entity;

use App\Repository\CategoryLinkEntityRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=CategoryLinkEntityRepository::class)
 */
class CategoryLinkEntity
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=20)
     */
    private $linkType;

    /**
     * @ORM\Column(type="integer", nullable=true)
     */
    private $mainCategoryID;

    /**
     * @ORM\Column(type="integer", nullable=true)
     */
    private $subCategoryLevelOneID;

    /**
     * @ORM\Column(type="integer", nullable=true)
     */
    private $subCategoryLevelTwoID;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getLinkType(): ?string
    {
        return $this->linkType;
    }

    public function setLinkType(string $linkType): self
    {
        $this->linkType = $linkType;

        return $this;
    }

    public function getMainCategoryID(): ?int
    {
        return $this->mainCategoryID;
    }

    public function setMainCategoryID(?int $mainCategoryID): self
    {
        $this->mainCategoryID = $mainCategoryID;

        return $this;
    }

    public function getSubCategoryLevelOneID(): ?int
    {
        return $this->subCategoryLevelOneID;
    }

    public function setSubCategoryLevelOneID(?int $subCategoryLevelOneID): self
    {
        $this->subCategoryLevelOneID = $subCategoryLevelOneID;

        return $this;
    }

    public function getSubCategoryLevelTwoID(): ?int
    {
        return $this->subCategoryLevelTwoID;
    }

    public function setSubCategoryLevelTwoID(?int $subCategoryLevelTwoID): self
    {
        $this->subCategoryLevelTwoID = $subCategoryLevelTwoID;

        return $this;
    }
}
