<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\SupportEntity;
use App\Repository\SupportEntityRepository;
use App\Request\SupportCreateRequest;
use Doctrine\ORM\EntityManagerInterface;


class SupportManager
{
    private $autoMapping;
    private $entityManager;
    private $supportEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, SupportEntityRepository $supportEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->supportEntityRepository = $supportEntityRepository;
    }

    public function createSupport(SupportCreateRequest $request, $roomID)
    {
        $request->setRoomID($roomID);
        $entity = $this->autoMapping->map(SupportCreateRequest::class, SupportEntity::class, $request);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }

    public function getSupports()
    {
        return $this->supportEntityRepository->getSupports();
    }

    public function getSupport($id)
    {
        return $this->supportEntityRepository->getSupport($id);
    }

    public function getReportByRoomID($roomID)
    {
        return $this->supportEntityRepository->getreortByRoomID($roomID);
    }

    public function update($request, $NewMessageStatus)
    {
        if ($request) {
            $entity = $this->supportEntityRepository->find($request->getId());
            
            if (!$entity) {
                return null;
            }
            $entity->setNewMessageStatus($NewMessageStatus);
        
            $entity = $this->autoMapping->mapToObject(SupportEntity::class, SupportEntity::class, $entity, $entity);

            $this->entityManager->flush();

            return $entity;
        }
        return null;
    }

    public function supportReportNewMessageStatus($id)
    {
        
            $entity = $this->supportEntityRepository->find($id);
            
            if (!$entity) {
                return null;
            }
            $entity->setNewMessageStatus(false);
        
            $entity = $this->autoMapping->mapToObject(SupportEntity::class, SupportEntity::class, $entity, $entity);

            $this->entityManager->flush();

            return $entity;
    }
}
