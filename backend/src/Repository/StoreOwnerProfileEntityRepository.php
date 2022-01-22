<?php

namespace App\Repository;

use App\Constant\RepresentativeStoreLinkTypeConstant;
use App\Constant\StoreStatusConstant;
use App\Entity\ProductEntity;
use App\Entity\RepresentativeStoreLinkEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\StoreOwnerBranchEntity;
use App\Entity\OrderEntity;
use App\Entity\CategoryLinkEntity;
use App\Entity\DeliveryCompanyFinancialEntity;
use App\Entity\MandobProfileEntity;
use App\Entity\StoreCategoryEntity;
use App\Entity\UserEntity;
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

            ->select('profile.id', 'profile.storeOwnerName', 'profile.image', 'profile.story', 'profile.free', 'profile.status', 'profile.phone', 'profile.privateOrders', 'profile.hasProducts', 'profile.openingTime', 'profile.closingTime', 'profile.storeCategoryId', 'profile.commission', 'profile.bankName', 'profile.bankAccountNumber', 'profile.stcPay')
            ->addSelect('storeCategoryEntity.storeCategoryName')

            ->leftJoin(StoreCategoryEntity::class, 'storeCategoryEntity', Join::WITH, 'storeCategoryEntity.id = profile.storeCategoryId ')
            
            ->andWhere('profile.id = :id')

            ->setParameter('id', $id)

            ->getQuery()
            ->getOneOrNullResult();
    }

     public function getStoreIdByProfileId($id)
    {
        return $this->createQueryBuilder('profile')

            ->select('profile.storeOwnerID')

            ->andWhere('profile.id = :id')

            ->setParameter('id', $id)

            ->getQuery()
            ->getSingleScalarResult();
    }

     public function getStoreNameById($id)
    {
        return $this->createQueryBuilder('profile')

            ->select('profile.id', 'profile.storeOwnerName', 'profile.image')

            ->andWhere('profile.id = :id')

            ->setParameter('id', $id)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getStoreOwnerByCategoryId($storeCategoryId)
    {
        return $this->createQueryBuilder('profile')

            ->select('profile.id', 'profile.storeOwnerName', 'profile.image', 'profile.phone', 'profile.privateOrders', 'profile.hasProducts', 'profile.status', 'profile.openingTime', 'profile.closingTime')
            ->addSelect('StoreOwnerBranchEntity.location')

            ->leftJoin(StoreOwnerBranchEntity::class, 'StoreOwnerBranchEntity', Join::WITH, 'StoreOwnerBranchEntity.storeOwnerProfileID = profile.id ')

            ->leftJoin(CategoryLinkEntity::class, 'CategoryLinkEntity', Join::WITH, 'CategoryLinkEntity.mainCategoryID = :storeCategoryId ')

            ->leftJoin(ProductEntity::class, 'ProductEntity', Join::WITH, 'ProductEntity.storeOwnerProfileID = profile.id ')

            ->where('profile.status = :status')
            ->andWhere('CategoryLinkEntity.mainCategoryID = :storeCategoryId ')
            ->andWhere('ProductEntity.storeOwnerProfileID = profile.id  ')

            ->setParameter('storeCategoryId', $storeCategoryId)
            ->setParameter('status', self::STATUS_ACTIVE)

            ->groupBy('profile.id')
            ->getQuery()
            ->getResult();
    }

    public function getStoreOwnerProfileByCategoryID($storeCategoryID)
    {
        return $this->createQueryBuilder('profile')
            ->select('profile.id', 'profile.storeOwnerName', 'profile.image', 'profile.phone', 'profile.status')

            ->andWhere('profile.storeCategoryId = :storeCategoryId')
            ->setParameter('storeCategoryId', $storeCategoryID)

            ->andWhere('profile.status = :status')
            ->setParameter('status', StoreStatusConstant::$ACTIVE_STORE_STATUS)

            ->getQuery()
            ->getResult();
    }

    public function getStoreOwnerProfilesByIDsArray($storesIDsArray)
    {
        return $this->createQueryBuilder('profile')
            ->select('profile.id', 'profile.storeOwnerName', 'profile.image', 'profile.phone', 'profile.status')

            ->andWhere('profile.id IN (:storesIDsArray)')
            ->setParameter('storesIDsArray', $storesIDsArray)

            ->andWhere('profile.status = :status')
            ->setParameter('status', StoreStatusConstant::$ACTIVE_STORE_STATUS)

            ->getQuery()
            ->getResult();
    }

    public function getLastFifteenStoreOwnerProfilesByIDsArray($storesIDsArray)
    {
        return $this->createQueryBuilder('profile')
            ->select('profile.id', 'profile.storeOwnerName', 'profile.image', 'profile.phone', 'profile.status')

            ->andWhere('profile.id IN (:storesIDsArray)')
            ->setParameter('storesIDsArray', $storesIDsArray)

            ->andWhere('profile.status = :status')
            ->setParameter('status', StoreStatusConstant::$ACTIVE_STORE_STATUS)

            ->setMaxResults(15)

            ->getQuery()
            ->getResult();
    }

    public function getLast15StoresByCategoryID($storeCategoryID)
    {
        return $this->createQueryBuilder('profile')
            ->select('profile.id', 'profile.storeOwnerName', 'profile.image', 'profile.phone', 'profile.status')

            ->andWhere('profile.storeCategoryId = :storeCategoryId')
            ->setParameter('storeCategoryId', $storeCategoryID)

            ->andWhere('profile.status = :status')

            ->setParameter('status', self::STATUS_ACTIVE)

            ->addOrderBy('profile.id','DESC')

            ->setMaxResults(15)

            ->getQuery()
            ->getResult();
    }

    public function getStoreOwnerByCategoryIdForAdmin($storeCategoryId)
    {
        return $this->createQueryBuilder('profile')

            ->select('profile.id', 'profile.storeOwnerName', 'profile.image', 'profile.phone', 'profile.privateOrders', 'profile.hasProducts', 'profile.status')
            ->addSelect('StoreOwnerBranchEntity.location')

            ->leftJoin(StoreOwnerBranchEntity::class, 'StoreOwnerBranchEntity', Join::WITH, 'StoreOwnerBranchEntity.storeOwnerProfileID = profile.id ')

            ->leftJoin(CategoryLinkEntity::class, 'CategoryLinkEntity', Join::WITH, 'CategoryLinkEntity.mainCategoryID = :storeCategoryId ')

            ->leftJoin(ProductEntity::class, 'ProductEntity', Join::WITH, 'ProductEntity.storeOwnerProfileID = profile.id ')

            ->where('profile.status = :status')
            ->andWhere('CategoryLinkEntity.mainCategoryID = :storeCategoryId ')
            ->andWhere('ProductEntity.storeOwnerProfileID = profile.id  ')

            ->setParameter('storeCategoryId', $storeCategoryId)
            ->setParameter('status', self::STATUS_ACTIVE)

            ->groupBy('profile.id')

            ->getQuery()
            ->getResult();
    }

    public function getStoreOwnerBest()
    {
        return $this->createQueryBuilder('profile')

            ->select('profile.id', 'profile.storeOwnerName', 'profile.image', 'profile.phone', 'profile.privateOrders', 'profile.hasProducts', 'profile.status', 'profile.openingTime', 'profile.closingTime', 'profile.storeCategoryId')
            ->addSelect('StoreOwnerBranchEntity.location')
            ->addSelect('DeliveryCompanyFinancialEntity.deliveryCost')

            ->leftJoin(DeliveryCompanyFinancialEntity::class, 'DeliveryCompanyFinancialEntity', Join::WITH, 'profile.id = profile.id')
            ->leftJoin(StoreOwnerBranchEntity::class, 'StoreOwnerBranchEntity', Join::WITH, 'StoreOwnerBranchEntity.storeOwnerProfileID = profile.id ')

            ->andWhere('profile.is_best = :best')
            ->andWhere('profile.status = :status')

            ->setParameter('best','best')
            ->setParameter('status', StoreStatusConstant::$ACTIVE_STORE_STATUS)

            ->groupBy('profile.id')

            ->getQuery()
            ->getResult();
    }

    public function getStoreOwnerInactive()
    {
        return $this->createQueryBuilder('profile')

            ->select('profile.id', 'profile.storeOwnerName', 'profile.image', 'profile.phone', 'profile.privateOrders', 'profile.hasProducts', 'profile.status', 'profile.openingTime', 'profile.closingTime', 'profile.storeCategoryId', 'profile.storeCategoryId',
             'profile.stcPay', 'profile.bankAccountNumber', 'profile.bankName')
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

    public function getStoreOwnersByRepresentativeID($representativeUserID): ?array
    {
        return $this->createQueryBuilder('profile')
            ->select('profile.id', 'profile.storeOwnerName', 'profile.phone', 'profile.image', 'profile.storeOwnerID', 'profile.commission', 'profile.free')

            ->leftJoin(
                RepresentativeStoreLinkEntity::class,
                'representativeStoreLinkEntity',
                Join::WITH,
                'representativeStoreLinkEntity.storeOwnerUserID = profile.storeOwnerID'
            )

            ->andWhere('representativeStoreLinkEntity.linkStatus = :status')
            ->setParameter('status', RepresentativeStoreLinkTypeConstant::$REPRESENTATIVE_STORE_LINKED)

            ->getQuery()
            ->getResult();
    }

    public function getStoreOwnersByRepresentativeIdForAdmin($representativeUserID): ?array
    {
        return $this->createQueryBuilder('profile')
            ->select('profile.id', 'profile.storeOwnerName', 'profile.phone', 'profile.image', 'profile.storeOwnerID', 'profile.commission', 'profile.free')

            ->leftJoin(
                RepresentativeStoreLinkEntity::class,
                'representativeStoreLinkEntity',
                Join::WITH,
                'representativeStoreLinkEntity.storeOwnerUserID = profile.storeOwnerID'
            )

            ->andWhere('representativeStoreLinkEntity.linkStatus = :status')
            ->setParameter('status', RepresentativeStoreLinkTypeConstant::$REPRESENTATIVE_STORE_LINKED)
        
            ->andWhere('representativeStoreLinkEntity.representativeUserID = :representativeID')
            ->setParameter('representativeID', $representativeUserID)

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

    public function getAllStoreOwners()
    {
        return $this->createQueryBuilder('profile')

            ->select('profile.id', 'profile.storeOwnerName', 'profile.image', 'profile.phone', 'profile.privateOrders', 'profile.hasProducts', 'profile.openingTime', 'profile.closingTime', 'profile.status', 'profile.commission',
             'profile.bankName', 'profile.bankAccountNumber', 'profile.stcPay')
            ->addSelect('StoreOwnerBranchEntity.location')
            ->addSelect('DeliveryCompanyFinancialEntity.deliveryCost', 'profile.storeCategoryId')

            ->leftJoin(DeliveryCompanyFinancialEntity::class, 'DeliveryCompanyFinancialEntity', Join::WITH, 'profile.id = profile.id')
            ->leftJoin(StoreOwnerBranchEntity::class, 'StoreOwnerBranchEntity', Join::WITH, 'StoreOwnerBranchEntity.storeOwnerProfileID = profile.id ')

            ->andWhere('profile.status = :status')
            ->setParameter('status',self::STATUS_ACTIVE)

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

    public function getActiveStoresByName($name)
    {
        return $this->createQueryBuilder('profile')

            ->select('profile.id', 'profile.storeOwnerName','profile.storeOwnerID', 'profile.image', 'profile.status', 'profile.roomID', 'profile.storeCategoryId', 'profile.phone', 'profile.is_best', 'profile.privateOrders', 'profile.hasProducts')

            ->andWhere('profile.storeOwnerName LIKE :name')
            ->andWhere('profile.status = :status')

            ->setParameter('name', '%'.$name.'%')
            ->setParameter('status', 'active')

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

    public function storeOwnerProfileByStoreID($storeID)
    {
        return $this->createQueryBuilder('profile')
            ->select('profile.id', 'profile.storeOwnerName', 'profile.storeOwnerID', 'profile.image', 'profile.status', 'profile.roomID', 'profile.storeCategoryId',
                'profile.phone', 'profile.is_best', 'profile.privateOrders', 'profile.hasProducts', 'userEntity.createDate')

            ->leftJoin(
                UserEntity::class,
                'userEntity',
                Join::WITH,
                'userEntity.id = profile.storeOwnerID')

            ->andWhere('profile.storeOwnerID = :storeID')
            ->setParameter('storeID', $storeID)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function storeOwnerProfileByRoomID($roomID)
    {
        return $this->createQueryBuilder('profile')

            ->select('profile.id', 'profile.storeOwnerName', 'profile.storeOwnerID', 'profile.image', 'profile.status', 'profile.roomID', 'profile.storeCategoryId',
                'profile.phone', 'profile.is_best', 'profile.privateOrders', 'profile.hasProducts')

            ->andWhere('profile.roomID = :roomID')

            ->setParameter('roomID', $roomID)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function storeIsActive($storeOwnerID)
    {
        return $this->createQueryBuilder('profile')

            ->select('profile.status')

            ->andWhere('profile.storeOwnerID = :storeOwnerID')

            ->setParameter('storeOwnerID', $storeOwnerID)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getLast15Stores()
    {
        return $this->createQueryBuilder('profile')

            ->select('profile.id', 'profile.storeOwnerName', 'profile.image', 'profile.story', 'profile.free', 'profile.status', 'profile.phone', 'profile.privateOrders', 'profile.hasProducts', 'profile.openingTime', 'profile.closingTime', 'profile.storeCategoryId')
            ->addSelect('StoreOwnerBranchEntity.location')

            ->leftJoin(StoreOwnerBranchEntity::class, 'StoreOwnerBranchEntity', Join::WITH, 'StoreOwnerBranchEntity.storeOwnerProfileID = profile.id ')

            ->andWhere('profile.status = :active')

            ->setParameter('active','active')

            ->addOrderBy('profile.id','DESC')

            ->setMaxResults(15)

            ->getQuery()
            ->getResult();
    }

    public function getStoreProfileId($userID)
    {
        return $this->createQueryBuilder('profile')

            ->select('profile.id')

            ->andWhere('profile.storeOwnerID=:userID')

            ->setParameter('userID', $userID)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function isItRelatedToProduct($id)
    {
        return $this->createQueryBuilder('profile')

            ->select('profile.id')

            ->leftJoin(ProductEntity::class, 'ProductEntity', Join::WITH, 'ProductEntity.storeOwnerProfileID = profile.id')

            ->andWhere('ProductEntity.storeOwnerProfileID= :id')

            ->setParameter('id',$id)

            ->getQuery()
            ->getResult();
    }

    // return store owner profile entity
    public function getStoreOwnerProfileEntityByUserID($userID)
    {
        return $this->createQueryBuilder('storeOwnerProfileEntity')

            ->andWhere('storeOwnerProfileEntity.storeOwnerID = :userID')
            ->setParameter('userID', $userID)

            ->getQuery()
            ->getOneOrNullResult();
    }
}
