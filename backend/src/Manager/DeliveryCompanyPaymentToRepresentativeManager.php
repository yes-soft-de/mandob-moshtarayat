<?php

namespace App\Manager;

use App\AutoMapping;
use App\Constant\ItemStatusConstant;
use App\Entity\DeliveryCompanyPaymentsToRepresentativeEntity;
use App\Repository\DeliveryCompanyPaymentsToRepresentativeEntityRepository;
use App\Request\DeliveryCompanyPaymentToRepresentativeCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class DeliveryCompanyPaymentToRepresentativeManager
{
    private $autoMapping;
    private $entityManager;
    private $deliveryCompanyPaymentsToRepresentativeEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, DeliveryCompanyPaymentsToRepresentativeEntityRepository $deliveryCompanyPaymentsToRepresentativeEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->deliveryCompanyPaymentsToRepresentativeEntityRepository = $deliveryCompanyPaymentsToRepresentativeEntityRepository;
    }

    public function createDeliveryCompanyPaymentsToRepresentative(DeliveryCompanyPaymentToRepresentativeCreateRequest $request)
    {
        $deliveryCompanyPaymentToRepresentativeEntity = $this->autoMapping->map(DeliveryCompanyPaymentToRepresentativeCreateRequest::class, DeliveryCompanyPaymentsToRepresentativeEntity::class, $request);

        $this->entityManager->persist($deliveryCompanyPaymentToRepresentativeEntity);
        $this->entityManager->flush();

        return $deliveryCompanyPaymentToRepresentativeEntity;
    }

    public function getDeliveryCompanyPaymentsToRepresentativeByRepresentativeID($representativeID): ?array
    {
        return $this->deliveryCompanyPaymentsToRepresentativeEntityRepository->getDeliveryCompanyPaymentsToRepresentativeByRepresentativeID($representativeID);
    }

    public function getDeliveryCompanySumPaymentsToRepresentative($representativeID)
    {
        return $this->deliveryCompanyPaymentsToRepresentativeEntityRepository->getDeliveryCompanySumPaymentsToRepresentative($representativeID);
    }

    public function deletePaymentToRepresentative($id)
    {
        $result = $this->deliveryCompanyPaymentsToRepresentativeEntityRepository->find($id);

        if($result) {
            
            $this->entityManager->remove($result);
            $this->entityManager->flush();

            return $result;
        }

        return ItemStatusConstant::$ITEM_NOT_FOUND;
    }
}
