<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\OrderDetailEntity;
use App\Repository\OrderDetailEntityRepository;
use Doctrine\ORM\EntityManagerInterface;
use App\Request\OrderDetailUpdateByClientRequest;


class OrderDetailManager
{
    private $autoMapping;
    private $entityManager;
    private $orderDetailEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, OrderDetailEntityRepository $orderDetailEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->orderDetailEntityRepository = $orderDetailEntityRepository;
    }

    public function createOrderDetail($item)
    {
        $orderDetailEntity = $this->autoMapping->map('array', OrderDetailEntity::class, $item);
        
        $this->entityManager->persist($orderDetailEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $orderDetailEntity;
    }

    public function getLastOrderNumber()
    {
       return $this->orderDetailEntityRepository->getLastOrderNumber();
    }

    public function getOrderIdByOrderNumber($orderNumber)
    {
       return $this->orderDetailEntityRepository->getOrderIdByOrderNumber($orderNumber);
    }

    public function getOrderIdWithOutStoreProductByOrderNumber($orderNumber)
    {
       return $this->orderDetailEntityRepository->getOrderIdWithOutStoreProductByOrderNumber($orderNumber);
    }

    public function getOrderNumberByOrderId($orderID)
    {
       return $this->orderDetailEntityRepository->getOrderNumberByOrderId($orderID);
    }

    public function orderUpdateByClient(OrderDetailUpdateByClientRequest $request, $orderDetail)
    {
        $item = $this->orderDetailEntityRepository->find($orderDetail->getId());       
        if ($item) {
            $item = $this->autoMapping->mapToObject(OrderDetailUpdateByClientRequest::class, OrderDetailEntity::class, $request, $item);

            $this->entityManager->flush();
            $this->entityManager->clear();

            return $item;
        }
    }

    public function orderDetailDelete($id)
    {
        $item = $this->orderDetailEntityRepository->find($id);

        if ($item)
        {
            $this->entityManager->remove($item);
            $this->entityManager->flush();
            return "Deleted";
        }
    }

    public function getCountOrdersEveryProductInLastMonth($fromDate, $toDate)
    {
        return $this->orderDetailEntityRepository->getCountOrdersEveryProductInLastMonth($fromDate, $toDate);
    }
}
