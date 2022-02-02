<?php

namespace App\Entity;

use App\Repository\ClientPaymentEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

/**
 * @ORM\Entity(repositoryClass=ClientPaymentEntityRepository::class)
 */
class ClientPaymentEntity
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
    private $captainID;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $clientID;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $orderID;

    /**
     * @ORM\Column(type="datetime", nullable=true)
     * @Gedmo\Timestampable(on="create")
     */
    private $date;

    /**
     * @ORM\Column(type="integer", nullable=true)
     */
    private $amount;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getCaptainID(): ?string
    {
        return $this->captainID;
    }

    public function setCaptainID(?string $captainID): self
    {
        $this->captainID = $captainID;

        return $this;
    }

    public function getClientID(): ?string
    {
        return $this->clientID;
    }

    public function setClientID(?string $clientID): self
    {
        $this->clientID = $clientID;

        return $this;
    }

    public function getOrderID(): ?string
    {
        return $this->orderID;
    }

    public function setOrderID(?string $orderID): self
    {
        $this->orderID = $orderID;

        return $this;
    }

    public function getDate(): ?\DateTimeInterface
    {
        return $this->date;
    }

    public function setDate(?\DateTimeInterface $date): self
    {
        $this->date = $date;

        return $this;
    }

    public function getAmount(): ?int
    {
        return $this->amount;
    }

    public function setAmount(?int $amount): self
    {
        $this->amount = $amount;

        return $this;
    }
}
