<?php

namespace App\Repository;

use App\Constant\OrderStateConstant;
use App\Entity\OrderDetailEntity;
use App\Entity\OrderEntity;
use App\Entity\OrdersInvoicesEntity;
use App\Entity\ProductEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\StoreOwnerBranchEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;

/**
 * @method OrderDetailEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method OrderDetailEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method OrderDetailEntity[]    findAll()
 * @method OrderDetailEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class OrderDetailEntityRepository extends ServiceEntityRepository
{
    const PENDING="pending";
    const CANCEL="cancelled";
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, OrderDetailEntity::class);
    }

    public function getLastOrderNumber()
    {
        return $this->createQueryBuilder('OrderDetailEntity')

            ->select('OrderDetailEntity.orderNumber','OrderDetailEntity.orderID')

            ->setMaxResults(1)

            ->addOrderBy('OrderDetailEntity.orderID','DESC')

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getOrderIdByOrderNumber($orderNumber)
    {
        return $this->createQueryBuilder('OrderDetailEntity')

            ->select('OrderDetailEntity.id','OrderDetailEntity.orderID', 'OrderDetailEntity.productID', 'OrderDetailEntity.countProduct', 'OrderDetailEntity.orderNumber', 'OrderDetailEntity.storeOwnerProfileID')
            ->addSelect('ProductEntity.id as productID', 'ProductEntity.productName', 'ProductEntity.productImage', 'ProductEntity.storeProductCategoryID as ProductCategoryID', 'ProductEntity.productPrice')

            ->leftJoin(ProductEntity::class, 'ProductEntity', Join::WITH, 'ProductEntity.id = OrderDetailEntity.productID')
            
            ->andWhere('OrderDetailEntity.orderNumber = :orderNumber')

            ->setParameter('orderNumber', $orderNumber)
            
            ->getQuery()
            ->getResult();
    }

    public function getProductsByOrderNumberAndStoreID($orderNumber, $storeOwnerProfileID)
    {
        return $this->createQueryBuilder('OrderDetailEntity')

            ->select('OrderDetailEntity.id','OrderDetailEntity.orderID', 'OrderDetailEntity.productID', 'OrderDetailEntity.countProduct', 'OrderDetailEntity.orderNumber')
            ->addSelect('ProductEntity.id as productID', 'ProductEntity.productName', 'ProductEntity.productImage', 'ProductEntity.storeProductCategoryID as productCategoryID', 'ProductEntity.productPrice', 'ProductEntity.storeOwnerProfileID')

            ->leftJoin(ProductEntity::class, 'ProductEntity', Join::WITH, 'ProductEntity.id = OrderDetailEntity.productID')

            ->andWhere('OrderDetailEntity.orderNumber = :orderNumber')
            ->andWhere('OrderDetailEntity.storeOwnerProfileID = :storeOwnerProfileID')

            ->setParameter('orderNumber', $orderNumber)
            ->setParameter('storeOwnerProfileID', $storeOwnerProfileID)

            ->getQuery()
            ->getResult();
    }

    public function getStoreOwnerProfileByOrderNumber($orderNumber)
    {
        return $this->createQueryBuilder('OrderDetailEntity')

            ->select( 'OrderDetailEntity.id as orderDetailID', 'OrderDetailEntity.storeOwnerProfileID', 'OrderDetailEntity.orderID', 'OrderDetailEntity.state')
            ->addSelect('StoreOwnerProfileEntity.storeOwnerName', 'StoreOwnerProfileEntity.image', 'StoreOwnerProfileEntity.phone', 'StoreOwnerProfileEntity.storeCategoryId', 'StoreOwnerProfileEntity.roomID')
            ->addSelect('StoreOwnerBranchEntity.location')
            ->addSelect('OrdersInvoicesEntity.invoiceAmount', 'OrdersInvoicesEntity.invoiceImage')

            ->leftJoin(StoreOwnerProfileEntity::class, 'StoreOwnerProfileEntity', Join::WITH, 'StoreOwnerProfileEntity.id = OrderDetailEntity.storeOwnerProfileID')
            ->leftJoin(StoreOwnerBranchEntity::class, 'StoreOwnerBranchEntity', Join::WITH, 'StoreOwnerProfileEntity.id = StoreOwnerBranchEntity.storeOwnerProfileID')
            ->leftJoin(OrdersInvoicesEntity::class, 'OrdersInvoicesEntity', Join::WITH, 'OrdersInvoicesEntity.id = OrderDetailEntity.orderInvoiceId')

            ->andWhere('OrderDetailEntity.orderNumber = :orderNumber')

            ->setParameter('orderNumber', $orderNumber)

            ->addGroupBy('OrderDetailEntity.storeOwnerProfileID')

            ->getQuery()
           ->getResult();
    }

    public function getStoreOwnerProfileIdAndOrderIDByOrderNumber($orderNumber)
    {
        return $this->createQueryBuilder('OrderDetailEntity')

            ->select( 'OrderDetailEntity.storeOwnerProfileID', 'OrderDetailEntity.orderID')

            ->leftJoin(StoreOwnerProfileEntity::class, 'StoreOwnerProfileEntity', Join::WITH, 'StoreOwnerProfileEntity.id = OrderDetailEntity.storeOwnerProfileID')

            ->andWhere('OrderDetailEntity.orderNumber = :orderNumber')

            ->setParameter('orderNumber', $orderNumber)

            ->addGroupBy('OrderDetailEntity.storeOwnerProfileID')

            ->getQuery()
        ->getArrayResult();
    }

    public function getOrderIdWithOutStoreProductByOrderNumber($orderNumber)
    {
        return $this->createQueryBuilder('OrderDetailEntity')

            ->select('OrderDetailEntity.id','OrderDetailEntity.orderID', 'OrderDetailEntity.productID', 'OrderDetailEntity.countProduct', 'OrderDetailEntity.orderNumber')
            ->addSelect('ProductEntity.id as productID', 'ProductEntity.productName', 'ProductEntity.productImage', 'ProductEntity.storeProductCategoryID', 'ProductEntity.productPrice')

            ->leftJoin(ProductEntity::class, 'ProductEntity', Join::WITH, 'ProductEntity.id = OrderDetailEntity.productID')

            ->andWhere('OrderDetailEntity.orderNumber = :orderNumber')

            ->setParameter('orderNumber', $orderNumber)

            ->getQuery()
            ->getResult();
    }

    public function getOrderId($orderNumber)
    {
        return $this->createQueryBuilder('OrderDetailEntity')

            ->select('OrderDetailEntity.id','OrderDetailEntity.orderID')

            ->andWhere('OrderDetailEntity.orderNumber = :orderNumber')

            ->setParameter('orderNumber', $orderNumber)

            ->getQuery()
            ->getResult();
    }

    public function getOrderDetailId($orderNumber)
    {
        return $this->createQueryBuilder('OrderDetailEntity')

            ->select('OrderDetailEntity.id','OrderDetailEntity.orderID')

            ->andWhere('OrderDetailEntity.orderNumber = :orderNumber')

            ->setParameter('orderNumber', $orderNumber)

            ->getQuery()
            ->getResult();
    }

    public function orderDetailByProductIdAndOrderNumber($productId, $orderNumber)
    {
        return $this->createQueryBuilder('OrderDetailEntity')

            ->andWhere('OrderDetailEntity.orderNumber = :orderNumber')
            ->andWhere('OrderDetailEntity.productID = :productId')

            ->setParameter('orderNumber', $orderNumber)
            ->setParameter('productId', $productId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getOrderDetailsByOrderNumberAndStoreProfileID($orderNumber, $storeOwnerProfileID)
    {
        return $this->createQueryBuilder('OrderDetailEntity')

            ->select('OrderDetailEntity.id')

            ->andWhere('OrderDetailEntity.orderNumber = :orderNumber')
            ->andWhere('OrderDetailEntity.storeOwnerProfileID = :storeOwnerProfileID')

            ->setParameter('orderNumber', $orderNumber)
            ->setParameter('storeOwnerProfileID', $storeOwnerProfileID)

            ->getQuery()
            ->getResult();
    }

    public function getOrderDetailStates($orderNumber)
    {
        return $this->createQueryBuilder('OrderDetailEntity')

            ->select('OrderDetailEntity.state')

            ->andWhere('OrderDetailEntity.orderNumber = :orderNumber')

            ->setParameter('orderNumber', $orderNumber)

            ->getQuery()
            ->getResult();
    }

    public function getOrderIds($storeOwnerProfileId)
    {
        return $this->createQueryBuilder('OrderDetailEntity')

            ->select('OrderDetailEntity.orderID')

            ->andWhere('OrderDetailEntity.storeOwnerProfileID = :storeOwnerProfileId')

            ->setParameter('storeOwnerProfileId', $storeOwnerProfileId)

            ->groupBy('OrderDetailEntity.orderNumber')

            ->getQuery()
            ->getResult();
    }

    public function getStorePendingOrders($storeOwnerProfileId)
    {
        return $this->createQueryBuilder('orderDetailEntity')


            ->select('OrderEntity.id', 'OrderEntity.deliveryDate', 'OrderEntity.createdAt', 'OrderEntity.source', 'OrderEntity.payment', 'OrderEntity.detail', 'OrderEntity.deliveryCost', 'OrderEntity.orderCost', 'OrderEntity.orderType', 'OrderEntity.destination', 'OrderEntity.note')
            ->addSelect('orderDetailEntity.id as orderDetailId', 'orderDetailEntity.orderNumber')

            ->leftJoin(OrderEntity::class, 'OrderEntity', Join::WITH, 'orderDetailEntity.orderID = OrderEntity.id')

            ->andWhere('orderDetailEntity.state = :pending ')
            ->andWhere('orderDetailEntity.storeOwnerProfileID = :storeOwnerProfileId ')

            ->setParameter('pending', OrderStateConstant::$ORDER_STATE_PENDING)
            ->setParameter('storeOwnerProfileId', $storeOwnerProfileId)

            ->addGroupBy('OrderEntity.id')

            ->getQuery()
            ->getResult();
    }

    public function getStoreOrders($storeOwnerProfileId)
    {
        return $this->createQueryBuilder('orderDetailEntity')


            ->select('OrderEntity.id', 'OrderEntity.deliveryDate', 'OrderEntity.createdAt', 'OrderEntity.source', 'OrderEntity.payment', 'OrderEntity.detail', 'OrderEntity.deliveryCost', 'OrderEntity.orderCost', 'OrderEntity.orderType', 'OrderEntity.destination', 'OrderEntity.note')
            ->addSelect('orderDetailEntity.id as orderDetailId', 'orderDetailEntity.orderNumber')

            ->leftJoin(OrderEntity::class, 'OrderEntity', Join::WITH, 'orderDetailEntity.orderID = OrderEntity.id')

            ->andWhere('orderDetailEntity.state != :state ')
            ->andWhere('orderDetailEntity.storeOwnerProfileID = :storeOwnerProfileId ')

            ->setParameter('state', OrderStateConstant::$ORDER_STATE_CANCEL)
            ->setParameter('storeOwnerProfileId', $storeOwnerProfileId)

            ->addGroupBy('OrderEntity.id')

            ->getQuery()
            ->getResult();
    }

    public function getStoreOrdersInSpecificDate($fromDate, $toDate, $storeOwnerProfileId)
    {
        return $this->createQueryBuilder('orderDetailEntity')


            ->select('OrderEntity.id', 'OrderEntity.deliveryDate', 'OrderEntity.createdAt', 'OrderEntity.source', 'OrderEntity.payment', 'OrderEntity.detail', 'OrderEntity.deliveryCost', 'OrderEntity.orderCost', 'OrderEntity.orderType', 'OrderEntity.destination', 'OrderEntity.note')
            ->addSelect('orderDetailEntity.id as orderDetailId', 'orderDetailEntity.orderNumber')

            ->leftJoin(OrderEntity::class, 'OrderEntity', Join::WITH, 'orderDetailEntity.orderID = OrderEntity.id')

            ->andWhere('OrderEntity.createdAt >= :fromDate')
            ->andWhere('OrderEntity.createdAt < :toDate')
            ->andWhere('orderDetailEntity.storeOwnerProfileID = :storeOwnerProfileId ')

            ->setParameter('storeOwnerProfileId', $storeOwnerProfileId)
            ->setParameter('fromDate', $fromDate)
            ->setParameter('toDate', $toDate)

            ->addGroupBy('OrderEntity.id')

            ->getQuery()
            ->getResult();
    }

    public function getOrderDetailsByOrderNumberForStore($orderNumber, $storeOwnerProfileID)
    {
        return $this->createQueryBuilder('OrderDetailEntity')

            ->select( 'OrderDetailEntity.id as orderDetailID', 'OrderDetailEntity.storeOwnerProfileID', 'OrderDetailEntity.orderID')
            ->addSelect('StoreOwnerProfileEntity.storeOwnerName', 'StoreOwnerProfileEntity.image', 'StoreOwnerProfileEntity.phone', 'StoreOwnerProfileEntity.storeCategoryId')
            ->addSelect('StoreOwnerBranchEntity.location')
            ->addSelect('OrdersInvoicesEntity.invoiceAmount', 'OrdersInvoicesEntity.invoiceImage')
            ->addSelect('OrderEntity.note', 'OrderEntity.createdAt', 'OrderEntity.detail', 'OrderEntity.orderType', 'OrderEntity.deliveryDate')

            ->leftJoin(OrderEntity::class, 'OrderEntity', Join::WITH, 'OrderEntity.id = OrderDetailEntity.orderID')
            ->leftJoin(StoreOwnerProfileEntity::class, 'StoreOwnerProfileEntity', Join::WITH, 'StoreOwnerProfileEntity.id = OrderDetailEntity.storeOwnerProfileID')
            ->leftJoin(StoreOwnerBranchEntity::class, 'StoreOwnerBranchEntity', Join::WITH, 'StoreOwnerProfileEntity.id = StoreOwnerBranchEntity.storeOwnerProfileID')
            ->leftJoin(OrdersInvoicesEntity::class, 'OrdersInvoicesEntity', Join::WITH, 'OrdersInvoicesEntity.id = OrderDetailEntity.orderInvoiceId')

            ->andWhere('OrderDetailEntity.orderNumber = :orderNumber')
            ->andWhere('OrderDetailEntity.storeOwnerProfileID = :storeOwnerProfileID')
//            ->andWhere('OrdersInvoicesEntity.orderNumber = :orderNumber')

            ->setParameter('orderNumber', $orderNumber)
            ->setParameter('storeOwnerProfileID', $storeOwnerProfileID)

            ->addGroupBy('OrderDetailEntity.storeOwnerProfileID')

            ->getQuery()
            ->getResult();
    }

    public function getStoreOrdersOngoingForStoreOwner($storeOwnerProfileId)
    {
        return $this->createQueryBuilder('orderDetailEntity')


            ->select('OrderEntity.id', 'OrderEntity.deliveryDate', 'OrderEntity.createdAt', 'OrderEntity.source', 'OrderEntity.payment', 'OrderEntity.detail', 'OrderEntity.deliveryCost', 'OrderEntity.orderCost', 'OrderEntity.orderType', 'OrderEntity.destination', 'OrderEntity.note')
            ->addSelect('orderDetailEntity.id as orderDetailId', 'orderDetailEntity.orderNumber')

            ->leftJoin(OrderEntity::class, 'OrderEntity', Join::WITH, 'orderDetailEntity.orderID = OrderEntity.id')

            ->andWhere('orderDetailEntity.state = :state ')
            ->andWhere('orderDetailEntity.storeOwnerProfileID = :storeOwnerProfileId ')

            ->setParameter('state', OrderStateConstant::$ORDER_STATE_ONGOING)
            ->setParameter('storeOwnerProfileId', $storeOwnerProfileId)

            ->addGroupBy('OrderEntity.id')

            ->getQuery()
            ->getResult();
    }

    public function getOrderNumberByOrderId($orderID)
    {
        return $this->createQueryBuilder('OrderDetailEntity')

            ->select('OrderDetailEntity.id','OrderDetailEntity.orderID', 'OrderDetailEntity.productID', 'OrderDetailEntity.countProduct', 'OrderDetailEntity.orderNumber')
            ->addSelect('ProductEntity.id as productID', 'ProductEntity.productName', 'ProductEntity.productImage', 'ProductEntity.storeProductCategoryID', 'ProductEntity.productPrice')

            ->leftJoin(ProductEntity::class, 'ProductEntity', Join::WITH, 'ProductEntity.id = OrderDetailEntity.productID')
            
            ->andWhere('OrderDetailEntity.orderID = :orderID')

            ->setParameter('orderID', $orderID)

            ->getQuery()
            ->getResult();
    }

    public function getCountOrdersEveryProductInLastMonth($fromDate, $toDate)
    {
        return $this->createQueryBuilder('OrderDetailEntity')
          ->select('OrderDetailEntity.productID', 'count(OrderDetailEntity.productID) as countOrdersInMonth')
          ->addSelect('ProductEntity.productName', 'ProductEntity.productImage')
          
          ->leftJoin(OrderEntity::class, 'OrderEntity', Join::WITH, 'OrderEntity.id = OrderDetailEntity.orderID')
          ->leftJoin(ProductEntity::class, 'ProductEntity', Join::WITH, 'ProductEntity.id = OrderDetailEntity.productID')

          ->where('OrderEntity.createdAt >= :fromDate')
          ->andWhere('OrderEntity.createdAt < :toDate')
          ->andWhere("OrderEntity.state != :cancelled")
          ->andWhere("OrderEntity.state != :pending")

          ->addGroupBy('OrderDetailEntity.productID')

          ->having('count(OrderDetailEntity.productID) > 0')

          ->setMaxResults(30)

          ->addOrderBy('countOrdersInMonth','DESC')
         
          ->setParameter('fromDate', $fromDate)
          ->setParameter('toDate', $toDate)
          ->setParameter('cancelled', OrderStateConstant::$ORDER_STATE_CANCEL)
          ->setParameter('pending', OrderStateConstant::$ORDER_STATE_PENDING)

          ->getQuery()
          ->getResult();
    }
}
