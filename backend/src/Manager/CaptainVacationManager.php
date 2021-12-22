<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\CaptainVacationEntity;
use App\Repository\CaptainVacationEntityRepository;
use App\Request\CaptainVacationCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class CaptainVacationManager
{
    private $autoMapping;
    private $entityManager;
    private $captainVacationRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, CaptainVacationEntityRepository $captainVacationRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->captainVacationRepository = $captainVacationRepository;
    }

    public function createCaptainVacation(CaptainVacationCreateRequest $request)
    {
        $entity = $this->autoMapping->map(CaptainVacationCreateRequest::class, CaptainVacationEntity::class, $request);

        $entity->setStartDate($request->getStartDate());
        $entity->setEndDate($request->getEndDate());

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }
}
