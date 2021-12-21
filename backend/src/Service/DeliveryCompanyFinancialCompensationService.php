<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\DeliveryCompanyFinancialCompensationEntity;
use App\Manager\DeliveryCompanyFinancialCompensationManager;
use App\Request\DeliveryCompanyFinancialCompensationCreateRequest;
use App\Request\DeliveryCompanyFinancialCompensationUpdateRequest;
use App\Response\DeliveryCompanyFinancialCompensationResponse;
use App\Response\CompensationAndDeliveryCostResponse;
use App\Service\DeliveryCompanyFinancialService;

class DeliveryCompanyFinancialCompensationService
{
    private $autoMapping;
    private $deliveryCompanyFinancialCompensationManager;
    private $deliveryCompanyFinancialService;

    public function __construct(AutoMapping $autoMapping, deliveryCompanyFinancialCompensationManager $deliveryCompanyFinancialCompensationManager, DeliveryCompanyFinancialService $deliveryCompanyFinancialService)
    {
        $this->autoMapping = $autoMapping;
        $this->deliveryCompanyFinancialCompensationManager = $deliveryCompanyFinancialCompensationManager;
        $this->deliveryCompanyFinancialService = $deliveryCompanyFinancialService;
    }

    public function createFinancialCompensation(DeliveryCompanyFinancialCompensationCreateRequest $request)
    {
        $item = $this->deliveryCompanyFinancialCompensationManager->createFinancialCompensation($request);
        if ($item instanceof DeliveryCompanyFinancialCompensationEntity) {
        return $this->autoMapping->map(DeliveryCompanyFinancialCompensationEntity::class, DeliveryCompanyFinancialCompensationResponse::class, $item);
        }
        if ($item == true) {
          
            return $this->getFinancialCompensations();
        }
    }

    public function updateFinancialCompensation(DeliveryCompanyFinancialCompensationUpdateRequest $request)
    {
        $result = $this->deliveryCompanyFinancialCompensationManager->updateFinancialCompensation($request);

        return $this->autoMapping->map(DeliveryCompanyFinancialCompensationEntity::class, DeliveryCompanyFinancialCompensationResponse::class, $result);
    }

    public function  getFinancialCompensationById($id)
    {
        $result = $this->deliveryCompanyFinancialCompensationManager->getFinancialCompensationById($id);

        return $this->autoMapping->map(DeliveryCompanyFinancialCompensationEntity::class, DeliveryCompanyFinancialCompensationResponse::class, $result);
  
    }

    public function  getFinancialCompensations()
    {
        $response = [];
        $results = $this->deliveryCompanyFinancialCompensationManager->getFinancialCompensations();
       
        foreach ($results as  $result) {
           $response[] = $this->autoMapping->map('array', DeliveryCompanyFinancialCompensationResponse::class, $result);
        }
        return $response;
    }

    public function  getCompensationsAndDeliveryCost()
    {
        $response = [];
        $compensation = $this->deliveryCompanyFinancialCompensationManager->getFinancialCompensations();
        $deliveryCost = $this->deliveryCompanyFinancialService->getDeliveryCompanyFinancialAll();
        $arr['compensation'] = $compensation;
        $arr['deliveryCost'] = $deliveryCost;
        $response = $this->autoMapping->map('array', CompensationAndDeliveryCostResponse::class, $arr);
        return $response;  
    }
}
