<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\DeliveryCompanyPaymentsToStoreEntity;
use App\Repository\DeliveryCompanyPaymentsToStoreEntityRepository;
use App\Request\DeliveryCompanyPaymentsToStoreCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class DeliveryCompanyPaymentsToStoreManager
{
    private $autoMapping;
    private $entityManager;
    private $deliveryCompanyPaymentsToStoreEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, DeliveryCompanyPaymentsToStoreEntityRepository $deliveryCompanyPaymentsToStoreEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->deliveryCompanyPaymentsToStoreEntityRepository = $deliveryCompanyPaymentsToStoreEntityRepository;
    }

    public function createDeliveryCompanyPaymentsToStore(DeliveryCompanyPaymentsToStoreCreateRequest $request)
    {
        $entity = $this->autoMapping->map(DeliveryCompanyPaymentsToStoreCreateRequest::class, DeliveryCompanyPaymentsToStoreEntity::class, $request);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }

    public function deliveryCompanyPaymentsToStore($storeOwnerProfileID)
    {
        return $this->deliveryCompanyPaymentsToStoreEntityRepository->deliveryCompanyPaymentsToStore($storeOwnerProfileID);
    }

    public function deliveryCompanySumPaymentsToStore($storeOwnerProfileID)
    {
        return $this->deliveryCompanyPaymentsToStoreEntityRepository->deliveryCompanySumPaymentsToStore($storeOwnerProfileID);
    }

    public function deliveryCompanySumPaymentsToStoreInSpecificDate($storeOwnerProfileID, $ToDate, $toDate)
    {
        return $this->deliveryCompanyPaymentsToStoreEntityRepository->deliveryCompanySumPaymentsToStoreInSpecificDate($storeOwnerProfileID, $ToDate, $toDate);
    }

    public function deliveryCompanyPaymentsToStoreInSpecificDate($storeOwnerProfileID, $ToDate, $toDate)
    {
        return $this->deliveryCompanyPaymentsToStoreEntityRepository->deliveryCompanyPaymentsToStoreInSpecificDate($storeOwnerProfileID, $ToDate, $toDate);
    }
}
