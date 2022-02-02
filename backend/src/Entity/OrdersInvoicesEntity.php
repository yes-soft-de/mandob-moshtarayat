<?php

namespace App\Entity;

use App\Repository\OrdersInvoicesEntityRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=OrdersInvoicesEntityRepository::class)
 */
class OrdersInvoicesEntity
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
    private $invoiceAmount;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $invoiceImage;

    /**
     * @ORM\Column(type="integer", nullable=true)
     */
    private $storeOwnerProfileID;

    /**
     * @ORM\Column(type="integer", nullable=true)
     */
    private $orderNumber;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getInvoiceAmount(): ?float
    {
        return $this->invoiceAmount;
    }

    public function setInvoiceAmount(?float $invoiceAmount): self
    {
        $this->invoiceAmount = $invoiceAmount;

        return $this;
    }

    public function getInvoiceImage(): ?string
    {
        return $this->invoiceImage;
    }

    public function setInvoiceImage(?string $invoiceImage): self
    {
        $this->invoiceImage = $invoiceImage;

        return $this;
    }

    public function getStoreOwnerProfileID(): ?int
    {
        return $this->storeOwnerProfileID;
    }

    public function setStoreOwnerProfileID(?int $storeOwnerProfileID): self
    {
        $this->storeOwnerProfileID = $storeOwnerProfileID;

        return $this;
    }

    public function getOrderNumber(): ?int
    {
        return $this->orderNumber;
    }

    public function setOrderNumber(?int $orderNumber): self
    {
        $this->orderNumber = $orderNumber;

        return $this;
    }
}
