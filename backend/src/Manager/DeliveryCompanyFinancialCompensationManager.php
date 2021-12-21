<?php

namespace App\Manager;

use App\AutoMapping;
use App\Repository\DeliveryCompanyFinancialCompensationEntityRepository;
use App\Entity\DeliveryCompanyFinancialCompensationEntity;
use App\Request\DeliveryCompanyFinancialCompensationCreateRequest;
use App\Request\DeliveryCompanyFinancialCompensationUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;


class DeliveryCompanyFinancialCompensationManager
{
    private $autoMapping;
    private $entityManager;
    private $deliveryCompanyFinancialCompensationEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, DeliveryCompanyFinancialCompensationEntityRepository $deliveryCompanyFinancialCompensationEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->deliveryCompanyFinancialCompensationEntityRepository = $deliveryCompanyFinancialCompensationEntityRepository;
    }

    public function createFinancialCompensation(DeliveryCompanyFinancialCompensationCreateRequest $request)
    {
       $isFound = $this->getFinancialCompensations();
        if ($isFound == null) {
        $entity = $this->autoMapping->map(DeliveryCompanyFinancialCompensationCreateRequest::class, DeliveryCompanyFinancialCompensationEntity::class, $request);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
        }
        else {
            return true;
        }
    }

    public function updateFinancialCompensation(DeliveryCompanyFinancialCompensationUpdateRequest $request)
    {
        $entity = $this->deliveryCompanyFinancialCompensationEntityRepository->find($request->getId());

        if (!$entity) {
            return null;
        }
        $entity = $this->autoMapping->mapToObject(DeliveryCompanyFinancialCompensationUpdateRequest::class, DeliveryCompanyFinancialCompensationEntity::class, $request, $entity);

        $this->entityManager->flush();

        return $entity;
    } 

    public function getFinancialCompensationById($id)
    {
        return $this->deliveryCompanyFinancialCompensationEntityRepository->getFinancialCompensationById($id);
    }

    public function getFinancialCompensations()
    {
       return $this->deliveryCompanyFinancialCompensationEntityRepository->getFinancialCompensations();
    }
}
