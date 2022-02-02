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
}
