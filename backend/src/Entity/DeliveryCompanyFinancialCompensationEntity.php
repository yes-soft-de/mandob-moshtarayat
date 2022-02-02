<?php

namespace App\Entity;

use App\Repository\DeliveryCompanyFinancialCompensationEntityRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=DeliveryCompanyFinancialCompensationEntityRepository::class)
 */
class DeliveryCompanyFinancialCompensationEntity
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
    private $kilometers;

    /**
     * @ORM\Column(type="float", nullable=true)
     */
    private $maxKilometerBonus;

    /**
     * @ORM\Column(type="float", nullable=true)
     */
    private $minKilometerBonus;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getKilometers(): ?float
    {
        return $this->kilometers;
    }

    public function setKilometers(?float $kilometers): self
    {
        $this->kilometers = $kilometers;

        return $this;
    }

    public function getMaxKilometerBonus(): ?float
    {
        return $this->maxKilometerBonus;
    }

    public function setMaxKilometerBonus(float $maxKilometerBonus): self
    {
        $this->maxKilometerBonus = $maxKilometerBonus;

        return $this;
    }

    public function getMinKilometerBonus(): ?float
    {
        return $this->minKilometerBonus;
    }

    public function setMinKilometerBonus(?float $minKilometerBonus): self
    {
        $this->minKilometerBonus = $minKilometerBonus;

        return $this;
    }
}
