<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\CaptainTermEntity;
use App\Repository\CaptainTermEntityRepository;
use App\Request\CaptainTermCreateRequest;
use App\Request\CaptainTermUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;

class CaptainTermManager
{
    private $autoMapping;
    private $entityManager;
    private $captainTermEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, CaptainTermEntityRepository $captainTermEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->captainTermEntityRepository = $captainTermEntityRepository;
    }

    public function createCaptainTerm(CaptainTermCreateRequest $request)
    {
        $entity = $this->autoMapping->map(CaptainTermCreateRequest::class, CaptainTermEntity::class, $request);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }

    public function getTermsCaptain()
    {
        return $this->captainTermEntityRepository->getTermsCaptain();
    }

    public function getTermsCaptainById($id) 
    {
        return $this->captainTermEntityRepository->getTermsCaptainById($id) ;
    }

    public function update(CaptainTermUpdateRequest $request)
    {
        $item = $this->captainTermEntityRepository->find($request->getId());
       
        if ($item) {
            $item = $this->autoMapping->mapToObject(CaptainTermUpdateRequest::class, CaptainTermEntity::class, $request, $item);
            
            $this->entityManager->flush();
            $this->entityManager->clear();

            return $item;
        }
    }
}
