<?php

namespace App\Entity;

use App\Repository\RepresentativeDueEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

/**
 * @ORM\Entity(repositoryClass=RepresentativeDueEntityRepository::class)
 */
class RepresentativeDueEntity
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=10)
     */
    private $representativeUserID;

    /**
     * @ORM\Column(type="float")
     */
    private $dueAmount;

    /**
     * @Gedmo\Timestampable(on="create")
     * @ORM\Column(type="datetime")
     */
    private $createdAt;

    /**
     * @ORM\Column(type="string", length=10)
     */
    private $storeOwnerUserID;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getRepresentativeUserID(): ?string
    {
        return $this->representativeUserID;
    }

    public function setRepresentativeUserID(string $representativeUserID): self
    {
        $this->representativeUserID = $representativeUserID;

        return $this;
    }

    public function getDueAmount(): ?float
    {
        return $this->dueAmount;
    }

    public function setDueAmount(float $dueAmount): self
    {
        $this->dueAmount = $dueAmount;

        return $this;
    }

    public function getCreatedAt(): ?\DateTimeInterface
    {
        return $this->createdAt;
    }

    public function setCreatedAt(\DateTimeInterface $createdAt): self
    {
        $this->createdAt = $createdAt;

        return $this;
    }

    public function getStoreOwnerUserID(): ?string
    {
        return $this->storeOwnerUserID;
    }

    public function setStoreOwnerUserID(string $storeOwnerUserID): self
    {
        $this->storeOwnerUserID = $storeOwnerUserID;

        return $this;
    }
}
