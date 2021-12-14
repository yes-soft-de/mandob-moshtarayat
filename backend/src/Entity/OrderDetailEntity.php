<?php

namespace App\Entity;

use App\Repository\OrderDetailEntityRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=OrderDetailEntityRepository::class)
 */
class OrderDetailEntity
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
    private $orderNumber;

    /**
     * @ORM\Column(type="integer", nullable=true)
     */
    private $orderID;

    /**
     * @ORM\Column(type="integer", length=255, nullable=true)
     */
    private $productID;

    /**
     * @ORM\Column(type="integer", length=255, nullable=true)
     */
    private $countProduct;

    /**
     * @ORM\Column(type="integer", length=255, nullable=true)
     */
    private $storeOwnerProfileID;

    /**
     * @ORM\Column(type="integer", length=255, nullable=true)
     */
    private $orderInvoiceId;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $state;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getOrderNumber(): ?string
    {
        return $this->orderNumber;
    }

    public function setOrderNumber(?string $orderNumber): self
    {
        $this->orderNumber = $orderNumber;

        return $this;
    }

    public function getOrderID(): ?int
    {
        return $this->orderID;
    }

    public function setOrderID(?int $orderID): self
    {
        $this->orderID = $orderID;

        return $this;
    }

    public function getProductID(): ?int
    {
        return $this->productID;
    }

    public function setProductID(int $productID): self
    {
        $this->productID = $productID;

        return $this;
    }

    public function getCountProduct(): ?int
    {
        return $this->countProduct;
    }

    public function setCountProduct(int $countProduct): self
    {
        $this->countProduct = $countProduct;

        return $this;
    }

    public function getStoreOwnerProfileID(): ?int
    {
        return $this->storeOwnerProfileID;
    }

    public function setStoreOwnerProfileID(int $storeOwnerProfileID): self
    {
        $this->storeOwnerProfileID = $storeOwnerProfileID;

        return $this;
    }

    public function getOrderInvoiceId(): ?int
    {
        return $this->orderInvoiceId;
    }

    public function setOrderInvoiceId(int $orderInvoiceId): self
    {
        $this->orderInvoiceId = $orderInvoiceId;

        return $this;
    }

    public function getState(): ?string
    {
        return $this->state;
    }

    public function setState(?string $state): self
    {
        $this->state = $state;

        return $this;
    }
}
