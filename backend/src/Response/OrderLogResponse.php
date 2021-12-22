<?php

namespace App\Response;

class OrderLogResponse
{
    public $id;

    public $orderNumber;

    public $state;

    public $startTime;

    public $createdAt;

    public $completionTime;

    public $currentStage;
    
    public $storeOwnerProfileID;
}
