<?php

namespace App\Service;

use App\AutoMapping;
use App\Manager\DeliveryCompanyPaymentsToCaptainManager;
use App\Entity\DeliveryCompanyPaymentsToCaptainEntity;
use App\Request\DeliveryCompanyPaymentsToCaptainCreateRequest;
use App\Response\DeliveryCompanyPaymentsToCaptainCreateResponse;

class DeliveryCompanyPaymentsToCaptainService
{
    private $autoMapping;
    private $deliveryCompanyPaymentsToCaptainManager;

    public function __construct(AutoMapping $autoMapping, DeliveryCompanyPaymentsToCaptainManager $deliveryCompanyPaymentsToCaptainManager)
    {
        $this->autoMapping = $autoMapping;
        $this->deliveryCompanyPaymentsToCaptainManager = $deliveryCompanyPaymentsToCaptainManager;
    }

    public function createDeliveryCompanyPaymentsToCaptain(DeliveryCompanyPaymentsToCaptainCreateRequest $request)
    {
        $item = $this->deliveryCompanyPaymentsToCaptainManager->createDeliveryCompanyPaymentsToCaptain($request);

        return $this->autoMapping->map(DeliveryCompanyPaymentsToCaptainEntity::class, DeliveryCompanyPaymentsToCaptainCreateResponse::class, $item);
    }
    
    public function deliveryCompanyPaymentsToCaptain($captainId)
    {
      return $this->deliveryCompanyPaymentsToCaptainManager->deliveryCompanyPaymentsToCaptain($captainId);
    }

    public function deliveryCompanySumPaymentsToCaptain($captainId)
    {
      return $this->deliveryCompanyPaymentsToCaptainManager->deliveryCompanySumPaymentsToCaptain($captainId);
    }

    public function deliveryCompanySumPaymentsToCaptainInSpecificDate($captainId, $ToDate, $toDate)
    {
       return $this->deliveryCompanyPaymentsToCaptainManager->deliveryCompanySumPaymentsToCaptainInSpecificDate($captainId, $ToDate, $toDate);
    }

    public function deliveryCompanyPaymentsToCaptainInSpecificDate($captainId, $ToDate, $toDate)
    {
       return $this->deliveryCompanyPaymentsToCaptainManager->deliveryCompanyPaymentsToCaptainInSpecificDate($captainId, $ToDate, $toDate);
    }

}
