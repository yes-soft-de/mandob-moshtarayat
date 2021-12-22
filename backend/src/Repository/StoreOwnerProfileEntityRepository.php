<?php

namespace App\Repository;

use App\Entity\StoreOwnerProfileEntity;
use App\Entity\StoreOwnerBranchEntity;
use App\Entity\OrderEntity;
use App\Entity\CaptainProfileEntity;
use App\Entity\DeliveryCompanyFinancialEntity;
use App\Entity\StoreCategoryEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;

/**
 * @method StoreOwnerProfileEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method StoreOwnerProfileEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method StoreOwnerProfileEntity[]    findAll()
 * @method StoreOwnerProfileEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class StoreOwnerProfileEntityRepository extends ServiceEntityRepository
{
    const STATUS_ACTIVE="active";
    const STATUS_INACTIVE="inactive";
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, StoreOwnerProfileEntity::class);
    }

     public function getStoreOwnerProfileByID($id)
    {
        return $this->createQueryBuilder('profile')
            ->select('profile.id', 'profile.storeOwnerName', 'profile.image', 'profile.story', 'profile.free', 'profile.status', 'profile.phone', 'profile.privateOrders', 'profile.hasProducts', 'profile.openingTime', 'profile.closingTime', 'profile.storeCategoryId')
            ->addSelect('storeCategoryEntity.storeCategoryName')
            ->leftJoin(StoreCategoryEntity::class, 'storeCategoryEntity', Join::WITH, 'storeCategoryEntity.id = profile.storeCategoryId ')
            
            ->andWhere('profile.id = :id')

            ->setParameter('id', $id)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getStoreOwnerByCategoryId($storeCategoryId)
    {
        return $this->createQueryBuilder('profile')
            ->select('profile.id', 'profile.storeOwnerName', 'profile.image', 'profile.phone', 'profile.privateOrders', 'profile.hasProducts', 'profile.status')
            ->addSelect('StoreOwnerBranchEntity.location')
            ->addSelect('DeliveryCompanyFinancialEntity.deliveryCost')

            ->leftJoin(DeliveryCompanyFinancialEntity::class, 'DeliveryCompanyFinancialEntity', Join::WITH, 'profile.id = profile.id')

            ->leftJoin(StoreOwnerBranchEntity::class, 'StoreOwnerBranchEntity', Join::WITH, 'StoreOwnerBranchEntity.storeOwnerProfileID = profile.id ')

            ->andWhere('profile.storeCategoryId = :storeCategoryId')
            ->andWhere('profile.status = :status')

            ->setParameter('storeCategoryId', $storeCategoryId)
            ->setParameter('status', self::STATUS_ACTIVE)
            ->groupBy('profile.id')
            ->getQuery()
            ->getResult();
    }

    public function getStoreOwnerByCategoryIdForAdmin($storeCategoryId)
    {
        return $this->createQueryBuilder('profile')
            ->select('profile.id', 'profile.storeOwnerName', 'profile.image', 'profile.phone', 'profile.privateOrders', 'profile.hasProducts', 'profile.status')
            ->addSelect('StoreOwnerBranchEntity.location')
            ->addSelect('DeliveryCompanyFinancialEntity.deliveryCost')

            ->leftJoin(DeliveryCompanyFinancialEntity::class, 'DeliveryCompanyFinancialEntity', Join::WITH, 'profile.id = profile.id')

            ->leftJoin(StoreOwnerBranchEntity::class, 'StoreOwnerBranchEntity', Join::WITH, 'StoreOwnerBranchEntity.storeOwnerProfileID = profile.id ')

            ->andWhere('profile.storeCategoryId = :storeCategoryId')

            ->setParameter('storeCategoryId', $storeCategoryId)
            ->groupBy('profile.id')
            ->getQuery()
            ->getResult();
    }

    public function getStoreOwnerBest()
    {
        return $this->createQueryBuilder('profile')
            ->select('profile.id', 'profile.storeOwnerName', 'profile.image', 'profile.phone', 'profile.privateOrders', 'profile.hasProducts', 'profile.status')
            ->addSelect('StoreOwnerBranchEntity.location')
            ->addSelect('DeliveryCompanyFinancialEntity.deliveryCost')

            ->leftJoin(DeliveryCompanyFinancialEntity::class, 'DeliveryCompanyFinancialEntity', Join::WITH, 'profile.id = profile.id')

            ->leftJoin(StoreOwnerBranchEntity::class, 'StoreOwnerBranchEntity', Join::WITH, 'StoreOwnerBranchEntity.storeOwnerProfileID = profile.id ')

            ->andWhere('profile.is_best = :best')
            ->andWhere('profile.status = :status')
            ->setParameter('best','best')
            ->setParameter('status', self::STATUS_ACTIVE)
            ->groupBy('profile.id')
            ->getQuery()
            ->getResult();
    }

    public function getStoreOwnerInactive()
    {
        return $this->createQueryBuilder('profile')
            ->select('profile.id', 'profile.storeOwnerName', 'profile.image', 'profile.phone', 'profile.privateOrders', 'profile.hasProducts', 'profile.status', 'profile.openingTime', 'profile.closingTime', 'profile.storeCategoryId')
            ->addSelect('StoreOwnerBranchEntity.location')
            ->addSelect('DeliveryCompanyFinancialEntity.deliveryCost')

            ->leftJoin(DeliveryCompanyFinancialEntity::class, 'DeliveryCompanyFinancialEntity', Join::WITH, 'profile.id = profile.id')

            ->leftJoin(StoreOwnerBranchEntity::class, 'StoreOwnerBranchEntity', Join::WITH, 'StoreOwnerBranchEntity.storeOwnerProfileID = profile.id ')

            ->andWhere('profile.status = :status')

            ->setParameter('status', self::STATUS_INACTIVE)
            ->groupBy('profile.id')
            ->getQuery()
            ->getResult();
    }

    public function getStoreOwnerInactiveFilterByName($name)
    {
        return $this->createQueryBuilder('profile')
            ->select('profile.id', 'profile.storeOwnerName', 'profile.image', 'profile.phone', 'profile.privateOrders', 'profile.hasProducts', 'profile.status', 'profile.openingTime', 'profile.closingTime', 'profile.storeCategoryId')
            ->addSelect('StoreOwnerBranchEntity.location')
            ->addSelect('DeliveryCompanyFinancialEntity.deliveryCost')

            ->leftJoin(DeliveryCompanyFinancialEntity::class, 'DeliveryCompanyFinancialEntity', Join::WITH, 'profile.id = profile.id')

            ->leftJoin(StoreOwnerBranchEntity::class, 'StoreOwnerBranchEntity', Join::WITH, 'StoreOwnerBranchEntity.storeOwnerProfileID = profile.id ')

            ->andWhere('profile.status = :status')
            ->andWhere('profile.storeOwnerName LIKE :name')

            ->setParameter('name', '%'.$name.'%')
            ->setParameter('status', self::STATUS_INACTIVE)
            ->groupBy('profile.id')
            ->getQuery()
            ->getResult();
    }

    public function getUserProfile($storeOwnerID)
    {
        return $this->createQueryBuilder('profile')

            ->andWhere('profile.storeOwnerID = :storeOwnerID')
            ->setParameter('storeOwnerID', $storeOwnerID)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getOwners()
    {
        return $this->createQueryBuilder('profile')

            ->select('profile.id', 'profile.storeOwnerID', 'profile.storeOwnerName', 'profile.image', 'profile.story', 'profile.free')
            ->addSelect('orderEntity.id as orderID', 'orderEntity.date', 'orderEntity.source', 'orderEntity.branchId', 'orderEntity.payment', 'orderEntity.destination','branchesEntity.location','branchesEntity.branchName','branchesEntity.city as branchCity', 'acceptedOrderEntity.captainID','captainProfileEntity.captainName')
       
            ->leftJoin(OrderEntity::class, 'orderEntity', Join::WITH, 'profile.storeOwnerID = orderEntity.ownerID')

            ->leftJoin(StoreOwnerBranchEntity::class, 'branchesEntity', Join::WITH, 'orderEntity.branchId = branchesEntity.id')

            ->leftJoin(CaptainProfileEntity::class, 'captainProfileEntity', Join::WITH, 'orderEntity.captainID = captainProfileEntity.captainID')

            ->getQuery()
            ->getResult();
    }

    public function getAllStoreOwners()
    {
        return $this->createQueryBuilder('profile')

            ->select('profile.id', 'profile.storeOwnerName', 'profile.image', 'profile.phone', 'profile.privateOrders', 'profile.hasProducts', 'profile.openingTime', 'profile.closingTime', 'profile.status')
            ->addSelect('StoreOwnerBranchEntity.location')
            ->addSelect('DeliveryCompanyFinancialEntity.deliveryCost', 'profile.storeCategoryId')

            ->leftJoin(DeliveryCompanyFinancialEntity::class, 'DeliveryCompanyFinancialEntity', Join::WITH, 'profile.id = profile.id')

            ->leftJoin(StoreOwnerBranchEntity::class, 'StoreOwnerBranchEntity', Join::WITH, 'StoreOwnerBranchEntity.storeOwnerProfileID = profile.id ')

            ->groupBy('profile.id')
            ->getQuery()
            ->getResult();
    }

    public function getStoresByName($name)
    {
        return $this->createQueryBuilder('profile')
            ->select('profile.id', 'profile.storeOwnerName','profile.storeOwnerID', 'profile.image', 'profile.status', 'profile.roomID', 'profile.storeCategoryId', 'profile.phone', 'profile.is_best', 'profile.privateOrders', 'profile.hasProducts')

            ->andWhere('profile.storeOwnerName LIKE :name')

            ->setParameter('name', '%'.$name.'%')
            ->setMaxResults(20)
            ->getQuery()
            ->getResult();
    }
    
    public function countStores()
    {
        return $this->createQueryBuilder('profile')
        ->select('count(profile.id) as count')
        ->getQuery()
        ->getSingleScalarResult();
    }
}
