<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\RepresentativeDueEntity;
use App\Repository\RepresentativeDueEntityRepository;
use App\Request\RepresentativeDueCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class RepresentativeDueManager
{
    private $autoMapping;
    private $entityManager;
    private $deliveryCompanyFinancialManager;
    private $representativeDueEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, DeliveryCompanyFinancialManager $deliveryCompanyFinancialManager,
                                RepresentativeDueEntityRepository $representativeDueEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->deliveryCompanyFinancialManager = $deliveryCompanyFinancialManager;
        $this->representativeDueEntityRepository = $representativeDueEntityRepository;
    }

    public function createRepresentativeDue(RepresentativeDueCreateRequest $request)
    {
        $representativeDueEntity = $this->autoMapping->map(RepresentativeDueCreateRequest::class, RepresentativeDueEntity::class, $request);

        $representativeDueEntity->setDueAmount($this->getRepresentativeCommission());

        $this->entityManager->persist($representativeDueEntity);
        $this->entityManager->flush();

        return $representativeDueEntity;
    }

    public function getRepresentativeCommission()
    {
        $representativeCommission = $this->deliveryCompanyFinancialManager->getRepresentativeCommission();

        if (!$representativeCommission) {

            return 0;
        } else {

            return $representativeCommission;
        }
    }

    public function getSumRepresentativeDueByRepresentativeUserID($representativeUserID)
    {
        return $this->representativeDueEntityRepository->getSumRepresentativeDueByRepresentativeUserID($representativeUserID);
    }
}
