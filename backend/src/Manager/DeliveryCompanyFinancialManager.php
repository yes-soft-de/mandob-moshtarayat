<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\DeliveryCompanyFinancialEntity;
use App\Repository\DeliveryCompanyFinancialEntityRepository;
use App\Request\DeliveryCompanyFinancialRequest;
use App\Request\DeliveryCompanyFinancialUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;


class DeliveryCompanyFinancialManager
{
    private $autoMapping;
    private $entityManager;
    private $deliveryCompanyFinancialEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, DeliveryCompanyFinancialEntityRepository $deliveryCompanyFinancialEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->deliveryCompanyFinancialEntityRepository = $deliveryCompanyFinancialEntityRepository;
    }

    public function createDeliveryCompanyFinancial(DeliveryCompanyFinancialRequest $request)
    {
        $isFound = $this->getDeliveryCompanyFinancialAll();
        if ($isFound == null) {
            $entity = $this->autoMapping->map(DeliveryCompanyFinancialRequest::class, DeliveryCompanyFinancialEntity::class, $request);

            $this->entityManager->persist($entity);
            $this->entityManager->flush();
            $this->entityManager->clear();

            return $entity;
        }
        else {
            return true;
        }
    }

    public function updateDeliveryCompanyFinancial(DeliveryCompanyFinancialUpdateRequest $request)
    {
        $entity = $this->deliveryCompanyFinancialEntityRepository->find($request->getId());

        if (!$entity) {
            return null;
        }
        $entity = $this->autoMapping->mapToObject(DeliveryCompanyFinancialUpdateRequest::class, DeliveryCompanyFinancialEntity::class, $request, $entity);

        $this->entityManager->flush();

        return $entity;
    } 

    public function getDeliveryCompanyFinancialById($id)
    {
        return $this->deliveryCompanyFinancialEntityRepository->getDeliveryCompanyFinancialById($id);
    }

    public function getDeliveryCompanyFinancialAll()
    {
       return $this->deliveryCompanyFinancialEntityRepository->getDeliveryCompanyFinancialAll();
    }
}
