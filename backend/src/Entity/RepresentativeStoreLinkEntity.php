<?php

namespace App\Entity;

use App\Repository\RepresentativeStoreLinkEntityRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=RepresentativeStoreLinkEntityRepository::class)
 */
class RepresentativeStoreLinkEntity
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=50)
     */
    private $storeOwnerIP;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $representativeUserID;

    /**
     * @ORM\Column(type="string", length=10)
     */
    private $linkStatus;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $storeOwnerUserID;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getStoreOwnerIP(): ?string
    {
        return $this->storeOwnerIP;
    }

    public function setStoreOwnerIP(string $storeOwnerIP): self
    {
        $this->storeOwnerIP = $storeOwnerIP;

        return $this;
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

    public function getLinkStatus(): ?string
    {
        return $this->linkStatus;
    }

    public function setLinkStatus(string $linkStatus): self
    {
        $this->linkStatus = $linkStatus;

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
