<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\ClientPaymentEntity;
use App\Manager\ClientPaymentManager;
use App\Request\ClientPaymentCreateRequest;
use App\Response\ClientPaymentCreateResponse;

class ClientPaymentService
{
    private $autoMapping;
    private $clientPaymentManager;

    public function __construct(AutoMapping $autoMapping, ClientPaymentManager $clientPaymentManager)
    {
        $this->autoMapping = $autoMapping;
        $this->clientPaymentManager = $clientPaymentManager;
    }

    public function createClientPayment(ClientPaymentCreateRequest $request)
    {
        $item = $this->clientPaymentManager->createClientPayment($request);

        return $this->autoMapping->map(ClientPaymentEntity::class, ClientPaymentCreateResponse::class, $item);
    }
}
