<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\DeliveryCompanyPaymentsToCaptainEntity;
use App\Repository\DeliveryCompanyPaymentsToCaptainEntityRepository;
use App\Request\DeliveryCompanyPaymentsToCaptainCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class DeliveryCompanyPaymentsToCaptainManager
{
    private $autoMapping;
    private $entityManager;
    private $deliveryCompanyPaymentsToCaptainEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, DeliveryCompanyPaymentsToCaptainEntityRepository $deliveryCompanyPaymentsToCaptainEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->deliveryCompanyPaymentsToCaptainEntityRepository = $deliveryCompanyPaymentsToCaptainEntityRepository;
    }

    public function createDeliveryCompanyPaymentsToCaptain(DeliveryCompanyPaymentsToCaptainCreateRequest $request)
    {
        $entity = $this->autoMapping->map(DeliveryCompanyPaymentsToCaptainCreateRequest::class, DeliveryCompanyPaymentsToCaptainEntity::class, $request);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }

    public function deliveryCompanyPaymentsToCaptain($captainId)
    {
        return $this->deliveryCompanyPaymentsToCaptainEntityRepository->deliveryCompanyPaymentsToCaptain($captainId);
    }

    public function deliveryCompanySumPaymentsToCaptain($captainId)
    {
        return $this->deliveryCompanyPaymentsToCaptainEntityRepository->deliveryCompanySumPaymentsToCaptain($captainId);
    }

    public function deliveryCompanySumPaymentsToCaptainInSpecificDate($captainId, $ToDate, $toDate)
    {
        return $this->deliveryCompanyPaymentsToCaptainEntityRepository->deliveryCompanySumPaymentsToCaptainInSpecificDate($captainId, $ToDate, $toDate);
    }

    public function deliveryCompanyPaymentsToCaptainInSpecificDate($captainId, $ToDate, $toDate)
    {
        return $this->deliveryCompanyPaymentsToCaptainEntityRepository->deliveryCompanyPaymentsToCaptainInSpecificDate($captainId, $ToDate, $toDate);
    }
}
