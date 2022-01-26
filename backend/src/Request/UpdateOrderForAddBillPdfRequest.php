<?php

namespace App\Request;

class UpdateOrderForAddBillPdfRequest
{
    private $orderNumber;

    private $billPdf;

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

}