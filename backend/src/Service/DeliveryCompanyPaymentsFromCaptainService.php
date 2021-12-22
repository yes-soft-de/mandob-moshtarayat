<?php

namespace App\Service;

use App\AutoMapping;
use App\Manager\DeliveryCompanyPaymentsFromCaptainManager;
use App\Entity\DeliveryCompanyPaymentsFromCaptainEntity;
use App\Request\DeliveryCompanyPaymentsFromCaptainCreateRequest;
use App\Response\DeliveryCompanyPaymentsFromCaptainCreateResponse;

class DeliveryCompanyPaymentsFromCaptainService
{
    private $autoMapping;
    private $deliveryCompanyPaymentsFromCaptainManager;

    public function __construct(AutoMapping $autoMapping, DeliveryCompanyPaymentsFromCaptainManager $deliveryCompanyPaymentsFromCaptainManager)
    {
        $this->autoMapping = $autoMapping;
        $this->deliveryCompanyPaymentsFromCaptainManager = $deliveryCompanyPaymentsFromCaptainManager;
    }

    public function createDeliveryCompanyPaymentsFromCaptain(DeliveryCompanyPaymentsFromCaptainCreateRequest $request)
    {
        $item = $this->deliveryCompanyPaymentsFromCaptainManager->createDeliveryCompanyPaymentsFromCaptain($request);

        return $this->autoMapping->map(DeliveryCompanyPaymentsFromCaptainEntity::class, DeliveryCompanyPaymentsFromCaptainCreateResponse::class, $item);
    }
    
    public function deliveryCompanyPaymentsFromCaptain($captainId)
    {
      return $this->deliveryCompanyPaymentsFromCaptainManager->deliveryCompanyPaymentsFromCaptain($captainId);
    }

    public function deliveryCompanySumPaymentsFromCaptain($captainId)
    {
      return $this->deliveryCompanyPaymentsFromCaptainManager->deliveryCompanySumPaymentsFromCaptain($captainId);
    }

    public function deliveryCompanySumPaymentsFromCaptains()
    {
      return $this->deliveryCompanyPaymentsFromCaptainManager->deliveryCompanySumPaymentsFromCaptains();
    }

    public function deliveryCompanySumPaymentsFromCaptainInSpecificDate($captainId, $fromDate, $toDate)
    {
       return $this->deliveryCompanyPaymentsFromCaptainManager->deliveryCompanySumPaymentsFromCaptainInSpecificDate($captainId, $fromDate, $toDate);
    }

    public function deliveryCompanyPaymentsFromCaptainInSpecificDate($captainId, $fromDate, $toDate)
    {
       return $this->deliveryCompanyPaymentsFromCaptainManager->deliveryCompanyPaymentsFromCaptainInSpecificDate($captainId, $fromDate, $toDate);
    }

}
