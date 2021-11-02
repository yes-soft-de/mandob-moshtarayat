<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\DeliveryCompanyFinancialEntity;
use App\Manager\DeliveryCompanyFinancialManager;
use App\Request\DeliveryCompanyFinancialRequest;
use App\Response\DeliveryCompanyFinancialResponse;
use App\Response\DeliveryCompanyDeliveryCostResponse;

class DeliveryCompanyFinancialService
{
    private $autoMapping;
    private $deliveryCompanyFinancialManager;

    public function __construct(AutoMapping $autoMapping, DeliveryCompanyFinancialManager $deliveryCompanyFinancialManager)
    {
        $this->autoMapping = $autoMapping;
        $this->deliveryCompanyFinancialManager = $deliveryCompanyFinancialManager;
    }

    public function createDeliveryCompanyFinancial(DeliveryCompanyFinancialRequest $request)
    {
        $item = $this->deliveryCompanyFinancialManager->createDeliveryCompanyFinancial($request);
        if ($item instanceof DeliveryCompanyFinancialEntity) {
             return $this->autoMapping->map(DeliveryCompanyFinancialEntity::class, DeliveryCompanyFinancialResponse::class, $item);
        }
        if ($item == true) {
          
            return $this->getDeliveryCompanyFinancialAll();
        }
    }

    public function updateDeliveryCompanyFinancial($request)
    {
        $result = $this->deliveryCompanyFinancialManager->updateDeliveryCompanyFinancial($request);

        return $this->autoMapping->map(DeliveryCompanyFinancialEntity::class, DeliveryCompanyFinancialResponse::class, $result);
    }

    public function  getDeliveryCompanyFinancialById($id)
    {
        $result = $this->deliveryCompanyFinancialManager->getDeliveryCompanyFinancialById($id);

        return $this->autoMapping->map(DeliveryCompanyFinancialEntity::class, DeliveryCompanyFinancialResponse::class, $result);
  
    }

    public function  getDeliveryCompanyFinancialAll()
    {
        $response = [];
        $results = $this->deliveryCompanyFinancialManager->getDeliveryCompanyFinancialAll();
       
        foreach ($results as  $result) {
           $response[] = $this->autoMapping->map('array', DeliveryCompanyFinancialResponse::class, $result);
        }
        return $response;
       
    }

    public function  getDeliveryCost()
    {
        $response = [];
        $results = $this->deliveryCompanyFinancialManager->getDeliveryCompanyFinancialAll();
       
        foreach ($results as  $result) {
           $response[] = $this->autoMapping->map('array', DeliveryCompanyDeliveryCostResponse::class, $result);
        }
        return $response; 
    }
}
