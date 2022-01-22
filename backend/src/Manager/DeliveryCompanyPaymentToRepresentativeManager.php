<?php

namespace App\Manager;

use App\AutoMapping;
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
}
