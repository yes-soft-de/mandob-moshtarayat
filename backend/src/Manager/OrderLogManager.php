<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\OrderLogEntity;
use App\Repository\OrderLogEntityRepository;
use Doctrine\ORM\EntityManagerInterface;


class OrderLogManager
{
    private $autoMapping;
    private $entityManager;
    private $orderLogEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, OrderLogEntityRepository $orderLogEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->orderLogEntityRepository = $orderLogEntityRepository;
    }

    public function createOrderLog($log)
    {
        $orderLogEntity = $this->autoMapping->map('array', OrderLogEntity::class, $log);
        
        $this->entityManager->persist($orderLogEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $orderLogEntity;
    }

    public function getOrderLogByOrderNumber($orderNumber)
    {
        return $this->orderLogEntityRepository->getOrderLogByOrderNumber($orderNumber);
    }

    public function getOrderLogsByOrderNumber($orderNumber)
    {
        return $this->orderLogEntityRepository->getOrderLogsByOrderNumber($orderNumber);
    }

    public function orderLogsByCaptainId($captainId)
    {
        return $this->orderLogEntityRepository->orderLogsByCaptainId($captainId);
    }

    public function orderLogsByStoreProfileId($storeProfileId)
    {
        return $this->orderLogEntityRepository->orderLogsByStoreProfileId($storeProfileId);
    }

    public function getFirstDate($orderNumber)
    {
        return $this->orderLogEntityRepository->getFirstDate($orderNumber);
    }

    public function getAcceptOrderDate($orderNumber)
    {
        return $this->orderLogEntityRepository->getAcceptOrderDate($orderNumber);
    }
    
    public function getLastDate($orderNumber)
    {
        return $this->orderLogEntityRepository->getLastDate($orderNumber);
    }

    public function getOrderNumberByOwnerId($ownerID)
    {
        return $this->orderLogEntityRepository->getOrderNumberByOwnerId($ownerID);
    }

    public function getOrderNumberByCaptainId($captainID)
    {
        return $this->orderLogEntityRepository->getOrderNumberByCaptainId($captainID);
    }

    public function getOrderNumberUserID($userID)
    {
        return $this->orderLogEntityRepository->getOrderNumberUserID($userID);
    }
}
