<?php

namespace App\Repository;

use App\Constant\OrderStateConstant;
use App\Constant\PaymentStatusConstant;
use App\Constant\ResponseConstant;
use App\Entity\OrderEntity;
use App\Entity\CaptainProfileEntity;
use App\Entity\OrdersInvoicesEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\ClientProfileEntity;
use App\Entity\OrderDetailEntity;
use App\Entity\DeliveryCompanyFinancialCompensationEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;

/**
 * @method OrderEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method OrderEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method OrderEntity[]    findAll()
 * @method OrderEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class OrderEntityRepository extends ServiceEntityRepository
{
    const PENDING="pending";
    const ONGOING="ongoing";
    const CANCEL="cancelled";
    const DELIVERED="delivered";
    const ON_WAY="on way to pick order";
    const IN_STORE="in store";
    const PICKED="picked";

    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, OrderEntity::class);
    }
    
    public function orderById($orderId)
    {
        return $this->createQueryBuilder('OrderEntity')

            ->addSelect('OrderEntity.id', 'OrderEntity.storeOwnerProfileID', 'OrderEntity.source', 'OrderEntity.destination', 'OrderEntity.deliveryDate', 'OrderEntity.updatedAt','OrderEntity.note', 'OrderEntity.payment', 'OrderEntity.recipientName', 'OrderEntity.recipientPhone', 'OrderEntity.state', 'OrderEntity.branchId', 'OrderEntity.roomID','OrderEntity.captainID', 'OrderEntity.createdAt','OrderEntity.productID')

            ->andWhere('OrderEntity.id = :id')

            ->setParameter('id', $orderId)

            ->getQuery()
            ->getResult();
    }

    public function orderStatusByOrderId($orderId)
    {
        return $this->createQueryBuilder('OrderEntity')

            ->select('OrderEntity.id', 'OrderEntity.source', 'OrderEntity.destination', 'OrderEntity.deliveryDate', 'OrderEntity.updatedAt', 'OrderEntity.note', 'OrderEntity.payment', 'OrderEntity.recipientName', 'OrderEntity.recipientPhone', 'OrderEntity.state', 'OrderEntity.roomID', 'OrderEntity.captainID', 'OrderEntity.createdAt', 'OrderEntity.detail','OrderEntity.deliveryCost', 'OrderEntity.orderCost', 'OrderEntity.orderType', 'OrderEntity.clientID', 'OrderEntity.billPdf')

            ->andWhere('OrderEntity.id = :orderId')

            ->setParameter('orderId', $orderId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function closestOrders()
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('OrderEntity.id', 'OrderEntity.deliveryDate', 'OrderEntity.createdAt', 'OrderEntity.payment', 'OrderEntity.detail', 'OrderEntity.deliveryCost', 'OrderEntity.orderCost', 'OrderEntity.orderType', 'OrderEntity.note')
            ->addSelect('orderDetailEntity.id as orderDetailId', 'orderDetailEntity.orderNumber')

            ->leftJoin(OrderDetailEntity::class, 'orderDetailEntity', Join::WITH, 'orderDetailEntity.orderID = OrderEntity.id')

            ->andWhere('OrderEntity.state = :pending ')

            ->setParameter('pending', OrderStateConstant::$ORDER_STATE_PENDING)

            ->addGroupBy('OrderEntity.id')

            ->getQuery()
            ->getResult();
    }

    public function orderStateUpdateByPayInfo($orderNumber)
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('OrderEntity.id')

            ->leftJoin(OrderDetailEntity::class, 'orderDetailEntity', Join::WITH, 'orderDetailEntity.orderID = OrderEntity.id')

            ->andWhere('OrderEntity.payment = :payment ')
            ->andWhere('orderDetailEntity.orderNumber = :orderNumber ')

            ->setParameter('payment', PaymentStatusConstant::$PAYMENT_STATE_CARD)
            ->setParameter('orderNumber', $orderNumber)

            ->addGroupBy('OrderEntity.id')

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getPendingOrders()
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('OrderEntity.id', 'OrderEntity.deliveryDate', 'OrderEntity.createdAt', 'OrderEntity.payment', 'OrderEntity.detail', 'OrderEntity.deliveryCost', 'OrderEntity.orderCost', 'OrderEntity.orderType', 'OrderEntity.note', 'OrderEntity.state')
            ->addSelect('orderDetailEntity.id as orderDetailId', 'orderDetailEntity.orderNumber')

            ->leftJoin(OrderDetailEntity::class, 'orderDetailEntity', Join::WITH, 'orderDetailEntity.orderID = OrderEntity.id')

            ->andWhere('OrderEntity.state = :pending ')

            ->setParameter('pending', OrderStateConstant::$ORDER_STATE_PENDING)

            ->addGroupBy('OrderEntity.id')

            ->getQuery()
            ->getResult();
    }
    public function countAllOrders()
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('count(OrderEntity.id) as ordersCount') 

            ->andWhere("OrderEntity.state != :cancelled")

            ->setParameter('cancelled', OrderStateConstant::$ORDER_STATE_CANCEL)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function countpendingOrders()
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('count(OrderEntity.id) as countpendingOrders')

            ->andWhere("OrderEntity.state = :pending ")

            ->setParameter('pending', OrderStateConstant::$ORDER_STATE_PENDING)

            ->getQuery()
            ->getOneOrNullResult();
    }
    
    public function countOngoingOrders()
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('count(OrderEntity.id) as count')

            ->where("OrderEntity.state = :on_way ")
            ->orWhere("OrderEntity.state = :in_store ")
            ->orWhere("OrderEntity.state = :picked ")
            ->orWhere("OrderEntity.state = :ongoing ")

            ->setParameter('on_way', OrderStateConstant::$ORDER_STATE_ON_WAY)
            ->setParameter('in_store', OrderStateConstant::$ORDER_STATE_IN_STORE)
            ->setParameter('picked', OrderStateConstant::$ORDER_STATE_PICKED)
            ->setParameter('ongoing', OrderStateConstant::$ORDER_STATE_ONGOING)

            ->getQuery()
            ->getSingleScalarResult();
    }

    public function countOngoingOrdersForStoreOwner($ids)
    {
        return $this->createQueryBuilder('OrderEntity')

            ->select('count(OrderEntity.id) as count')

            ->andWhere("OrderEntity.id IN (:id)")
            ->andWhere("OrderEntity.state != :pending")
            ->andWhere("OrderEntity.state != :cancel")
            ->andWhere("OrderEntity.state != :delivered")
            ->andWhere("OrderEntity.state != :notPaid")

            ->setParameter('pending', OrderStateConstant::$ORDER_STATE_PENDING)
            ->setParameter('cancel', OrderStateConstant::$ORDER_STATE_CANCEL)
            ->setParameter('delivered', OrderStateConstant::$ORDER_STATE_DELIVERED)
            ->setParameter('notPaid', OrderStateConstant::$ORDER_STATE_NOT_PAID)
            ->setParameter('id', $ids)

            ->getQuery()

            ->getSingleScalarResult();
    }

    public function countCancelledOrders()
    {
        return $this->createQueryBuilder('OrderEntity')

            ->select('count(OrderEntity.id) as countCancelledOrders')

            ->andWhere("OrderEntity.state = :cancelled ") 

            ->setParameter('cancelled', OrderStateConstant::$ORDER_STATE_CANCEL)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function ongoingOrders()
    {
        return $this->createQueryBuilder('OrderEntity')

            ->addSelect('OrderEntity.id', 'OrderEntity.ownerID', 'OrderEntity.source', 'OrderEntity.destination', 'OrderEntity.deliveryDate', 'OrderEntity.updatedAt', 'OrderEntity.note', 'OrderEntity.payment', 'OrderEntity.recipientName', 'OrderEntity.recipientPhone', 'OrderEntity.state','OrderEntity.branchId', 'OrderEntity.createdAt', 'captainProfileEntity.captainName', 'captainProfileEntity.car', 'captainProfileEntity.image', 'StoreOwnerProfileEntity.storeOwnerName','captainProfileEntity.specialLink')
           
            ->leftJoin(CaptainProfileEntity::class, 'captainProfileEntity', Join::WITH, 'OrderEntity.captainID = captainProfileEntity.captainID')
            ->leftJoin(StoreOwnerProfileEntity::class, 'StoreOwnerProfileEntity', Join::WITH, 'StoreOwnerProfileEntity.storeOwnerID = OrderEntity.ownerID')

            ->andWhere("OrderEntity.state = :ongoing ")

            ->setParameter('ongoing', self::ONGOING)

            ->getQuery()
            ->getResult();
    }

    public function getAcceptedOrderByCaptainId($captainID)
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('OrderEntity.id', 'OrderEntity.deliveryDate', 'OrderEntity.createdAt', 'OrderEntity.payment', 'OrderEntity.detail', 'OrderEntity.deliveryCost', 'OrderEntity.orderCost', 'OrderEntity.orderType', 'OrderEntity.note', 'OrderEntity.state')
            ->addSelect('orderDetailEntity.id as orderDetailId', 'orderDetailEntity.orderNumber')

            ->leftJoin(OrderDetailEntity::class, 'orderDetailEntity', Join::WITH, 'orderDetailEntity.orderID = OrderEntity.id')

            ->andWhere('OrderEntity.state != :delivered ')
            ->andWhere('OrderEntity.captainID = :captainID ')

            ->setParameter('delivered', OrderStateConstant::$ORDER_STATE_DELIVERED)
            ->setParameter('captainID', $captainID)

            ->addGroupBy('OrderEntity.id')

            ->getQuery()
            ->getResult();
    }

    public function getLogsForCaptain($CaptainId)
    {
        return $this->createQueryBuilder('OrderEntity')
        
            ->select('OrderEntity.id', 'OrderEntity.ownerID', 'OrderEntity.source', 'OrderEntity.destination', 'OrderEntity.deliveryDate as orderDate', 'OrderEntity.updatedAt as updateOrderDate', 'OrderEntity.note', 'OrderEntity.payment', 'OrderEntity.recipientName', 'OrderEntity.recipientPhone', 'OrderEntity.state', 'OrderEntity.branchId','branchesEntity.location','branchesEntity.branchName','branchesEntity.city as branchCity', 'OrderEntity.createdAt') 



            ->setParameter('CaptainId', $CaptainId)

            ->getQuery()
            ->getResult();
    }

    public function getOrdersWithOutPending()
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('OrderEntity.id', 'OrderEntity.deliveryDate', 'OrderEntity.createdAt', 'OrderEntity.payment', 'OrderEntity.detail', 'OrderEntity.deliveryCost', 'OrderEntity.orderCost', 'OrderEntity.orderType', 'OrderEntity.note', 'OrderEntity.state')
            ->addSelect('orderDetailEntity.id as orderDetailId', 'orderDetailEntity.orderNumber')

            ->leftJoin(OrderDetailEntity::class, 'orderDetailEntity', Join::WITH, 'orderDetailEntity.orderID = OrderEntity.id')

            ->andWhere('OrderEntity.state != :pending ')
            ->andWhere('OrderEntity.state != :notPaid ')

            ->setParameter('pending', OrderStateConstant::$ORDER_STATE_PENDING)
            ->setParameter('notPaid', OrderStateConstant::$ORDER_STATE_NOT_PAID)

            ->addGroupBy('OrderEntity.id')

            ->getQuery()
            ->getResult();
    }

    public function getOrdersOngoing()
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('OrderEntity.id', 'OrderEntity.deliveryDate', 'OrderEntity.createdAt', 'OrderEntity.payment', 'OrderEntity.detail', 'OrderEntity.deliveryCost', 'OrderEntity.orderCost', 'OrderEntity.orderType', 'OrderEntity.note', 'OrderEntity.state')
            ->addSelect('orderDetailEntity.id as orderDetailId', 'orderDetailEntity.orderNumber')

            ->leftJoin(OrderDetailEntity::class, 'orderDetailEntity', Join::WITH, 'orderDetailEntity.orderID = OrderEntity.id')

            ->andWhere('OrderEntity.state != :pending')
            ->andWhere('OrderEntity.state != :delivered')
            ->andWhere('OrderEntity.state != :cancel')
            ->andWhere('OrderEntity.state != :notPaid')

            ->setParameter('pending', OrderStateConstant::$ORDER_STATE_PENDING)
            ->setParameter('delivered', OrderStateConstant::$ORDER_STATE_DELIVERED)
            ->setParameter('notPaid', OrderStateConstant::$ORDER_STATE_NOT_PAID)
            ->setParameter('cancel', OrderStateConstant::$ORDER_STATE_CANCEL)

            ->addGroupBy('OrderEntity.id')

            ->getQuery()
            ->getResult();
    }

    public function countOrdersInMonthForOwner($fromDate, $toDate, $ownerId)
    {
        return $this->createQueryBuilder('OrderEntity')

            ->select('count(OrderEntity.id) as countOrdersInMonth')

            ->where('OrderEntity.deliveryDate >= :fromDate')
            ->andWhere('OrderEntity.deliveryDate < :toDate')
            ->andWhere('OrderEntity.ownerID = :ownerId')

            ->setParameter('fromDate', $fromDate)
            ->setParameter('toDate', $toDate)

            ->andWhere("OrderEntity.state != :cancelled")

            ->setParameter('ownerId', $ownerId)
            ->setParameter('cancelled', OrderStateConstant::$ORDER_STATE_CANCEL)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getOrdersInMonthForOwner($fromDate, $toDate, $ownerId)
    {
        return $this->createQueryBuilder('OrderEntity')

          ->select('OrderEntity.id', 'OrderEntity.ownerID', 'OrderEntity.source', 'OrderEntity.destination', 'OrderEntity.deliveryDate', 'OrderEntity.note', 'OrderEntity.payment', 'OrderEntity.recipientName', 'OrderEntity.recipientPhone', 'OrderEntity.state', 'OrderEntity.branchId', 'OrderEntity.roomID', 'userProfileEntity.storeOwnerName as userName', 'OrderEntity.captainID', 'OrderEntity.createdAt', 'OrderEntity.productID')

          ->andWhere("OrderEntity.state != cancelled")
          ->where('OrderEntity.deliveryDate >= :fromDate')
          ->andWhere('OrderEntity.deliveryDate < :toDate')
          ->andWhere('OrderEntity.ownerID = :ownerId')

          ->leftJoin(StoreOwnerProfileEntity::class, 'userProfileEntity', Join::WITH, 'userProfileEntity.storeOwnerID = :ownerId')
        
          ->setParameter('fromDate', $fromDate)
          ->setParameter('toDate', $toDate)
          ->setParameter('ownerId', $ownerId)
          ->setParameter('cancelled', OrderStateConstant::$ORDER_STATE_CANCEL)

          ->getQuery()
          ->getResult(); 
    }

    public function getOrdersInSpecificDate($fromDate, $toDate)
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('OrderEntity.id', 'OrderEntity.deliveryDate', 'OrderEntity.createdAt', 'OrderEntity.payment', 'OrderEntity.detail', 'OrderEntity.deliveryCost', 'OrderEntity.orderCost', 'OrderEntity.orderType', 'OrderEntity.note', 'OrderEntity.state')
            ->addSelect('orderDetailEntity.id as orderDetailId', 'orderDetailEntity.orderNumber')

            ->leftJoin(OrderDetailEntity::class, 'orderDetailEntity', Join::WITH, 'orderDetailEntity.orderID = OrderEntity.id')

            ->andWhere('OrderEntity.state != :cancelled ')
            ->andWhere('OrderEntity.state != :notPaid ')
            ->andWhere('OrderEntity.deliveryDate >= :fromDate')
            ->andWhere('OrderEntity.deliveryDate < :toDate')

            ->setParameter('notPaid', OrderStateConstant::$ORDER_STATE_NOT_PAID)
            ->setParameter('cancelled', OrderStateConstant::$ORDER_STATE_CANCEL)
            ->setParameter('fromDate', $fromDate)
            ->setParameter('toDate', $toDate)

            ->addGroupBy('OrderEntity.id')

            ->getQuery()
            ->getResult();
    }

    public function getCountOrdersEveryStoreInLastMonth($fromDate, $toDate)
    {
        return $this->createQueryBuilder('OrderEntity')
          ->select('OrderEntity.storeOwnerProfileID', 'count(OrderEntity.storeOwnerProfileID) as countOrdersInMonth')
          ->addSelect('StoreOwnerProfileEntity.storeOwnerName', 'StoreOwnerProfileEntity.image')

          ->leftJoin(StoreOwnerProfileEntity::class, 'StoreOwnerProfileEntity', Join::WITH, 'StoreOwnerProfileEntity.id = OrderEntity.storeOwnerProfileID')
        
          ->where('OrderEntity.createdAt >= :fromDate')
          ->andWhere('OrderEntity.createdAt < :toDate')
          ->andWhere("OrderEntity.state != :cancelled")
          ->andWhere("OrderEntity.state != :pending")

          ->addGroupBy('OrderEntity.storeOwnerProfileID')

          ->having('count(OrderEntity.storeOwnerProfileID) > 0')

          ->setMaxResults(15)

          ->addOrderBy('countOrdersInMonth','DESC')
         
          ->setParameter('fromDate', $fromDate)
          ->setParameter('toDate', $toDate)
          ->setParameter('cancelled', OrderStateConstant::$ORDER_STATE_CANCEL)
          ->setParameter('pending', OrderStateConstant::$ORDER_STATE_PENDING)

          ->getQuery()
          ->getResult();
    }
    
    public function getCountOrdersEveryCaptainInLastMonth($fromDate, $toDate)
    {
        return $this->createQueryBuilder('OrderEntity')
          ->select('OrderEntity.captainID', 'count(OrderEntity.captainID) as countOrdersInMonth')
          ->addSelect('CaptainProfileEntity.captainName', 'CaptainProfileEntity.image')

          ->leftJoin(CaptainProfileEntity::class, 'CaptainProfileEntity', Join::WITH, 'CaptainProfileEntity.captainID = OrderEntity.captainID')
        
          ->where('OrderEntity.createdAt >= :fromDate')
          ->andWhere('OrderEntity.createdAt < :toDate')
          ->andWhere("OrderEntity.state != :cancelled")
          ->andWhere("OrderEntity.state != :pending")

          ->addGroupBy('OrderEntity.captainID')

          ->having('count(OrderEntity.captainID) > 0')

          ->setMaxResults(15)

          ->addOrderBy('countOrdersInMonth','DESC')
         
          ->setParameter('fromDate', $fromDate)
          ->setParameter('toDate', $toDate)
          ->setParameter('cancelled', self::CANCEL)
          ->setParameter('pending', self::PENDING)

          ->getQuery()
          ->getResult();
    }
    
    public function getCountOrdersEveryClientInLastMonth($fromDate, $toDate)
    {
        return $this->createQueryBuilder('OrderEntity')
          ->select('OrderEntity.clientID', 'count(OrderEntity.clientID) as countOrdersInMonth')
          ->addSelect('ClientProfileEntity.clientName', 'ClientProfileEntity.image')

          ->leftJoin(ClientProfileEntity::class, 'ClientProfileEntity', Join::WITH, 'ClientProfileEntity.clientID = OrderEntity.clientID')
        
          ->where('OrderEntity.createdAt >= :fromDate')
          ->andWhere('OrderEntity.createdAt < :toDate')
          ->andWhere("OrderEntity.state != :cancelled")
          ->andWhere("OrderEntity.state != :pending")

          ->addGroupBy('OrderEntity.clientID')

          ->having('count(OrderEntity.clientID) > 0')

          ->setMaxResults(15)

          ->addOrderBy('countOrdersInMonth','DESC')
         
          ->setParameter('fromDate', $fromDate)
          ->setParameter('toDate', $toDate)
          ->setParameter('cancelled', self::CANCEL)
          ->setParameter('pending', self::PENDING)

          ->getQuery()
          ->getResult();
    }
    
    public function countOrdersInDay($ownerID, $fromDate, $toDate)
    {
        return $this->createQueryBuilder('OrderEntity')

          ->select('SUBSTRING(OrderEntity.deliveryDate, 1, 10) as myDate', 'OrderEntity.deliveryDate', 'count(OrderEntity.id) as countOrdersInDay', 'OrderEntity.productID')
        
          ->andWhere('OrderEntity.ownerID = :ownerID') 
          ->andWhere("OrderEntity.state != :cancelled")
          ->andWhere('OrderEntity.deliveryDate >= :fromDate')
          ->andWhere('OrderEntity.deliveryDate < :toDate')

          ->addGroupBy('OrderEntity.ownerID')
          ->addGroupBy('myDate')
          
          ->having('count(OrderEntity.id) > 0')
       
          ->addOrderBy('countOrdersInDay','DESC')

          ->setParameter('ownerID', $ownerID)
          ->setParameter('fromDate', $fromDate)
          ->setParameter('toDate', $toDate)
          ->setParameter('cancelled', self::CANCEL)
          
          ->getQuery()
          ->getResult();
    }

    public function countOrdersInToday($fromDate, $toDate)
    {
        return $this->createQueryBuilder('OrderEntity')

          ->select('count(OrderEntity.id) as countOrdersInToday')
        
          ->andWhere("OrderEntity.state != :cancelled")
          ->andWhere('OrderEntity.createdAt >= :fromDate')
          ->andWhere('OrderEntity.createdAt < :toDate')
          ->andWhere('OrderEntity.state != :notPaid')

          ->setParameter('fromDate', $fromDate)
          ->setParameter('toDate', $toDate)
          ->setParameter('cancelled', OrderStateConstant::$ORDER_STATE_CANCEL)
          ->setParameter('notPaid', OrderStateConstant::$ORDER_STATE_NOT_PAID)

          ->getQuery()
          ->getSingleScalarResult();
    }

    public function countOrdersInTodayForStoreOwner($fromDate, $toDate, $ids)
    {
        return $this->createQueryBuilder('OrderEntity')

            ->select('count(OrderEntity.id) as count')

            ->where("OrderEntity.id IN (:id)")
            ->andWhere("OrderEntity.state != :cancelled")
            ->andWhere('OrderEntity.createdAt >= :fromDate')
            ->andWhere('OrderEntity.createdAt < :toDate')
            ->andWhere("OrderEntity.state != :notPaid")

            ->setParameter('fromDate', $fromDate)
            ->setParameter('toDate', $toDate)
            ->setParameter('cancelled', OrderStateConstant::$ORDER_STATE_CANCEL)
            ->setParameter('notPaid', OrderStateConstant::$ORDER_STATE_NOT_PAID)
            ->setParameter('id', $ids)

            ->getQuery()

            ->getSingleScalarResult();
    }

    public function countCaptainOrdersDelivered($captainId)
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('count(OrderEntity.id) as countOrdersDelivered', 'sum(OrderEntity.deliveryCost) as deliveryCost' )

            ->andWhere('OrderEntity.captainID = :captainId')
            ->andWhere("OrderEntity.state = :delivered")

            ->setParameter('captainId', $captainId)
            ->setParameter('delivered', OrderStateConstant::$ORDER_STATE_DELIVERED)

            ->getQuery()
            ->getResult();
    }

    public function sumInvoiceAmountWithoutOrderTypeSendIt($captainId)
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('sum(ordersInvoicesEntity.invoiceAmount) as sumInvoiceAmount')

            ->leftJoin(OrderDetailEntity::class, 'orderDetailEntity', Join::WITH, 'orderDetailEntity.orderID = OrderEntity.id')
            ->leftJoin(OrdersInvoicesEntity::class, 'ordersInvoicesEntity', Join::WITH, 'ordersInvoicesEntity.id = orderDetailEntity.orderInvoiceId')

            ->andWhere('OrderEntity.captainID = :captainId')
            ->andWhere("OrderEntity.state = :delivered")

            ->andWhere("OrderEntity.isBillCalculated = :true")

            ->setParameter('true', 1)
            ->setParameter('captainId', $captainId)
            ->setParameter('delivered', OrderStateConstant::$ORDER_STATE_DELIVERED)

            ->getQuery()
            ->getSingleScalarResult();
    }

    public function sumOrderCostByCaptainID($captainId)
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('sum(OrderEntity.orderCost) as orderCost')

            ->andWhere('OrderEntity.captainID = :captainId')
            ->andWhere("OrderEntity.state = :delivered")
            ->andWhere("OrderEntity.payment != :card")

            ->andWhere("OrderEntity.isBillCalculated = :true")

            ->setParameter('true', 1)
            ->setParameter('card', PaymentStatusConstant::$PAYMENT_STATE_CARD)
            ->setParameter('captainId', $captainId)
            ->setParameter('delivered', OrderStateConstant::$ORDER_STATE_DELIVERED)

            ->getQuery()
            ->getSingleScalarResult();
    }

    public function sumOrderCost()
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('sum(OrderEntity.orderCost) as orderCost')

            ->andWhere("OrderEntity.state = :delivered")
            ->andWhere("OrderEntity.isBillCalculated = :true")
            ->andWhere("OrderEntity.payment != :card")


            ->setParameter('true', 1)
            ->setParameter('delivered', OrderStateConstant::$ORDER_STATE_DELIVERED)
            ->setParameter('card', PaymentStatusConstant::$PAYMENT_STATE_CARD)

            ->getQuery()
            ->getSingleScalarResult();
    }

    public function getInvoicesIDs($captainId)
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('orderDetailEntity.orderInvoiceId')

            ->leftJoin(OrderDetailEntity::class, 'orderDetailEntity', Join::WITH, 'orderDetailEntity.orderID = OrderEntity.id')

            ->andWhere('OrderEntity.captainID = :captainId')
            ->andWhere("OrderEntity.state = :delivered")

            ->andWhere("OrderEntity.isBillCalculated = :true")

            ->setParameter('true', 1)
            ->setParameter('captainId', $captainId)
            ->setParameter('delivered', OrderStateConstant::$ORDER_STATE_DELIVERED)

            ->groupBy('orderDetailEntity.storeOwnerProfileID')

            ->getQuery()
            ->getResult();
    }

    public function getInvoicesIDsInSpecificDate($fromDate, $toDate, $captainId)
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('orderDetailEntity.orderInvoiceId')

            ->leftJoin(OrderDetailEntity::class, 'orderDetailEntity', Join::WITH, 'orderDetailEntity.orderID = OrderEntity.id')

            ->andWhere('OrderEntity.captainID = :captainId')
            ->andWhere("OrderEntity.state = :delivered")
            ->andWhere('OrderEntity.createdAt >= :fromDate')
            ->andWhere('OrderEntity.createdAt < :toDate')
            ->andWhere("OrderEntity.isBillCalculated = :true")

            ->setParameter('true', 1)
            ->setParameter('captainId', $captainId)
            ->setParameter('delivered', OrderStateConstant::$ORDER_STATE_DELIVERED)
            ->setParameter('fromDate', $fromDate)
            ->setParameter('toDate', $toDate)

            ->getQuery()
            ->getResult();
    }

    public function sumDeliveryCostAmount()
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('sum(OrderEntity.deliveryCost) as deliveryCost' )

            ->andWhere("OrderEntity.state = :delivered")

            ->setParameter('delivered', OrderStateConstant::$ORDER_STATE_DELIVERED)

            ->getQuery()
            ->getSingleScalarResult();
    }

    public function sumFinancialSumInvoiceAmount()
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('sum(ordersInvoicesEntity.invoiceAmount) as invoiceAmount' )

            ->leftJoin(OrderDetailEntity::class, 'orderDetailEntity', Join::WITH, 'orderDetailEntity.orderID = OrderEntity.id')
            ->leftJoin(OrdersInvoicesEntity::class, 'ordersInvoicesEntity', Join::WITH, 'ordersInvoicesEntity.id = orderDetailEntity.orderInvoiceId')

            ->andWhere("OrderEntity.state = :delivered")

            ->setParameter('delivered', OrderStateConstant::$ORDER_STATE_DELIVERED)

            ->getQuery()
            ->getSingleScalarResult();
    }

    public function captainOrdersDelivered($captainId)
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('OrderEntity.id', 'OrderEntity.invoiceAmount', 'OrderEntity.deliveryCost', 'OrderEntity.deliveryDate')

            ->andWhere('OrderEntity.captainID = :captainId')
            ->andWhere("OrderEntity.state = :delivered")

            ->setParameter('captainId', $captainId)
            ->setParameter('delivered', self::DELIVERED)

            ->getQuery()
            ->getResult();
    }

    public function sumOrderCostByCaptainIDInSpecificDate($fromDate, $toDate, $captainId)
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('sum(OrderEntity.orderCost) as orderCost')

            ->where('OrderEntity.deliveryDate >= :fromDate')
            ->andWhere('OrderEntity.deliveryDate < :toDate')
            ->andWhere('OrderEntity.captainID = :captainId')
            ->andWhere("OrderEntity.state = :delivered")
            ->andWhere("OrderEntity.isBillCalculated = :true")
            ->andWhere("OrderEntity.payment != :card")

            ->setParameter('true', 1)
            ->setParameter('captainId', $captainId)
            ->setParameter('delivered', OrderStateConstant::$ORDER_STATE_DELIVERED)
            ->setParameter('fromDate', $fromDate)
            ->setParameter('toDate', $toDate)
            ->setParameter('card', PaymentStatusConstant::$PAYMENT_STATE_CARD)

            ->getQuery()
            ->getSingleScalarResult();
    }

    public function countOrdersInMonthForCaptain($fromDate, $toDate, $captainId)
    {
        return $this->createQueryBuilder('OrderEntity')

            ->select('count(OrderEntity.id) as countOrdersInMonth', 'sum(OrderEntity.deliveryCost) as deliveryCost')

            ->where('OrderEntity.deliveryDate >= :fromDate')
            ->andWhere('OrderEntity.deliveryDate < :toDate')
            ->andWhere('OrderEntity.captainID = :captainId')
            ->andWhere("OrderEntity.state = :delivered")

            ->setParameter('fromDate', $fromDate)
            ->setParameter('toDate', $toDate)
            ->setParameter('captainId', $captainId)
            ->setParameter('delivered', self::DELIVERED)

            ->getQuery()
            ->getResult();
    }


    public function sumInvoiceAmountWithoutOrderTypeSendItInMonthForCaptain($fromDate, $toDate, $captainId)
    {
        return $this->createQueryBuilder('OrderEntity')
                ->select('sum(ordersInvoicesEntity.invoiceAmount) as sumInvoiceAmount' )

                ->leftJoin(OrderDetailEntity::class, 'orderDetailEntity', Join::WITH, 'orderDetailEntity.orderID = OrderEntity.id')
                ->leftJoin(OrdersInvoicesEntity::class, 'ordersInvoicesEntity', Join::WITH, 'ordersInvoicesEntity.id = orderDetailEntity.orderInvoiceId')

                ->where('OrderEntity.deliveryDate >= :fromDate')
                ->andWhere('OrderEntity.deliveryDate < :toDate')
                ->andWhere('OrderEntity.captainID = :captainId')
                ->andWhere("OrderEntity.state = :delivered")
                ->andWhere("OrderEntity.isBillCalculated = :true")

                ->setParameter('fromDate', $fromDate)
                ->setParameter('toDate', $toDate)
                ->setParameter('true', 1)
                ->setParameter('captainId', $captainId)
                ->setParameter('delivered', OrderStateConstant::$ORDER_STATE_DELIVERED)

                ->getQuery()
                ->getResult();
    }

    public function getAcceptedOrderByCaptainIdInMonth($fromDate, $toDate, $captainId)
    {
        return $this->createQueryBuilder('OrderEntity')

            ->select('OrderEntity.id')

            ->where('OrderEntity.deliveryDate >= :fromDate')
            ->andWhere('OrderEntity.deliveryDate < :toDate')
            ->andWhere('OrderEntity.captainID = :captainId')

            ->setParameter('fromDate', $fromDate)
            ->setParameter('toDate', $toDate)
            ->setParameter('captainId', $captainId)

            ->getQuery()
            ->getResult();
    }

    public function countCaptainOrdersInDay($captainID, $fromDate, $toDate)
    {
        return $this->createQueryBuilder('OrderEntity')

          ->select('SUBSTRING(OrderEntity.deliveryDate, 1, 10) as myDate', 'OrderEntity.deliveryDate', 'count(OrderEntity.id) as countOrdersInDay')
        
          ->andWhere('OrderEntity.captainID = :captainID') 
          ->andWhere('OrderEntity.deliveryDate >= :fromDate')
          ->andWhere('OrderEntity.deliveryDate < :toDate')

          ->addGroupBy('OrderEntity.captainID')
          ->addGroupBy('myDate')

          ->having('count(OrderEntity.captainID) > 0')
        
          ->addOrderBy('countOrdersInDay','DESC')

          ->setParameter('captainID', $captainID)
          ->setParameter('fromDate', $fromDate)
          ->setParameter('toDate', $toDate)
          
          ->getQuery()
          ->getResult(); 
    }

    public function countOrdersDeliveredInToday($captainID, $todayStart, $todayEnd)
    {
        return $this->createQueryBuilder('OrderEntity')

          ->select('count(OrderEntity.id) as countOrdersDeliveredInToday')
        
          ->andWhere('OrderEntity.captainID = :captainID') 
          ->andWhere('OrderEntity.deliveryDate >= :todayStart')
          ->andWhere('OrderEntity.deliveryDate <= :todayEnd')
          ->andWhere("OrderEntity.state = :delivered")

          ->setParameter('captainID', $captainID)
          ->setParameter('todayStart', $todayStart)
          ->setParameter('todayEnd', $todayEnd)
          ->setParameter('delivered', OrderStateConstant::$ORDER_STATE_DELIVERED)

          ->getQuery()
          ->getOneOrNullResult(); 
    }

    public function getOrdersByClientID($clientID)
    {
        return $this->createQueryBuilder('OrderEntity')

            ->select('OrderEntity.id', 'OrderEntity.deliveryDate', 'OrderEntity.state', 'OrderEntity.createdAt','OrderEntity.deliveryCost', 'OrderEntity.orderCost','OrderEntity.orderType')
            ->addSelect('orderDetailEntity.id as orderDetailId', 'orderDetailEntity.orderNumber')

            ->leftJoin(OrderDetailEntity::class, 'orderDetailEntity', Join::WITH, 'orderDetailEntity.orderID = OrderEntity.id')

            ->andWhere('OrderEntity.clientID = :clientID')
            ->andWhere("OrderEntity.state != :delivered")
            ->andWhere("OrderEntity.state != :cancelled")
            ->andWhere("OrderEntity.state != :notPaid")

            ->setParameter('clientID', $clientID)
            ->setParameter('delivered', OrderStateConstant::$ORDER_STATE_DELIVERED)
            ->setParameter('cancelled', OrderStateConstant::$ORDER_STATE_CANCEL)
            ->setParameter('notPaid', OrderStateConstant::$ORDER_STATE_NOT_PAID)

            ->addGroupBy('OrderEntity.id')

            ->getQuery()
            ->getResult();
    }

    public function getOrdersDeliveredAndCancelledByClientId($clientID)
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('OrderEntity.id', 'OrderEntity.deliveryDate', 'OrderEntity.state', 'OrderEntity.createdAt','OrderEntity.deliveryCost', 'OrderEntity.orderCost','OrderEntity.orderType')
            ->addSelect('orderDetailEntity.id as orderDetailId', 'orderDetailEntity.orderNumber')

            ->leftJoin(OrderDetailEntity::class, 'orderDetailEntity', Join::WITH, 'orderDetailEntity.orderID = OrderEntity.id')

            ->Where('OrderEntity.clientID = :clientID')
            ->andWhere("OrderEntity.state = :delivered or OrderEntity.state = :cancelled")

            ->setParameter('clientID', $clientID)
            ->setParameter('delivered', OrderStateConstant::$ORDER_STATE_DELIVERED)
            ->setParameter('cancelled', OrderStateConstant::$ORDER_STATE_CANCEL)

            ->addGroupBy('OrderEntity.id')

            ->getQuery()
            ->getResult();
    }

    public function getOrderKilometers($captainId)
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id', 'orderEntity.kilometer as orderKilometers')
            ->addSelect('financialCompensationEntity.kilometers', 'financialCompensationEntity.maxKilometerBonus', 'financialCompensationEntity.minKilometerBonus')

            ->join(DeliveryCompanyFinancialCompensationEntity::class, 'financialCompensationEntity')

            ->andWhere('orderEntity.captainID = :captainId')
            ->andWhere("orderEntity.state = :delivered")

            ->setParameter('captainId', $captainId)
            ->setParameter('delivered', self::DELIVERED)

            ->getQuery()
            ->getResult();
    }

    public function getOrderKilometersInThisMonth($captainId, $fromDate, $toDate)
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id', 'orderEntity.kilometer as orderKilometers')
            ->addSelect('financialCompensationEntity.kilometers', 'financialCompensationEntity.maxKilometerBonus', 'financialCompensationEntity.minKilometerBonus')

            ->join(DeliveryCompanyFinancialCompensationEntity::class, 'financialCompensationEntity')

            ->andWhere('orderEntity.captainID = :captainId')
            ->andWhere("orderEntity.state = :delivered")
            ->andWhere('orderEntity.deliveryDate >= :fromDate')
            ->andWhere('orderEntity.deliveryDate < :toDate')

            ->setParameter('fromDate', $fromDate)
            ->setParameter('toDate', $toDate)
            ->setParameter('delivered', self::DELIVERED)

            ->setParameter('captainId', $captainId)

            ->getQuery()
            ->getResult();
    }

    public function countCompletedOrders()
    {
        return  $this->createQueryBuilder('OrderEntity')

                ->select('count(OrderEntity.id) as count')

                ->andWhere("OrderEntity.state = :delivered")

                ->setParameter('delivered', self::DELIVERED)

                ->getQuery()
                ->getSingleScalarResult();
    }

    public function countOrdersForStoreOwner($id)
    {
        return  $this->createQueryBuilder('OrderEntity')

            ->select('count(OrderEntity.id) as count')

            ->andWhere("OrderEntity.id IN (:id)")
            ->setParameter('id', $id)

            ->getQuery()
            ->getSingleScalarResult();
    }

    public function getOrdersForSpecificClient($clientID)
    {
        return $this->createQueryBuilder('OrderEntity')

            ->select('OrderEntity.id', 'OrderEntity.deliveryDate', 'OrderEntity.state', 'OrderEntity.createdAt','OrderEntity.deliveryCost', 'OrderEntity.orderCost','OrderEntity.orderType')
            ->addSelect('orderDetailEntity.id as orderDetailId', 'orderDetailEntity.orderNumber')

            ->leftJoin(OrderDetailEntity::class, 'orderDetailEntity', Join::WITH, 'orderDetailEntity.orderID = OrderEntity.id')

            ->andWhere('OrderEntity.clientID = :clientID')

            ->setParameter('clientID', $clientID)

            ->addGroupBy('OrderEntity.id')

            ->getQuery()
            ->getResult();
    }

    public function clientOrdersCount($clientID)
    {
        return $this->createQueryBuilder('OrderEntity')

            ->select('count(OrderEntity.id) as ordersCount')

            ->andWhere('OrderEntity.clientID = :clientID')

            ->setParameter('clientID', $clientID)

            ->getQuery()
            ->getSingleScalarResult();
    }

    public function clientOrdersCancel($clientID)
    {
        return $this->createQueryBuilder('OrderEntity')

            ->select('count(OrderEntity.id) as ordersCount')

            ->andWhere('OrderEntity.clientID = :clientID')
            ->andWhere("OrderEntity.state = :cancelled")

            ->setParameter('clientID', $clientID)
            ->setParameter('cancelled', self::CANCEL)

            ->getQuery()
            ->getSingleScalarResult();
    }

    public function clientOrdersDelivered($clientID)
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('count(OrderEntity.id) as ordersCount')

            ->andWhere('OrderEntity.clientID = :clientID')
            ->andWhere("OrderEntity.state = :delivered")

            ->setParameter('clientID', $clientID)
            ->setParameter('delivered', self::DELIVERED)

            ->getQuery()
            ->getSingleScalarResult();
    }

    public function countStoreOrders($ids)
    {
        return  $this->createQueryBuilder('OrderEntity')

            ->select('count(OrderEntity.id) as count')

            ->andWhere("OrderEntity.state != :cancelled")
            ->andWhere("OrderEntity.state != :notPaid")
            ->andWhere("OrderEntity.id IN (:id)")

            ->setParameter('cancelled', OrderStateConstant::$ORDER_STATE_CANCEL)
            ->setParameter('notPaid', OrderStateConstant::$ORDER_STATE_NOT_PAID)
            ->setParameter('id', $ids)

            ->getQuery()
            ->getSingleScalarResult();
    }

    public function getOrdersByStoreProfileId($storeProfileId)
    {
        return $this->createQueryBuilder('OrderEntity')

            ->select('OrderEntity.id', 'OrderEntity.deliveryDate', 'OrderEntity.state', 'OrderEntity.createdAt','OrderEntity.deliveryCost', 'OrderEntity.orderCost','OrderEntity.orderType')
            ->addSelect('orderDetailEntity.id as orderDetailId', 'orderDetailEntity.orderNumber')

            ->leftJoin(OrderDetailEntity::class, 'orderDetailEntity', Join::WITH, 'orderDetailEntity.orderID = OrderEntity.id')

            ->andWhere('OrderEntity.storeOwnerProfileID = :storeOwnerProfileID')

            ->setParameter('storeOwnerProfileID', $storeProfileId)

            ->addGroupBy('OrderEntity.id')

            ->getQuery()
            ->getResult();
    }

    public function countCaptainOrders($captainId)
    {
        return $this->createQueryBuilder('OrderEntity')

            ->select('count(OrderEntity.id) as ordersCount')

            ->andWhere('OrderEntity.captainID = :captainID')

            ->setParameter('captainID', $captainId)

            ->getQuery()
            ->getSingleScalarResult();
    }

    public function getOrdersByCaptainId($captainId)
    {
        return $this->createQueryBuilder('OrderEntity')

            ->select('OrderEntity.id', 'OrderEntity.deliveryDate', 'OrderEntity.state', 'OrderEntity.createdAt','OrderEntity.deliveryCost', 'OrderEntity.orderCost','OrderEntity.orderType')
            ->addSelect('orderDetailEntity.id as orderDetailId', 'orderDetailEntity.orderNumber')

            ->leftJoin(OrderDetailEntity::class, 'orderDetailEntity', Join::WITH, 'orderDetailEntity.orderID = OrderEntity.id')

            ->andWhere('OrderEntity.captainID = :captainID')

            ->setParameter('captainID', $captainId)

            ->addGroupBy('OrderEntity.id')

            ->getQuery()
            ->getResult();
    }

    public function getStoreOrdersOngoingForStoreOwner($storeOwnerProfileID)
    {
        return $this->createQueryBuilder('OrderEntity')

            ->select('OrderEntity.id', 'OrderEntity.deliveryDate', 'OrderEntity.createdAt', 'OrderEntity.storeOwnerProfileID', 'OrderEntity.source', 'OrderEntity.payment', 'OrderEntity.detail', 'OrderEntity.deliveryCost', 'OrderEntity.orderCost', 'OrderEntity.orderType', 'OrderEntity.destination', 'OrderEntity.note', 'OrderEntity.state')
            ->addSelect('orderDetailEntity.id as orderDetailId', 'orderDetailEntity.orderNumber')

            ->leftJoin(OrderDetailEntity::class, 'orderDetailEntity', Join::WITH, 'orderDetailEntity.orderID = OrderEntity.id')

            ->andWhere("OrderEntity.storeOwnerProfileID = :storeOwnerProfileID ")
            ->andWhere("OrderEntity.state = :ongoing ")

            ->setParameter('storeOwnerProfileID', $storeOwnerProfileID)
            ->setParameter('ongoing', OrderStateConstant::$ORDER_STATE_ONGOING)

            ->addGroupBy('OrderEntity.id')

            ->getQuery()
            ->getResult();
    }

    public function getStoreOrdersInSpecificDate($fromDate, $toDate, $storeOwnerProfileID)
    {
        return $this->createQueryBuilder('OrderEntity')

            ->select('OrderEntity.id', 'OrderEntity.deliveryDate', 'OrderEntity.createdAt', 'OrderEntity.storeOwnerProfileID', 'OrderEntity.source', 'OrderEntity.payment', 'OrderEntity.detail', 'OrderEntity.deliveryCost', 'OrderEntity.orderCost', 'OrderEntity.orderType', 'OrderEntity.destination', 'OrderEntity.note', 'OrderEntity.state')
            ->addSelect('OrderDetailEntity.id as orderDetailId', 'OrderDetailEntity.orderNumber')

            ->leftJoin(OrderDetailEntity::class, 'OrderDetailEntity', Join::WITH, 'OrderDetailEntity.orderID = OrderEntity.id')

            ->where('OrderEntity.createdAt >= :fromDate')
            ->andWhere('OrderEntity.createdAt < :toDate')
            ->andWhere("OrderEntity.storeOwnerProfileID = :storeOwnerProfileID ")
            ->andWhere("OrderEntity.state != :cancelled")

            ->setParameter('fromDate', $fromDate)
            ->setParameter('storeOwnerProfileID', $storeOwnerProfileID)
            ->setParameter('toDate', $toDate)
            ->setParameter('cancelled', OrderStateConstant::$ORDER_STATE_CANCEL)

            ->addGroupBy('OrderEntity.id')

            ->getQuery()
            ->getResult();
    }

    public function getStoreOrders($storeOwnerProfileID)
    {
        return $this->createQueryBuilder('OrderEntity')

            ->select('OrderEntity.id', 'OrderEntity.deliveryDate', 'OrderEntity.createdAt', 'OrderEntity.detail', 'OrderEntity.orderType', 'OrderEntity.destination', 'OrderEntity.note', 'OrderEntity.state')
            ->addSelect('OrderDetailEntity.id as orderDetailId', 'OrderDetailEntity.orderNumber')

            ->leftJoin(OrderDetailEntity::class, 'OrderDetailEntity', Join::WITH, 'OrderDetailEntity.orderID = OrderEntity.id')

            ->andWhere("OrderEntity.storeOwnerProfileID = :storeOwnerProfileID ")
            ->andWhere("OrderEntity.state != :cancelled")

            ->setParameter('storeOwnerProfileID', $storeOwnerProfileID)
            ->setParameter('cancelled', OrderStateConstant::$ORDER_STATE_CANCEL)

            ->addGroupBy('OrderEntity.id')

            ->getQuery()
            ->getResult();
    }

    public function getSumInvoicesForStore($storeOwnerProfileId)
    {
        return $this->createQueryBuilder('OrderEntity')

            ->select('sum(ordersInvoicesEntity.invoiceAmount) as SumInvoices')

            ->leftJoin(OrderDetailEntity::class, 'orderDetailEntity', Join::WITH, 'orderDetailEntity.orderID = OrderEntity.id')
            ->leftJoin(OrdersInvoicesEntity::class, 'ordersInvoicesEntity', Join::WITH, 'orderDetailEntity.orderInvoiceId = ordersInvoicesEntity.id')

            ->andWhere("orderDetailEntity.storeOwnerProfileID = :storeOwnerProfileId ")
            ->andWhere("OrderEntity.state != :cancelled")
            ->andWhere("OrderEntity.isBillCalculated = :isBillCalculated")

            ->setParameter('storeOwnerProfileId', $storeOwnerProfileId)
            ->setParameter('cancelled', OrderStateConstant::$ORDER_STATE_CANCEL)
            ->setParameter('isBillCalculated', 1)
            ->getQuery()
            ->getSingleScalarResult();
    }

    public function getInvoicesIDsForStore($storeOwnerProfileId)
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('orderDetailEntity.orderInvoiceId')

            ->leftJoin(OrderDetailEntity::class, 'orderDetailEntity', Join::WITH, 'orderDetailEntity.orderID = OrderEntity.id')

            ->andWhere('orderDetailEntity.storeOwnerProfileID = :storeOwnerProfileId')
            ->andWhere("OrderEntity.state = :delivered")

            ->andWhere("OrderEntity.isBillCalculated = :true")

            ->setParameter('true', 1)
            ->setParameter('storeOwnerProfileId', $storeOwnerProfileId)
            ->setParameter('delivered', OrderStateConstant::$ORDER_STATE_DELIVERED)

            ->groupBy('orderDetailEntity.storeOwnerProfileID')

            ->getQuery()
            ->getResult();
    }

    public function getInvoicesIDsForStoreInSpecificDate($storeOwnerProfileId, $fromDate, $toDate)
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('orderDetailEntity.orderInvoiceId')

            ->leftJoin(OrderDetailEntity::class, 'orderDetailEntity', Join::WITH, 'orderDetailEntity.orderID = OrderEntity.id')

            ->andWhere('orderDetailEntity.storeOwnerProfileID = :storeOwnerProfileId')
            ->andWhere("orderDetailEntity.state = :delivered")
            ->andWhere('OrderEntity.createdAt >= :fromDate')
            ->andWhere('OrderEntity.createdAt < :toDate')
            ->andWhere("OrderEntity.isBillCalculated = :true")

            ->setParameter('true', 1)
            ->setParameter('storeOwnerProfileId', $storeOwnerProfileId)
            ->setParameter('delivered', OrderStateConstant::$ORDER_STATE_DELIVERED)
            ->setParameter('fromDate', $fromDate)
            ->setParameter('toDate', $toDate)

            ->getQuery()
            ->getResult();
    }
}
