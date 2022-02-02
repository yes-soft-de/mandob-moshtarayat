<?php

namespace App\Entity;

use App\Repository\DeliveryCompanyPaymentsToCaptainEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

// this entity for The money the captain collects from clients 
/**
 * @ORM\Entity(repositoryClass=DeliveryCompanyPaymentsFromCaptainEntityRepository::class)
 */
class DeliveryCompanyPaymentsToCaptainEntity
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
    private $captainId;

    /**
     * @Gedmo\Timestampable(on="create")
     * @ORM\Column(type="datetime", nullable=true)
     */
    private $date;

    /**
     * @ORM\Column(type="float", nullable=true)
     */
    private $amount;
    
    /**
     * @ORM\Column(type="text", nullable=true)
     */
    private $note;


    public function getId(): ?int
    {
        return $this->id;
    }

    public function getCaptainId(): ?string
    {
        return $this->captainId;
    }

    public function setCaptainId(string $captainId): self
    {
        $this->captainId = $captainId;

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

    public function getAmount(): ?float
    {
        return $this->amount;
    }

    public function setAmount(?float $amount): self
    {
        $this->amount = $amount;

        return $this;
    }
    
    public function getNote(): ?string
    {
        return $this->note;
    }

    public function setNote(?string $note): self
    {
        $this->note = $note;

        return $this;
    }
}
