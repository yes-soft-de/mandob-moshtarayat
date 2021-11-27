<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\RoomIdHelperEntity;
use App\Repository\RoomIdHelperEntityRepository;
use Doctrine\ORM\EntityManagerInterface;


class RoomIdHelperManager
{
    private $autoMapping;
    private $entityManager;
    private $storeOwnerProfileManager;
    private $roomIdHelperEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, RoomIdHelperEntityRepository $roomIdHelperEntityRepository,
     StoreOwnerProfileManager $storeOwnerProfileManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->storeOwnerProfileManager = $storeOwnerProfileManager;
        $this->roomIdHelperEntityRepository = $roomIdHelperEntityRepository;
    }

    public function createRoomIdHelper($request)
    {
        $entity = $this->autoMapping->map('array', RoomIdHelperEntity::class, $request);
        $entity->setCaptainID($request[0]['captainID']);
        $entity->setOwnerID($request[0]['ownerID']);
        $entity->setRoomID($request[0]['roomID']);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }

    public function getByRoomID($roomID)
    {
        return $this->roomIdHelperEntityRepository->getByRoomID($roomID);
    }

    public function getStoreOwnerProfileByRoomID($roomID)
    {
        return $this->storeOwnerProfileManager->storeOwnerProfileByRoomID($roomID);
    }
}
