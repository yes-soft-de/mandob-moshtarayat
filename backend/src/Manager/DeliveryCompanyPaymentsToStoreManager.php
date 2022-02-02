<?php

namespace App\Manager;

use App\AutoMapping;
use App\Constant\ItemStatusConstant;
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

    public function deliveryCompanySumPaymentsToStoreInSpecificDate($storeOwnerProfileID, $fromDate, $toDate)
    {
        return $this->deliveryCompanyPaymentsToStoreEntityRepository->deliveryCompanySumPaymentsToStoreInSpecificDate($storeOwnerProfileID, $fromDate, $toDate);
    }

    public function deliveryCompanyPaymentsToStoreInSpecificDate($storeOwnerProfileID, $fromDate, $toDate)
    {
        return $this->deliveryCompanyPaymentsToStoreEntityRepository->deliveryCompanyPaymentsToStoreInSpecificDate($storeOwnerProfileID, $fromDate, $toDate);
    }

    public function deletePaymentToStore($id)
    {
        $result = $this->deliveryCompanyPaymentsToStoreEntityRepository->find($id);

        if($result) {
            $this->entityManager->remove($result);
            $this->entityManager->flush();

            return $result;
        }

        return ItemStatusConstant::$ITEM_NOT_FOUND;
    }

}
