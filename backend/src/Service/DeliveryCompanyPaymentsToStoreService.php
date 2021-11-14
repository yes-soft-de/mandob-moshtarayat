<?php

namespace App\Service;

use App\AutoMapping;
use App\Manager\DeliveryCompanyPaymentsToStoreManager;
use App\Entity\DeliveryCompanyPaymentsToStoreEntity;
use App\Request\DeliveryCompanyPaymentsToStoreCreateRequest;
use App\Response\DeliveryCompanyPaymentsToStoreCreateResponse;

class DeliveryCompanyPaymentsToStoreService
{
    private $autoMapping;
    private $deliveryCompanyPaymentsToStoreManager;

    public function __construct(AutoMapping $autoMapping, DeliveryCompanyPaymentsToStoreManager $deliveryCompanyPaymentsToStoreManager)
    {
        $this->autoMapping = $autoMapping;
        $this->deliveryCompanyPaymentsToStoreManager = $deliveryCompanyPaymentsToStoreManager;
    }

    public function createDeliveryCompanyPaymentsToStore(DeliveryCompanyPaymentsToStoreCreateRequest $request)
    {
        $item = $this->deliveryCompanyPaymentsToStoreManager->createDeliveryCompanyPaymentsToStore($request);

        return $this->autoMapping->map(DeliveryCompanyPaymentsToStoreEntity::class, DeliveryCompanyPaymentsToStoreCreateResponse::class, $item);
    }
    
    public function deliveryCompanyPaymentsToStore($captainId)
    {
      return $this->deliveryCompanyPaymentsToStoreManager->deliveryCompanyPaymentsToStore($captainId);
    }

    public function deliveryCompanySumPaymentsToStore($captainId)
    {
      return $this->deliveryCompanyPaymentsToStoreManager->deliveryCompanySumPaymentsToStore($captainId);
    }

    public function deliveryCompanySumPaymentsToStoreInSpecificDate($captainId, $ToDate, $toDate)
    {
       return $this->deliveryCompanyPaymentsToStoreManager->deliveryCompanySumPaymentsToStoreInSpecificDate($captainId, $ToDate, $toDate);
    }

    public function deliveryCompanyPaymentsToStoreInSpecificDate($captainId, $ToDate, $toDate)
    {
       return $this->deliveryCompanyPaymentsToStoreManager->deliveryCompanyPaymentsToStoreInSpecificDate($captainId, $ToDate, $toDate);
    }

}
