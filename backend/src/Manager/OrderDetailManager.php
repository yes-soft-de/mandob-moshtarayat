<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\OrderDetailEntity;
use App\Repository\OrderDetailEntityRepository;
use App\Request\OrderUpdateInvoiceByCaptainRequest;
use App\Request\OrderUpdateProductCountByClientRequest;
use App\Request\OrderUpdateStateByOrderStateRequest;
use App\Request\OrderUpdateStateForEachStoreByCaptainRequest;
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

    public function getStoreOwnerProfileIdAndOrderIDByOrderNumber($orderNumber)
    {
       return $this->orderDetailEntityRepository->getStoreOwnerProfileIdAndOrderIDByOrderNumber($orderNumber);
    }

    public function getProductsByOrderNumberAndStoreID($orderNumber, $storeOwnerProfileID)
    {
       return $this->orderDetailEntityRepository->getProductsByOrderNumberAndStoreID($orderNumber, $storeOwnerProfileID);
    }

    public function getTotalProductsPriceByOrderNumberAndStoreIDForStoreOrders($orderNumber, $storeOwnerProfileID)
    {
       return $this->orderDetailEntityRepository->getTotalProductsPriceByOrderNumberAndStoreIDForStoreOrders($orderNumber, $storeOwnerProfileID);
    }

    public function getStoreOwnerProfileByOrderNumber($orderNumber)
    {
       return $this->orderDetailEntityRepository->getStoreOwnerProfileByOrderNumber($orderNumber);
    }

    public function getOrderIdWithOutStoreProductByOrderNumber($orderNumber)
    {
       return $this->orderDetailEntityRepository->getOrderIdWithOutStoreProductByOrderNumber($orderNumber);
    }

    public function getOrderId($orderNumber)
    {
       return $this->orderDetailEntityRepository->getOrderId($orderNumber);
    }

    public function getStoreOrderInSpecificDate($fromDate, $toDate)
    {
       return $this->orderDetailEntityRepository->getStoreOrderInSpecificDate($fromDate, $toDate);
    }

    public function getOrderDetailId($orderNumber)
    {
       return $this->orderDetailEntityRepository->getOrderId($orderNumber);
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

    public function orderUpdateInvoiceByCaptain(OrderUpdateInvoiceByCaptainRequest $request)
    {
        $item = $this->orderDetailEntityRepository->find($request->getOrderDetailID());

        if ($item) {
            $item = $this->autoMapping->mapToObject(OrderUpdateInvoiceByCaptainRequest::class, OrderDetailEntity::class, $request, $item);

            $this->entityManager->flush();

            return $item;
        }
    }

    public function UpdateProductCount(OrderUpdateProductCountByClientRequest $request)
    {
        $item = $this->orderDetailEntityRepository->orderDetailByProductIdAndOrderNumber($request->getProductId(), $request->getOrderNumber());

        if ($item) {
            $item = $this->autoMapping->mapToObject(OrderUpdateProductCountByClientRequest::class, OrderDetailEntity::class, $request, $item);

            $this->entityManager->flush();

            return $item;
        }
    }

    public function getOrderDetailsByOrderNumberAndStoreProfileID($orderNumber, $storeOwnerProfileID)
    {
        return $this->orderDetailEntityRepository->getOrderDetailsByOrderNumberAndStoreProfileID($orderNumber, $storeOwnerProfileID);
    }

    public function getOrderDetailStates($orderNumber)
    {
        return $this->orderDetailEntityRepository->getOrderDetailStates($orderNumber);
    }

    public function getOrderIds($storeOwnerProfileId)
    {
        return $this->orderDetailEntityRepository->getOrderIds($storeOwnerProfileId);
    }

    public function getOrderIdsForCompletedOrders($storeOwnerProfileId)
    {
        return $this->orderDetailEntityRepository->getOrderIdsForCompletedOrders($storeOwnerProfileId);
    }

    public function getOrderIdsForOngoingOrders($storeOwnerProfileId)
    {
        return $this->orderDetailEntityRepository->getOrderIdsForOngoingOrders($storeOwnerProfileId);
    }

    public function getStorePendingOrders($storeOwnerProfileId)
    {
        return $this->orderDetailEntityRepository->getStorePendingOrders($storeOwnerProfileId);
    }

    public function getStoreOrders($storeOwnerProfileId)
    {
        return $this->orderDetailEntityRepository->getStoreOrders($storeOwnerProfileId);
    }

    public function getStoreOrdersInSpecificDate($fromDate, $toDate, $storeOwnerProfileID)
    {
        return $this->orderDetailEntityRepository->getStoreOrdersInSpecificDate($fromDate, $toDate, $storeOwnerProfileID);
    }

    public function getOrderDetailsByOrderNumberForStore($orderNumber, $storeOwnerProfileID)
    {
        return $this->orderDetailEntityRepository->getOrderDetailsByOrderNumberForStore($orderNumber, $storeOwnerProfileID);
    }

    public function getStoreOrdersOngoingForStoreOwner($storeOwnerProfileId)
    {
        return $this->orderDetailEntityRepository->getStoreOrdersOngoingForStoreOwner($storeOwnerProfileId);
    }

    public function orderUpdateStateForEachStore(OrderUpdateStateForEachStoreByCaptainRequest $request)
    {
        $item = $this->orderDetailEntityRepository->find($request->getId());

        if ($item) {
            $item = $this->autoMapping->mapToObject(OrderUpdateStateForEachStoreByCaptainRequest::class, OrderDetailEntity::class, $request, $item);

            $this->entityManager->flush();

            return $item;
        }
    }

    public function orderUpdateStateByOrderState(OrderUpdateStateByOrderStateRequest $request)
    {
        $item = $this->orderDetailEntityRepository->find($request->getId());
        if ($item) {
            $item = $this->autoMapping->mapToObject(OrderUpdateStateByOrderStateRequest::class, OrderDetailEntity::class, $request, $item);

            $this->entityManager->flush();

            return $item;
        }
    }
}
