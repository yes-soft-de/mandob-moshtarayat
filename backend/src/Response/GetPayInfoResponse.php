<?php

namespace App\Response;

class GetPayInfoResponse
{
    public $id;
    public $transactionID;
    public $token;
    public $amount;
    public $payStatus;
    public $createdAt;
    public $updatedAt;
    public $orderNumber;
    public $clientName;
}