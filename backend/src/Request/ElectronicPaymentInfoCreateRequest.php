<?php

namespace App\Request;

class ElectronicPaymentInfoCreateRequest
{
    private $token;

    private $transactionID;

    private $orderNumber;

    private $payStatus;

    private $amount;

    /**
     * @return mixed
     */
    public function getOrderNumber()
    {
        return $this->orderNumber;
    }

    /**
     * @param mixed $orderNumber
     */
    public function setOrderNumber($orderNumber): void
    {
        $this->orderNumber = $orderNumber;
    }

    /**
     * @return mixed
     */
    public function getPayStatus()
    {
        return $this->payStatus;
    }

    /**
     * @param mixed $payStatus
     */
    public function setPayStatus($payStatus): void
    {
        $this->payStatus = $payStatus;
    }
}