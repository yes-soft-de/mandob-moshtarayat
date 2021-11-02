<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\DeliveryCompanyPaymentsFromCaptainEntity;
use App\Repository\DeliveryCompanyPaymentsFromCaptainEntityRepository;
use App\Request\DeliveryCompanyPaymentsFromCaptainCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class DeliveryCompanyPaymentsFromCaptainManager
{
    private $autoMapping;
    private $entityManager;
    private $deliveryCompanyPaymentsFromCaptainEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, DeliveryCompanyPaymentsFromCaptainEntityRepository $deliveryCompanyPaymentsFromCaptainEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->deliveryCompanyPaymentsFromCaptainEntityRepository = $deliveryCompanyPaymentsFromCaptainEntityRepository;
    }

    public function createDeliveryCompanyPaymentsFromCaptain(DeliveryCompanyPaymentsFromCaptainCreateRequest $request)
    {
        $entity = $this->autoMapping->map(DeliveryCompanyPaymentsFromCaptainCreateRequest::class, DeliveryCompanyPaymentsFromCaptainEntity::class, $request);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }

    public function deliveryCompanyPaymentsFromCaptain($captainId)
    {
        return $this->deliveryCompanyPaymentsFromCaptainEntityRepository->deliveryCompanyPaymentsFromCaptain($captainId);
    }

    public function deliveryCompanySumPaymentsFromCaptain($captainId)
    {
        return $this->deliveryCompanyPaymentsFromCaptainEntityRepository->deliveryCompanySumPaymentsFromCaptain($captainId);
    }

    public function deliveryCompanySumPaymentsFromCaptains()
    {
        return $this->deliveryCompanyPaymentsFromCaptainEntityRepository->deliveryCompanySumPaymentsFromCaptains();
    }

    public function deliveryCompanySumPaymentsFromCaptainInSpecificDate($captainId, $fromDate, $toDate)
    {
        return $this->deliveryCompanyPaymentsFromCaptainEntityRepository->deliveryCompanySumPaymentsFromCaptainInSpecificDate($captainId, $fromDate, $toDate);
    }

    public function deliveryCompanyPaymentsFromCaptainInSpecificDate($captainId, $fromDate, $toDate)
    {
        return $this->deliveryCompanyPaymentsFromCaptainEntityRepository->deliveryCompanyPaymentsFromCaptainInSpecificDate($captainId, $fromDate, $toDate);
    }
}
