<?php

namespace App\Repository;

use App\Entity\OrderDetailEntity;
use App\Entity\OrderEntity;
use App\Entity\ProductEntity;
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
            ->select('OrderDetailEntity.id','OrderDetailEntity.orderID', 'OrderDetailEntity.productID', 'OrderDetailEntity.countProduct', 'OrderDetailEntity.orderNumber')
            ->addSelect('ProductEntity.id as productID', 'ProductEntity.productName', 'ProductEntity.productImage', 'ProductEntity.storeProductCategoryID as ProductCategoryID', 'ProductEntity.productPrice', 'ProductEntity.storeOwnerProfileID')

            ->leftJoin(ProductEntity::class, 'ProductEntity', Join::WITH, 'ProductEntity.id = OrderDetailEntity.productID')
            
            ->andWhere('OrderDetailEntity.orderNumber = :orderNumber')
            ->setParameter('orderNumber', $orderNumber)
            
            ->getQuery()
            ->getResult();
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
          ->setParameter('cancelled', self::CANCEL)
          ->setParameter('pending', self::PENDING)
          ->getQuery()
          ->getResult();
    }
    
}
