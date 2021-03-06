<?php

namespace App\Entity;

use App\Repository\DeliveryCompanyFinancialEntityRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=DeliveryCompanyFinancialEntityRepository::class)
 */
class DeliveryCompanyFinancialEntity
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="float", nullable=true)
     */
    private $deliveryCost;

    /**
     * @ORM\Column(type="float", nullable=true)
     */
    private $representativeCommission;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getDeliveryCost(): ?float
    {
        return $this->deliveryCost;
    }

    public function setDeliveryCost(?float $deliveryCost): self
    {
        $this->deliveryCost = $deliveryCost;

        return $this;
    }

    public function getRepresentativeCommission(): ?float
    {
        return $this->representativeCommission;
    }

    public function setRepresentativeCommission(?float $representativeCommission): self
    {
        $this->representativeCommission = $representativeCommission;

        return $this;
    }
}
