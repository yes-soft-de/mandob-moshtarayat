<?php

namespace App\Service;

use App\AutoMapping;
use App\Manager\DeliveryCompanyPaymentsToStoreManager;
use App\Entity\DeliveryCompanyPaymentsToStoreEntity;
use App\Request\DeliveryCompanyPaymentsToStoreCreateRequest;
use App\Response\DeliveryCompanyPaymentsToStoreCreateResponse;
use App\Service\UserService;

class DeliveryCompanyPaymentsToStoreService
{
    private $autoMapping;
    private $deliveryCompanyPaymentsToStoreManager;
    private $userService;

    public function __construct(AutoMapping $autoMapping, DeliveryCompanyPaymentsToStoreManager $deliveryCompanyPaymentsToStoreManager, UserService $userService)
    {
        $this->autoMapping = $autoMapping;
        $this->deliveryCompanyPaymentsToStoreManager = $deliveryCompanyPaymentsToStoreManager;
        $this->userService = $userService;
    }

    public function createDeliveryCompanyPaymentsToStore(DeliveryCompanyPaymentsToStoreCreateRequest $request)
    {
        $item = $this->deliveryCompanyPaymentsToStoreManager->createDeliveryCompanyPaymentsToStore($request);

        return $this->autoMapping->map(DeliveryCompanyPaymentsToStoreEntity::class, DeliveryCompanyPaymentsToStoreCreateResponse::class, $item);
    }
    
    public function deliveryCompanyPaymentsToStoreByUserID($userID)
    {
      $storeOwnerProfileID =  $this->userService->getStoreProfileId($userID);
      return $this->deliveryCompanyPaymentsToStoreManager->deliveryCompanyPaymentsToStore($storeOwnerProfileID);
    }

    public function deliveryCompanyPaymentsToStore($storeOwnerProfileID)
    {
      return $this->deliveryCompanyPaymentsToStoreManager->deliveryCompanyPaymentsToStore($storeOwnerProfileID);
    }

    public function deliveryCompanySumPaymentsToStore($storeOwnerProfileID)
    {
      return $this->deliveryCompanyPaymentsToStoreManager->deliveryCompanySumPaymentsToStore($storeOwnerProfileID);
    }

    public function deliveryCompanySumPaymentsToStoreInSpecificDate($storeOwnerProfileID, $fromDate, $toDate)
    {
       return $this->deliveryCompanyPaymentsToStoreManager->deliveryCompanySumPaymentsToStoreInSpecificDate($storeOwnerProfileID, $fromDate, $toDate);
    }

    public function deliveryCompanyPaymentsToStoreInSpecificDate($storeOwnerProfileID, $fromDate, $toDate)
    {
       return $this->deliveryCompanyPaymentsToStoreManager->deliveryCompanyPaymentsToStoreInSpecificDate($storeOwnerProfileID, $fromDate, $toDate);
    }

}
