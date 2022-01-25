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

        return $orderLogEntity;
    }
    //TODO this for remove when creat request file for createOrderLog
    public function createOrderLogFromManager($orderNumber, $state, $userID, $storeOwnerProfileID = 0)
    {
        $item['orderNumber'] = $orderNumber;
        $item['state'] = $state;
        $item['userID'] = $userID;
        $item['storeOwnerProfileID'] = $storeOwnerProfileID;

        $result = $this->createOrderLog($item);

    }

    public function getOrderLogByOrderNumber($orderNumber)
    {
        return $this->orderLogEntityRepository->getOrderLogByOrderNumber($orderNumber);
    }

    public function getOrderLogsByOrderNumber($orderNumber)
    {
        return $this->orderLogEntityRepository->getOrderLogsByOrderNumber($orderNumber);
    }

    public function getOrderLogsTimeLineForByStoreID($orderNumber, $storeId)
    {
        return $this->orderLogEntityRepository->getOrderLogsTimeLineForByStoreID($orderNumber, $storeId);
    }

    public function getFirstDate($orderNumber)
    {
        return $this->orderLogEntityRepository->getFirstDate($orderNumber);
    }

    public function getFirstDateForStore($orderNumber, $storeID)
    {
        return $this->orderLogEntityRepository->getFirstDateForStore($orderNumber, $storeID);
    }

    public function getAcceptOrderDate($orderNumber)
    {
        return $this->orderLogEntityRepository->getAcceptOrderDate($orderNumber);
    }

    public function getAcceptOrderDateForStore($orderNumber, $storeId)
    {
        return $this->orderLogEntityRepository->getAcceptOrderDateForStore($orderNumber, $storeId);
    }

    public function getLastDate($orderNumber)
    {
        return $this->orderLogEntityRepository->getLastDate($orderNumber);
    }

    public function getLastDateForStore($orderNumber, $storeId)
    {
        return $this->orderLogEntityRepository->getLastDateForStore($orderNumber, $storeId);
    }

    public function getCaptainOrderLogs($captainID)
    {
        return $this->orderLogEntityRepository->getCaptainOrderLogs($captainID);
    }

    public function getOrderNumberUserID($userID)
    {
        return $this->orderLogEntityRepository->getOrderNumberUserID($userID);
    }

    public function getOwnerOrderLogs($userID)
    {
        return $this->orderLogEntityRepository->getOwnerOrderLogs($userID);
    }
}
