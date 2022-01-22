<?php

namespace App\Entity;

use App\Repository\DeliveryCompanyPaymentsToRepresentativeEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

/**
 * @ORM\Entity(repositoryClass=DeliveryCompanyPaymentsToRepresentativeEntityRepository::class)
 */
class DeliveryCompanyPaymentsToRepresentativeEntity
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
    private $representativeID;

    /**
     * @Gedmo\Timestampable(on="create")
     * @ORM\Column(type="datetime")
     */
    private $date;

    /**
     * @ORM\Column(type="float")
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

    public function getRepresentativeID(): ?string
    {
        return $this->representativeID;
    }

    public function setRepresentativeID(string $representativeID): self
    {
        $this->representativeID = $representativeID;

        return $this;
    }

    public function getDate(): ?\DateTimeInterface
    {
        return $this->date;
    }

    public function setDate(\DateTimeInterface $date): self
    {
        $this->date = $date;

        return $this;
    }

    public function getAmount(): ?float
    {
        return $this->amount;
    }

    public function setAmount(float $amount): self
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
