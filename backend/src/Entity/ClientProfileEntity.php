<?php

namespace App\Entity;

use App\Repository\ClientProfileEntityRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=ClientProfileEntityRepository::class)
 */
class ClientProfileEntity
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $clientID;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $clientName;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $image;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $phone;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $roomID;

     /**
     * @ORM\Column(type="json", nullable=true)
     */
    private $location = [];

    /**
     * @ORM\Column(type="array", nullable=true)
     */
    private $favouriteCategories = [];

    /**
     * @ORM\Column(type="string", length=20, nullable=true)
     */
    private $preferredLanguage;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $needSupport;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $nationalAddress;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $recordNumber;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $taxNumber;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $qrCode;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getClientID(): ?string
    {
        return $this->clientID;
    }

    public function setClientID(string $clientID): self
    {
        $this->clientID = $clientID;

        return $this;
    }

    public function getClientName(): ?string
    {
        return $this->clientName;
    }

    public function setClientName(string $clientName): self
    {
        $this->clientName = $clientName;

        return $this;
    }

    public function getImage(): ?string
    {
        return $this->image;
    }

    public function setImage(?string $image): self
    {
        $this->image = $image;

        return $this;
    }

    public function getRoomID(): ?string
    {
        return $this->roomID;
    }

    public function setRoomID(?string $roomID): self
    {
        $this->roomID = $roomID;

        return $this;
    }
    
    public function getPhone(): ?string
    {
        return $this->phone;
    }

    public function setPhone(?string $phone): self
    {
        $this->phone = $phone;

        return $this;
    }

    public function getLocation(): ?array
    {
        return $this->location;
    }

    public function setLocation(array $location): self
    {
        $this->location = $location;

        return $this;
    }

    public function getFavouriteCategories(): ?array
    {
        return $this->favouriteCategories;
    }

    public function setFavouriteCategories(?array $favouriteCategories): self
    {
        $this->favouriteCategories = $favouriteCategories;

        return $this;
    }

    public function getPreferredLanguage(): ?string
    {
        return $this->preferredLanguage;
    }

    public function setPreferredLanguage(?string $preferredLanguage): self
    {
        $this->preferredLanguage = $preferredLanguage;

        return $this;
    }

    public function getNeedSupport(): ?bool
    {
        return $this->needSupport;
    }

    public function setNeedSupport(?bool $needSupport): self
    {
        $this->needSupport = $needSupport;

        return $this;
    }

    public function getNationalAddress(): ?string
    {
        return $this->nationalAddress;
    }

    public function setNationalAddress(string $nationalAddress): self
    {
        $this->nationalAddress = $nationalAddress;

        return $this;
    }

    public function getRecordNumber(): ?string
    {
        return $this->recordNumber;
    }

    public function setRecordNumber(string $recordNumber): self
    {
        $this->recordNumber = $recordNumber;

        return $this;
    }

    public function getTaxNumber(): ?string
    {
        return $this->taxNumber;
    }

    public function setTaxNumber(string $taxNumber): self
    {
        $this->taxNumber = $taxNumber;

        return $this;
    }

    public function getQrCode(): ?string
    {
        return $this->qrCode;
    }

    public function setQrCode(?string $qrCode): self
    {
        $this->qrCode = $qrCode;

        return $this;
    }
}
