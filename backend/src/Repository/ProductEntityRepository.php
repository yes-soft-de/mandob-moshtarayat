<?php

namespace App\Repository;

use App\Constant\CategoryLinkConstant;
use App\Constant\ProductStatusConstant;
use App\Constant\StoreStatusConstant;
use App\Entity\CategoryLinkEntity;
use App\Entity\ProductEntity;
use App\Entity\ProductTranslationEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\StoreOwnerBranchEntity;
use App\Entity\OrderDetailEntity;
use App\Entity\DeliveryCompanyFinancialEntity;
use App\Entity\StoreCategoryEntity;
use App\Entity\StoreProductCategoryEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;

/**
 * @method ProductEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method ProductEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method ProductEntity[]    findAll()
 * @method ProductEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ProductEntityRepository extends ServiceEntityRepository
{
    const STATUS_ACTIVE="active";

    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, ProductEntity::class);
    }

    public function getProductsByProductCategoryId($storeProductCategoryID)
    {
        return $this->createQueryBuilder('product')

            ->select('product.id', 'product.productName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID','product.discount','product.description')

            ->andWhere('product.storeProductCategoryID =:storeProductCategoryID')

            ->setParameter('storeProductCategoryID',$storeProductCategoryID)

            ->getQuery()
            ->getResult();
    }

    public function getProductsTranslationsByProductCategoryId($storeProductCategoryID)
    {
        return $this->createQueryBuilder('product')

            ->select('product.id', 'product.productName as primaryProductName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID','product.discount',
                'product.description', 'productTranslationEntity.productName', 'productTranslationEntity.language')

            ->andWhere('product.storeProductCategoryID =:storeProductCategoryID')
            ->setParameter('storeProductCategoryID',$storeProductCategoryID)

            ->leftJoin(
                ProductTranslationEntity::class,
                'productTranslationEntity',
                Join::WITH,
                'productTranslationEntity.productID = product.id'
            )

            ->getQuery()
            ->getResult();
    }

    public function getActiveProductsByProductCategoryId($storeProductCategoryID)
    {
        return $this->createQueryBuilder('product')

            ->select('product.id', 'product.productName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID','product.discount','product.description','product.isCommission', 'product.commission')
            ->addSelect('storeOwnerProfile.commission as storeCommission')

            ->andWhere('product.storeProductCategoryID =:storeProductCategoryID')

            ->andWhere('product.status =:status')

            ->setParameter('storeProductCategoryID',$storeProductCategoryID)

            ->setParameter('status', ProductStatusConstant::$ACTIVE_PRODUCT_STATUS)

            ->leftJoin(
                StoreOwnerProfileEntity::class,
                'storeOwnerProfile',
                Join::WITH,
                'storeOwnerProfile.id = product.storeOwnerProfileID'
            )

            ->andWhere('storeOwnerProfile.status = :status')
            ->setParameter('status', StoreStatusConstant::$ACTIVE_STORE_STATUS)

            ->getQuery()
            ->getResult();
    }

    public function getActiveProductsTranslationsByProductCategoryId($storeProductCategoryID)
    {
        return $this->createQueryBuilder('product')
            ->select('product.id', 'product.productName as primaryProductName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID',
                'product.discount', 'product.description', 'productTranslationEntity.productName', 'productTranslationEntity.language', 'product.commission', 'product.isCommission')
            ->addSelect('storeOwnerProfile.commission as storeCommission')

            ->andWhere('product.storeProductCategoryID =:storeProductCategoryID')
            ->andWhere('product.status =:status')

            ->setParameter('storeProductCategoryID',$storeProductCategoryID)
            ->setParameter('status', ProductStatusConstant::$ACTIVE_PRODUCT_STATUS)

            ->leftJoin(
                ProductTranslationEntity::class,
                'productTranslationEntity',
                Join::WITH,
                'productTranslationEntity.productID = product.id'
            )

            ->leftJoin(
                StoreOwnerProfileEntity::class,
                'storeOwnerProfile',
                Join::WITH,
                'storeOwnerProfile.id = product.storeOwnerProfileID'
            )

            ->andWhere('storeOwnerProfile.status = :status')
            ->setParameter('status', StoreStatusConstant::$ACTIVE_STORE_STATUS)


            ->getQuery()
            ->getResult();
    }

    public function getProductsByCategoryIdAndStoreOwnerProfileId($storeProductCategoryID, $storeOwnerProfileId)
    {
        return $this->createQueryBuilder('product')

            ->select('product.id', 'product.productName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID', 'product.discount', 'product.description',
                'product.status', 'product.productQuantity', 'product.commission', 'product.isCommission')
            ->addSelect('storeOwnerProfile.commission as storeCommission')
            ->leftJoin( StoreOwnerProfileEntity::class,'storeOwnerProfile', Join::WITH,'storeOwnerProfile.id = product.storeOwnerProfileID')

            ->andWhere('product.storeProductCategoryID =:storeProductCategoryID')
            ->andWhere('product.storeOwnerProfileID =:storeOwnerProfileId')

            ->setParameter('storeProductCategoryID',$storeProductCategoryID)
            ->setParameter('storeOwnerProfileId',$storeOwnerProfileId)

            ->andWhere('product.status = :status')
            ->setParameter('status', self::STATUS_ACTIVE)

            ->getQuery()
            ->getResult();
    }

    public function getProductsByCategoryIdAndStoreOwnerProfileIdForStore($storeProductCategoryID, $storeOwnerProfileId)
    {
        return $this->createQueryBuilder('product')

            ->select('product.id', 'product.productName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID', 'product.discount', 'product.description',
                'product.status', 'product.productQuantity', 'product.commission', 'product.isCommission', 'storeProductCategoryEntity.isLevel1', 'storeProductCategoryEntity.isLevel2')

            ->andWhere('product.storeProductCategoryID =:storeProductCategoryID')
            ->andWhere('product.storeOwnerProfileID =:storeOwnerProfileId')

            ->setParameter('storeProductCategoryID',$storeProductCategoryID)
            ->setParameter('storeOwnerProfileId',$storeOwnerProfileId)

            ->leftJoin(
                StoreProductCategoryEntity::class,
                'storeProductCategoryEntity',
                Join::WITH,
                'storeProductCategoryEntity.id = product.storeProductCategoryID'
            )

            ->getQuery()
            ->getResult();
    }

    public function getProductsByCategoryIdAndStoreOwnerProfileIdForAdmin($storeProductCategoryID, $storeOwnerProfileId)
    {
        return $this->createQueryBuilder('product')

            ->select('product.id', 'product.productName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID', 'product.discount',
                'product.description', 'product.status', 'product.productQuantity', 'product.commission', 'product.isCommission')

            ->andWhere('product.storeProductCategoryID =:storeProductCategoryID')
            ->andWhere('product.storeOwnerProfileID =:storeOwnerProfileId')

            ->setParameter('storeProductCategoryID',$storeProductCategoryID)
            ->setParameter('storeOwnerProfileId',$storeOwnerProfileId)

            ->andWhere('product.status = :status')
            ->setParameter('status', self::STATUS_ACTIVE)

            ->getQuery()
            ->getResult();
    }

    public function getProductsTranslationByCategoryIdAndStoreOwnerProfileId($storeProductCategoryID, $storeOwnerProfileId)
    {
        return $this->createQueryBuilder('product')

            ->select('product.id', 'product.productName as primaryProductName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID', 'product.discount',
                'product.commission', 'product.isCommission', 'product.description', 'product.status', 'product.productQuantity', 'productTranslationEntity.productName', 'productTranslationEntity.language')
            ->addSelect('storeOwnerProfile.commission as storeCommission')

            ->leftJoin(
                StoreOwnerProfileEntity::class,
                'storeOwnerProfile',
                Join::WITH,
                'storeOwnerProfile.id = product.storeOwnerProfileID')

            ->andWhere('product.storeProductCategoryID =:storeProductCategoryID')
            ->andWhere('product.storeOwnerProfileID =:storeOwnerProfileId')

            ->setParameter('storeProductCategoryID',$storeProductCategoryID)
            ->setParameter('storeOwnerProfileId',$storeOwnerProfileId)

            ->andWhere('product.status = :status')
            ->setParameter('status', self::STATUS_ACTIVE)

            ->leftJoin(
                ProductTranslationEntity::class,
                'productTranslationEntity',
                Join::WITH,
                'productTranslationEntity.productID = product.id'
            )

            ->getQuery()
            ->getResult();
    }

    public function getProductsTranslationByCategoryIdAndStoreOwnerProfileIdForStore($storeProductCategoryID, $storeOwnerProfileId)
    {
        return $this->createQueryBuilder('product')

            ->select('product.id', 'product.productName as primaryProductName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID', 'product.discount',
                'product.commission', 'product.isCommission', 'product.description', 'product.status', 'product.productQuantity', 'productTranslationEntity.productName', 'productTranslationEntity.language',
                'storeProductCategoryEntity.isLevel1', 'storeProductCategoryEntity.isLevel2')

            ->andWhere('product.storeProductCategoryID =:storeProductCategoryID')
            ->andWhere('product.storeOwnerProfileID =:storeOwnerProfileId')

            ->setParameter('storeProductCategoryID',$storeProductCategoryID)
            ->setParameter('storeOwnerProfileId',$storeOwnerProfileId)

            ->leftJoin(
                ProductTranslationEntity::class,
                'productTranslationEntity',
                Join::WITH,
                'productTranslationEntity.productID = product.id'
            )

            ->leftJoin(
                StoreProductCategoryEntity::class,
                'storeProductCategoryEntity',
                Join::WITH,
                'storeProductCategoryEntity.id = product.storeProductCategoryID'
            )

            ->getQuery()
            ->getResult();
    }

    public function getProductsTranslationByCategoryIdAndStoreOwnerProfileIdForAdmin($storeProductCategoryID, $storeOwnerProfileId)
    {
        return $this->createQueryBuilder('product')

            ->select('product.id', 'product.productName as primaryProductName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID', 'product.discount',
                'product.description', 'product.status', 'product.productQuantity', 'product.commission', 'product.isCommission', 'productTranslationEntity.productName', 'productTranslationEntity.language')

            ->andWhere('product.storeProductCategoryID =:storeProductCategoryID')
            ->andWhere('product.storeOwnerProfileID =:storeOwnerProfileId')

            ->setParameter('storeProductCategoryID',$storeProductCategoryID)
            ->setParameter('storeOwnerProfileId',$storeOwnerProfileId)

            ->andWhere('product.status = :status')
            ->setParameter('status', self::STATUS_ACTIVE)

            ->leftJoin(
                ProductTranslationEntity::class,
                'productTranslationEntity',
                Join::WITH,
                'productTranslationEntity.productID = product.id'
            )

            ->getQuery()
            ->getResult();
    }

    public function getProducts()
    {
        return $this->createQueryBuilder('product')

            ->select('product.id', 'product.productName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID','product.discount', 'product.description')

            ->getQuery()
            ->getResult();
    }

    public function getProductByIdWithFullInfo($id)
    {
        return $this->createQueryBuilder('product')

            ->select('product.id', 'product.productName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID', 'product.description', 'product.status', 'product.discount', 'product.commission', 'product.isCommission')

            ->addSelect('storeOwnerProfile.id as storeOwnerProfileID', 'storeOwnerProfile.storeOwnerName as storeOwnerName','storeOwnerProfile.storeOwnerID', 'storeOwnerProfile.image', 'storeOwnerProfile.story', 'storeOwnerProfile.free', 'storeOwnerProfile.status', 'storeOwnerProfile.phone', 'storeOwnerProfile.storeOwnerID', 'storeOwnerProfile.commission as storeCommission')

            ->addSelect('storeOwnerBranch.location','storeOwnerBranch.branchName','storeOwnerBranch.city')

            ->addSelect('StoreProductCategoryEntity.productCategoryName','StoreProductCategoryEntity.isLevel1','StoreProductCategoryEntity.isLevel2')

            ->leftJoin(
                StoreOwnerProfileEntity::class,
                'storeOwnerProfile',
                Join::WITH,
                'storeOwnerProfile.id = product.storeOwnerProfileID')

            ->leftJoin(
                StoreOwnerBranchEntity::class,
                'storeOwnerBranch',
                Join::WITH,
                'storeOwnerBranch.storeOwnerProfileID = storeOwnerProfile.id ')

            ->leftJoin(
                StoreProductCategoryEntity::class,
                'StoreProductCategoryEntity',
                Join::WITH,
                'StoreProductCategoryEntity.id = product.storeProductCategoryID ')
            
            ->andWhere('product.id = :id')

            ->setParameter('id', $id)

            ->groupBy('product.id')

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getProductTranslationByProductIdWithFullInfo($id)
    {
        return $this->createQueryBuilder('product')

            ->select('product.id', 'product.productName as primaryProductName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID', 'product.description',
                'product.status', 'product.discount', 'productTranslationEntity.productName', 'productTranslationEntity.language', 'product.commission', 'product.isCommission')

            ->addSelect('storeOwnerProfile.id as storeOwnerProfileID', 'storeOwnerProfile.storeOwnerName as storeOwnerName','storeOwnerProfile.storeOwnerID', 'storeOwnerProfile.image', 'storeOwnerProfile.story', 'storeOwnerProfile.free', 'storeOwnerProfile.status', 'storeOwnerProfile.phone', 'storeOwnerProfile.storeOwnerID', 'storeOwnerProfile.commission as storeCommission')

            ->addSelect('storeOwnerBranch.location','storeOwnerBranch.branchName','storeOwnerBranch.city')

            ->addSelect('StoreProductCategoryEntity.productCategoryName','StoreProductCategoryEntity.isLevel1','StoreProductCategoryEntity.isLevel2')

            ->leftJoin(
                StoreOwnerProfileEntity::class,
                'storeOwnerProfile',
                Join::WITH,
                'storeOwnerProfile.id = product.storeOwnerProfileID')

            ->leftJoin(
                StoreOwnerBranchEntity::class,
                'storeOwnerBranch',
                Join::WITH,
                'storeOwnerBranch.storeOwnerProfileID = storeOwnerProfile.id ')

            ->leftJoin(
                ProductTranslationEntity::class,
                'productTranslationEntity',
                Join::WITH,
                'productTranslationEntity.productID = product.id'
            )

            ->leftJoin(
                StoreProductCategoryEntity::class,
                'StoreProductCategoryEntity',
                Join::WITH,
                'StoreProductCategoryEntity.id = product.storeProductCategoryID ')

            ->andWhere('product.id = :id')

            ->setParameter('id', $id)

            ->groupBy('product.id')

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getProductsTopWanted()
    {
        return $this->createQueryBuilder('product')

            ->select('product.id', 'product.productName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID','product.discount', 'product.description', 'product.commission', 'product.isCommission')
            ->addSelect('count(orderDetailEntity.productID) as countProduct, orderDetailEntity.productID')
            ->addSelect('storeOwnerProfile.id as storeOwnerProfileID', 'storeOwnerProfile.storeOwnerName as storeOwnerName', 'storeOwnerProfile.image', 'storeOwnerProfile.phone', 'storeOwnerProfile.status', 'storeOwnerProfile.commission as storeCommission')
            ->addSelect('storeOwnerBranch.location','storeOwnerBranch.branchName')
            ->addSelect('DeliveryCompanyFinancialEntity.deliveryCost')
//
            ->leftJoin(OrderDetailEntity::class, 'orderDetailEntity', Join::WITH, 'orderDetailEntity.productID = product.id')
            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfile', Join::WITH, 'storeOwnerProfile.id = product.storeOwnerProfileID')
            ->leftJoin(StoreOwnerBranchEntity::class, 'storeOwnerBranch', Join::WITH, 'storeOwnerBranch.storeOwnerProfileID = storeOwnerProfile.id ')
            ->leftJoin(DeliveryCompanyFinancialEntity::class, 'DeliveryCompanyFinancialEntity', Join::WITH, 'product.id = product.id')

            ->andWhere('orderDetailEntity.productID = product.id')
            ->andWhere('storeOwnerProfile.status = :status')

            ->setParameter('status', self::STATUS_ACTIVE)

            ->andWhere('product.status = :productStatus')
            ->setParameter('productStatus', ProductStatusConstant::$ACTIVE_PRODUCT_STATUS)

            ->addGroupBy('orderDetailEntity.productID')

            ->having('count(orderDetailEntity.productID) > 0')

            ->setMaxResults(20)

            ->addOrderBy('countProduct','DESC')

            ->getQuery()
            ->getResult();
    }

    public function getProductsTopWantedTranslations()
    {
        return $this->createQueryBuilder('product')

            ->select('product.id', 'product.productName as primaryProductName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID','product.discount', 'product.description', 'productTranslationEntity.productName', 'productTranslationEntity.language', 'product.commission', 'product.isCommission')
            ->addSelect('count(orderDetailEntity.productID) as countProduct, orderDetailEntity.productID')
            ->addSelect('storeOwnerProfile.id as storeOwnerProfileID', 'storeOwnerProfile.storeOwnerName as storeOwnerName', 'storeOwnerProfile.image', 'storeOwnerProfile.phone', 'storeOwnerProfile.status', 'storeOwnerProfile.commission as storeCommission')
            ->addSelect('storeOwnerBranch.location','storeOwnerBranch.branchName')
            ->addSelect('DeliveryCompanyFinancialEntity.deliveryCost')

            ->leftJoin(OrderDetailEntity::class, 'orderDetailEntity', Join::WITH, 'orderDetailEntity.productID = product.id')
            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfile', Join::WITH, 'storeOwnerProfile.id = product.storeOwnerProfileID')
            ->leftJoin(StoreOwnerBranchEntity::class, 'storeOwnerBranch', Join::WITH, 'storeOwnerBranch.storeOwnerProfileID = storeOwnerProfile.id ')
            ->leftJoin(DeliveryCompanyFinancialEntity::class, 'DeliveryCompanyFinancialEntity', Join::WITH, 'product.id = product.id')

            ->andWhere('orderDetailEntity.productID = product.id')
            ->andWhere('storeOwnerProfile.status = :status')

            ->setParameter('status', self::STATUS_ACTIVE)

            ->andWhere('product.status = :productStatus')
            ->setParameter('productStatus', ProductStatusConstant::$ACTIVE_PRODUCT_STATUS)

            ->leftJoin(
                ProductTranslationEntity::class,
                'productTranslationEntity',
                Join::WITH,
                'productTranslationEntity.productID = product.id'
            )

            ->addGroupBy('orderDetailEntity.productID')

            ->having('count(orderDetailEntity.productID) > 0')

            ->setMaxResults(20)

            ->addOrderBy('countProduct','DESC')

            ->getQuery()
            ->getResult();
    }

    public function productsTopWantedOfSpecificStoreOwner($storeOwnerProfileId)
    {
        return $this->createQueryBuilder('product')

             ->select('product.id', 'product.productName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID', 'product.discount','product.description', 'product.commission', 'product.isCommission')
            ->addSelect('count(orderDetailEntity.productID) as countProduct, orderDetailEntity.productID')
            ->addSelect('storeOwnerProfile.id as storeOwnerProfileID', 'storeOwnerProfile.storeOwnerName as storeOwnerName', 'storeOwnerProfile.image', 'storeOwnerProfile.phone', 'storeOwnerProfile.commission as storeCommission')
            ->addSelect('storeOwnerBranch.location','storeOwnerBranch.branchName')
            ->addSelect('DeliveryCompanyFinancialEntity.deliveryCost')

            ->leftJoin(OrderDetailEntity::class, 'orderDetailEntity', Join::WITH, 'orderDetailEntity.productID = product.id')
            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfile', Join::WITH, 'storeOwnerProfile.id = product.storeOwnerProfileID')
            ->leftJoin(StoreOwnerBranchEntity::class, 'storeOwnerBranch', Join::WITH, 'storeOwnerBranch.storeOwnerProfileID = storeOwnerProfile.id ')
            ->leftJoin(DeliveryCompanyFinancialEntity::class, 'DeliveryCompanyFinancialEntity', Join::WITH, 'product.id = product.id')

            ->andWhere('product.storeOwnerProfileID = :storeOwnerProfileId')

            ->andWhere('product.status = :productStatus')
            ->setParameter('productStatus', ProductStatusConstant::$ACTIVE_PRODUCT_STATUS)

            ->andWhere('storeOwnerProfile.status = :status')
            ->setParameter('status', StoreStatusConstant::$ACTIVE_STORE_STATUS)

            ->addGroupBy('orderDetailEntity.productID')

            ->having('count(orderDetailEntity.productID) > 0')

            ->setMaxResults(20)

            ->setParameter('storeOwnerProfileId',$storeOwnerProfileId)

            ->addOrderBy('countProduct','DESC')

            ->getQuery()
            ->getResult();
    }

    public function productsTopWantedOfSpecificStoreOwnerTranslation($storeOwnerProfileId)
    {
        return $this->createQueryBuilder('product')

            ->select('product.id', 'product.productName as primaryProductName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID', 'product.discount','product.description',
                'product.commission', 'product.isCommission', 'productTranslationEntity.productName', 'productTranslationEntity.language')
            ->addSelect('count(orderDetailEntity.productID) as countProduct, orderDetailEntity.productID')
            ->addSelect('storeOwnerProfile.id as storeOwnerProfileID', 'storeOwnerProfile.storeOwnerName as storeOwnerName', 'storeOwnerProfile.image', 'storeOwnerProfile.phone', 'storeOwnerProfile.commission as storeCommission')
            ->addSelect('storeOwnerBranch.location','storeOwnerBranch.branchName')
            ->addSelect('DeliveryCompanyFinancialEntity.deliveryCost')

            ->leftJoin(OrderDetailEntity::class, 'orderDetailEntity', Join::WITH, 'orderDetailEntity.productID = product.id')
            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfile', Join::WITH, 'storeOwnerProfile.id = product.storeOwnerProfileID')
            ->leftJoin(StoreOwnerBranchEntity::class, 'storeOwnerBranch', Join::WITH, 'storeOwnerBranch.storeOwnerProfileID = storeOwnerProfile.id ')
            ->leftJoin(DeliveryCompanyFinancialEntity::class, 'DeliveryCompanyFinancialEntity', Join::WITH, 'product.id = product.id')

            ->andWhere('product.storeOwnerProfileID = :storeOwnerProfileId')
            ->setParameter('storeOwnerProfileId',$storeOwnerProfileId)

            ->andWhere('product.status = :productStatus')
            ->setParameter('productStatus', ProductStatusConstant::$ACTIVE_PRODUCT_STATUS)

            ->andWhere('storeOwnerProfile.status = :status')
            ->setParameter('status', StoreStatusConstant::$ACTIVE_STORE_STATUS)

            ->leftJoin(
                ProductTranslationEntity::class,
                'productTranslationEntity',
                Join::WITH,
                'productTranslationEntity.productID = product.id'
            )

            ->addGroupBy('orderDetailEntity.productID')

            ->having('count(orderDetailEntity.productID) > 0')

            ->setMaxResults(20)

            ->addOrderBy('countProduct','DESC')

            ->getQuery()
            ->getResult();
    }

    public function getStoreProductsByProfileId($storeOwnerProfileId)
    {
        return $this->createQueryBuilder('product')
            ->select('product.id', 'product.productName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID', 'product.discount','product.description', 'product.commission', 'product.isCommission')
            ->addSelect('storeOwnerProfile.id as storeOwnerProfileID', 'storeOwnerProfile.storeOwnerName as storeOwnerName', 'storeOwnerProfile.image', 'storeOwnerProfile.phone', 'storeOwnerProfile.commission as storeCommission')

            ->andWhere('product.storeOwnerProfileID = :storeOwnerProfileId')

            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfile', Join::WITH, 'storeOwnerProfile.id = product.storeOwnerProfileID')

            ->andWhere('product.status = :status')

            ->setParameter('status', ProductStatusConstant::$ACTIVE_PRODUCT_STATUS)

            ->setParameter('storeOwnerProfileId',$storeOwnerProfileId)

            ->getQuery()
            ->getResult();
    }

    public function getStoreProductsTranslationByProfileId($storeOwnerProfileId)
    {
        return $this->createQueryBuilder('product')
            ->select('product.id', 'product.productName as primaryProductName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID', 'product.discount','product.description',
                'product.commission', 'product.isCommission', 'productTranslationEntity.productName', 'productTranslationEntity.language')
            ->addSelect('storeOwnerProfile.id as storeOwnerProfileID', 'storeOwnerProfile.storeOwnerName as storeOwnerName', 'storeOwnerProfile.image', 'storeOwnerProfile.phone', 'storeOwnerProfile.commission as storeCommission')

            ->andWhere('product.storeOwnerProfileID = :storeOwnerProfileId')
            ->setParameter('storeOwnerProfileId',$storeOwnerProfileId)

            ->leftJoin(StoreOwnerProfileEntity::class,
                'storeOwnerProfile',
                Join::WITH,
                'storeOwnerProfile.id = product.storeOwnerProfileID')

            ->leftJoin(
                ProductTranslationEntity::class,
                'productTranslationEntity',
                Join::WITH,
                'productTranslationEntity.productID = product.id'
            )

            ->getQuery()
            ->getResult();
    }

    public function getStoreProducts($storeOwnerProfileId)
    {
        return $this->createQueryBuilder('product')
            ->select('product.id', 'product.productName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID', 'product.discount',
            'product.description', 'product.status', 'product.productQuantity', 'product.commission', 'product.isCommission', 'storeProductCategoryEntity.isLevel1', 'storeProductCategoryEntity.isLevel2')
            ->addSelect('storeOwnerProfile.id as storeOwnerProfileID', 'storeOwnerProfile.storeOwnerName as storeOwnerName', 'storeOwnerProfile.image', 'storeOwnerProfile.phone', 'storeOwnerProfile.commission as storeCommission')

            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfile', Join::WITH, 'storeOwnerProfile.id = product.storeOwnerProfileID')

            ->leftJoin(
                StoreProductCategoryEntity::class,
                'storeProductCategoryEntity',
                Join::WITH,
                'storeProductCategoryEntity.id = product.storeProductCategoryID'
            )

            ->andWhere('product.storeOwnerProfileID = :storeOwnerProfileId')
            ->setParameter('storeOwnerProfileId',$storeOwnerProfileId)

            ->andWhere('product.status = :status')
            ->setParameter('status', self::STATUS_ACTIVE)

            ->getQuery()
            ->getResult();
    }

    public function getProductsByStoreProductCategoryID($storeProductCategoryID)
    {
        return $this->createQueryBuilder('product')
                ->select('product.id', 'product.productName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID', 'product.discount','product.description','product.status',
         'product.productQuantity', 'product.commission', 'product.isCommission', 'storeProductCategoryEntity.isLevel1', 'storeProductCategoryEntity.isLevel2')
                ->addSelect('storeOwnerProfile.id as storeOwnerProfileID', 'storeOwnerProfile.storeOwnerName as storeOwnerName', 'storeOwnerProfile.image', 'storeOwnerProfile.phone', 'storeOwnerProfile.commission as storeCommission')

                ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfile', Join::WITH, 'storeOwnerProfile.id = product.storeOwnerProfileID')

                ->leftJoin(
                    StoreProductCategoryEntity::class,
                    'storeProductCategoryEntity',
                    Join::WITH,
                    'storeProductCategoryEntity.id = product.storeProductCategoryID'
                )

                ->andWhere('product.storeProductCategoryID = :storeProductCategoryID')
                ->andWhere('product.status = :status')
                ->andWhere('storeOwnerProfile.status = :storeStatus')

                ->setParameter('storeProductCategoryID', $storeProductCategoryID)
                ->setParameter('status', ProductStatusConstant::$ACTIVE_PRODUCT_STATUS)
                ->setParameter('storeStatus', StoreStatusConstant::$ACTIVE_STORE_STATUS)

                ->getQuery()
                ->getResult();
    }

    public function getProductsByStoreProductCategoryIDAndStoreOwnerProfileID($storeProductCategoryID, $storeOwnerProfileID)
    {
        return $this->createQueryBuilder('product')
                ->select('product.id', 'product.productName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID', 'product.discount','product.description','product.status',
         'product.productQuantity', 'product.commission', 'product.isCommission', 'storeProductCategoryEntity.isLevel1', 'storeProductCategoryEntity.isLevel2')
                ->addSelect('storeOwnerProfile.id as storeOwnerProfileID', 'storeOwnerProfile.storeOwnerName as storeOwnerName', 'storeOwnerProfile.image', 'storeOwnerProfile.phone', 'storeOwnerProfile.commission as storeCommission')

                ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfile', Join::WITH, 'storeOwnerProfile.id = product.storeOwnerProfileID')

                ->leftJoin(
                    StoreProductCategoryEntity::class,
                    'storeProductCategoryEntity',
                    Join::WITH,
                    'storeProductCategoryEntity.id = product.storeProductCategoryID'
                )

                ->andWhere('product.storeProductCategoryID = :storeProductCategoryID')
                ->andWhere('product.status = :status')
                ->andWhere('product.storeOwnerProfileID = :storeOwnerProfileID')
                ->andWhere('storeOwnerProfile.status = :storeStatus')

                ->setParameter('storeProductCategoryID', $storeProductCategoryID)
                ->setParameter('status', ProductStatusConstant::$ACTIVE_PRODUCT_STATUS)
                ->setParameter('storeStatus', StoreStatusConstant::$ACTIVE_STORE_STATUS)
                ->setParameter('storeOwnerProfileID', $storeOwnerProfileID)

                ->getQuery()
                ->getResult();
    }

    // for dashboard
    public function getProductsTranslationByStoreProductCategoryID($storeProductCategoryID)
    {
        return $this->createQueryBuilder('product')
            ->select('product.id', 'product.productName as primaryProductName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID', 'product.discount','product.description','product.status',
                'product.productQuantity', 'productTranslationEntity.productName', 'productTranslationEntity.language', 'product.commission', 'product.isCommission', 'storeProductCategoryEntity.isLevel1', 'storeProductCategoryEntity.isLevel2')
            ->addSelect('storeOwnerProfile.id as storeOwnerProfileID', 'storeOwnerProfile.storeOwnerName as storeOwnerName', 'storeOwnerProfile.image', 'storeOwnerProfile.phone', 'storeOwnerProfile.commission as storeCommission')

            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfile', Join::WITH, 'storeOwnerProfile.id = product.storeOwnerProfileID')

            ->leftJoin(
                StoreProductCategoryEntity::class,
                'storeProductCategoryEntity',
                Join::WITH,
                'storeProductCategoryEntity.id = product.storeProductCategoryID'
            )

            ->andWhere('product.storeProductCategoryID = :storeProductCategoryID')
            ->andWhere('product.status = :status')
            ->andWhere('storeOwnerProfile.status = :storeStatus')

            ->setParameter('storeProductCategoryID', $storeProductCategoryID)
            ->setParameter('status', ProductStatusConstant::$ACTIVE_PRODUCT_STATUS)
            ->setParameter('storeStatus', StoreStatusConstant::$ACTIVE_STORE_STATUS)

            ->leftJoin(
                ProductTranslationEntity::class,
                'productTranslationEntity',
                Join::WITH,
                'productTranslationEntity.productID = product.id'
            )

            ->getQuery()
            ->getResult();
    }

    public function getProductsByStoreProductCategoryIDForStore($storeProductCategoryID, $storeOwnerProfileID)
    {
        return $this->createQueryBuilder('product')

            ->select('product.id', 'product.productName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID', 'product.discount','product.description','product.status', 'product.productQuantity', 'product.commission', 'product.isCommission',
                'storeProductCategoryEntity.isLevel1', 'storeProductCategoryEntity.isLevel2')
            ->addSelect('storeOwnerProfile.id as storeOwnerProfileID', 'storeOwnerProfile.storeOwnerName as storeOwnerName', 'storeOwnerProfile.image', 'storeOwnerProfile.phone', 'storeOwnerProfile.commission as storeCommission')

            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfile', Join::WITH, 'storeOwnerProfile.id = product.storeOwnerProfileID')

            ->leftJoin(
                StoreProductCategoryEntity::class,
                'storeProductCategoryEntity',
                Join::WITH,
                'storeProductCategoryEntity.id = product.storeProductCategoryID'
            )

            ->andWhere('product.storeProductCategoryID = :storeProductCategoryID')
            ->andWhere('product.storeOwnerProfileID = :storeOwnerProfileID')
            ->andWhere('product.status = :status')

            ->setParameter('storeProductCategoryID', $storeProductCategoryID)
            ->setParameter('storeOwnerProfileID', $storeOwnerProfileID)
            ->setParameter('status', self::STATUS_ACTIVE)

            ->getQuery()
            ->getResult();
    }


    public function getCategoryLinkByStoreProductCategoryID($storeProductCategoryID)
    {
        return $this->createQueryBuilder('product')

            ->select('categoryLinkEntity.subCategoryLevelOneID', 'categoryLinkEntity.subCategoryLevelTwoID')

            ->leftJoin(
                CategoryLinkEntity::class,
                'categoryLinkEntity',
                Join::WITH,
                'categoryLinkEntity.subCategoryLevelOneID = :storeProductCategoryID 
                or categoryLinkEntity.subCategoryLevelTwoID = :storeProductCategoryID'
            )

            ->andWhere('categoryLinkEntity.linkType = :linkType')

            ->setParameter('linkType', CategoryLinkConstant::$LEVEL_ONE_LEVEL_TWO)
            ->setParameter('storeProductCategoryID', $storeProductCategoryID)

            ->groupBy('categoryLinkEntity.id')

            ->getQuery()
            ->getResult();
    }

    public function getProductsTranslationsByStoreProductCategoryIDForStore($storeProductCategoryID, $storeOwnerProfileID)
    {
        return $this->createQueryBuilder('product')

            ->select('product.id', 'product.productName as primaryProductName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID', 'product.discount',
                'product.description','product.status', 'product.productQuantity', 'productTranslationEntity.productName', 'productTranslationEntity.language', 'product.commission', 'product.isCommission', 'storeProductCategoryEntity.isLevel1', 'storeProductCategoryEntity.isLevel2')
            ->addSelect('storeOwnerProfile.id as storeOwnerProfileID', 'storeOwnerProfile.storeOwnerName as storeOwnerName', 'storeOwnerProfile.image', 'storeOwnerProfile.phone', 'storeOwnerProfile.commission as storeCommission')

            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfile', Join::WITH, 'storeOwnerProfile.id = product.storeOwnerProfileID')

            ->andWhere('product.storeProductCategoryID = :storeProductCategoryID')
            ->andWhere('product.storeOwnerProfileID = :storeOwnerProfileID')
            ->andWhere('product.status = :status')

            ->setParameter('storeProductCategoryID', $storeProductCategoryID)
            ->setParameter('storeOwnerProfileID', $storeOwnerProfileID)
            ->setParameter('status', self::STATUS_ACTIVE)

            ->leftJoin(
                ProductTranslationEntity::class,
                'productTranslationEntity',
                Join::WITH,
                'productTranslationEntity.productID = product.id'
            )

            ->leftJoin(
                StoreProductCategoryEntity::class,
                'storeProductCategoryEntity',
                Join::WITH,
                'storeProductCategoryEntity.id = product.storeProductCategoryID'
            )

            ->getQuery()
            ->getResult();
    }

    public function getProductsByStoreProfileIDAndStoreProductCategoryID($storeOwnerProfileID, $storeProductCategoryID)
    {
        return $this->createQueryBuilder('product')

            ->select('product.id', 'product.productName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID', 'product.discount', 'product.description', 'product.status')

            ->andWhere('product.storeProductCategoryID = :storeProductCategoryID')
            ->andWhere('product.storeOwnerProfileID = :storeOwnerProfileID')

            ->setParameter('storeProductCategoryID',$storeProductCategoryID)
            ->setParameter('storeOwnerProfileID',$storeOwnerProfileID)

            ->getQuery()
            ->getResult();
    }

    public function countProducts()
    {
        return $this->createQueryBuilder('product')
            ->select('count(product.id) as countProducts')

            ->getQuery()
            ->getSingleScalarResult();
    }

    public function getProductsByName($name)
    {
        return $this->createQueryBuilder('product')

            ->select('product.id', 'product.productName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID','product.discount', 'product.description', 'product.productQuantity', 'product.status', 'product.commission', 'product.isCommission')
            ->addSelect('storeOwnerProfile.id as storeOwnerProfileID', 'storeOwnerProfile.storeOwnerName as storeOwnerName', 'storeOwnerProfile.image as storeImage', 'storeOwnerProfile.commission as storeCommission')
            ->addSelect('DeliveryCompanyFinancialEntity.deliveryCost')
            
            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfile', Join::WITH, 'storeOwnerProfile.id = product.storeOwnerProfileID')
            ->leftJoin(DeliveryCompanyFinancialEntity::class, 'DeliveryCompanyFinancialEntity', Join::WITH, 'product.id = product.id')
           
            ->andWhere('product.productName LIKE :productName')
            ->andWhere('product.status= :status')
            ->andWhere('storeOwnerProfile.status= :status')

            ->setParameter('productName', '%'.$name.'%')
            ->setParameter('status', self::STATUS_ACTIVE)

            ->setMaxResults(20)

            ->getQuery()
            ->getResult();
    }

    public function getProductsByNameAndStoreOwnerProfileId($name, $storeOwnerProfileId)
    {
        return $this->createQueryBuilder('product')

            ->select('product.id', 'product.productName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID','product.discount', 'product.description', 'product.productQuantity', 'product.status',
                'product.commission', 'product.isCommission', 'storeProductCategoryEntity.isLevel1', 'storeProductCategoryEntity.isLevel2')
            ->addSelect('storeOwnerProfile.id as storeOwnerProfileID', 'storeOwnerProfile.storeOwnerName as storeOwnerName', 'storeOwnerProfile.image as storeImage', 'storeOwnerProfile.commission as storeCommission')

            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfile', Join::WITH, 'storeOwnerProfile.id = product.storeOwnerProfileID')

            ->leftJoin(
                StoreProductCategoryEntity::class,
                'storeProductCategoryEntity',
                Join::WITH,
                'storeProductCategoryEntity.id = product.storeProductCategoryID'
            )

            ->andWhere('product.productName LIKE :productName')
            ->andWhere('product.storeOwnerProfileID = :storeOwnerProfileId')

            ->setParameter('productName', '%'.$name.'%')
            ->setParameter('storeOwnerProfileId', $storeOwnerProfileId)

            ->andWhere('product.status = :status')
            ->setParameter('status', self::STATUS_ACTIVE)

            ->setMaxResults(20)

            ->getQuery()
            ->getResult();
    }

    public function getProductsTranslationByTranslatedNameAndStoreOwnerProfileId($name, $storeOwnerProfileId)
    {
        return $this->createQueryBuilder('product')

            ->select('product.id', 'product.productName as primaryProductName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID','product.discount', 'product.description', 'product.productQuantity', 'product.status',
                'product.commission', 'product.isCommission', 'storeProductCategoryEntity.isLevel1', 'storeProductCategoryEntity.isLevel2')
            ->addSelect('storeOwnerProfile.id as storeOwnerProfileID', 'storeOwnerProfile.storeOwnerName as storeOwnerName', 'storeOwnerProfile.image as storeImage',
                'productTranslationEntity.productName', 'productTranslationEntity.language', 'storeOwnerProfile.commission as storeCommission')

            ->leftJoin(StoreOwnerProfileEntity::class,
                'storeOwnerProfile',
                Join::WITH,
                'storeOwnerProfile.id = product.storeOwnerProfileID')

            ->leftJoin(
                ProductTranslationEntity::class,
                'productTranslationEntity',
                Join::WITH,
                'productTranslationEntity.productID = product.id'
            )

            ->leftJoin(
                StoreProductCategoryEntity::class,
                'storeProductCategoryEntity',
                Join::WITH,
                'storeProductCategoryEntity.id = product.storeProductCategoryID'
            )

            ->andWhere('productTranslationEntity.productName LIKE :productName')
            ->andWhere('product.storeOwnerProfileID = :storeOwnerProfileId')

            ->setParameter('productName', '%'.$name.'%')
            ->setParameter('storeOwnerProfileId', $storeOwnerProfileId)

            ->andWhere('product.status = :status')
            ->setParameter('status', self::STATUS_ACTIVE)

            ->setMaxResults(20)

            ->getQuery()
            ->getResult();
    }

    public function getProductsTranslationByStoreOwnerProfileId($storeOwnerProfileId)
    {
        return $this->createQueryBuilder('product')

            ->select('product.id', 'product.productName as primaryProductName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID','product.discount', 'product.description', 'product.productQuantity', 'product.status',
                'product.commission', 'product.isCommission', 'storeProductCategoryEntity.isLevel1', 'storeProductCategoryEntity.isLevel2')
            ->addSelect('storeOwnerProfile.id as storeOwnerProfileID', 'storeOwnerProfile.storeOwnerName as storeOwnerName', 'storeOwnerProfile.image as storeImage',
                'productTranslationEntity.productName', 'productTranslationEntity.language', 'storeOwnerProfile.commission as storeCommission')

            ->leftJoin(StoreOwnerProfileEntity::class,
                'storeOwnerProfile',
                Join::WITH,
                'storeOwnerProfile.id = product.storeOwnerProfileID')

            ->leftJoin(
                ProductTranslationEntity::class,
                'productTranslationEntity',
                Join::WITH,
                'productTranslationEntity.productID = product.id'
            )

            ->leftJoin(
                StoreProductCategoryEntity::class,
                'storeProductCategoryEntity',
                Join::WITH,
                'storeProductCategoryEntity.id = product.storeProductCategoryID'
            )

            ->andWhere('product.storeOwnerProfileID = :storeOwnerProfileId')
            ->setParameter('storeOwnerProfileId', $storeOwnerProfileId)

            ->andWhere('product.status = :status')
            ->setParameter('status', self::STATUS_ACTIVE)

            ->setMaxResults(20)

            ->getQuery()
            ->getResult();
    }

    public function getStoreProductCategoryIdLevel2($storeProductCategoryId)
    {
        return $this->createQueryBuilder('product')
                ->addSelect('StoreProductCategoryEntity.storeCategoryID','StoreProductCategoryEntity.storeProductCategoryID','StoreProductCategoryEntity.id')
                ->leftJoin(StoreProductCategoryEntity::class, 'StoreProductCategoryEntity', Join::WITH, 'StoreProductCategoryEntity.id = product.storeProductCategoryID')

                ->andWhere('StoreProductCategoryEntity.isLevel2 = :isLevel2')
                ->andWhere('StoreProductCategoryEntity.storeProductCategoryID = :storeProductCategoryId')

                ->setParameter('isLevel2',1)
                ->setParameter('storeProductCategoryId',$storeProductCategoryId)


                ->getQuery()
                ->getResult();
    }

    public function getStoreProductCategoryIdOfLevel1($storeCategoryID, $storeProductCategoryId)
    {
        return $this->createQueryBuilder('product')

            ->select('product.id', 'product.productName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID','product.discount', 'product.description')

            ->join(StoreProductCategoryEntity::class, 'StoreProductCategoryEntity')

            ->andWhere('StoreProductCategoryEntity.id = :storeProductCategoryId')
            ->andWhere('StoreProductCategoryEntity.storeCategoryID = :storeCategoryID')
            ->andWhere('StoreProductCategoryEntity.storeCategoryID = :storeCategoryID')

            ->setParameter('storeProductCategoryId',$storeProductCategoryId)
            ->setParameter('storeCategoryID',$storeCategoryID)

            ->getQuery()
            ->getResult();
    }

    public function getStoreProductCategoryIdLevel1ByIdOfLevelTwo($storeProductCategoryID)
    {
        return $this->createQueryBuilder('product')

            ->select('StoreProductCategoryEntity.storeProductCategoryID')

            ->leftJoin(StoreProductCategoryEntity::class, 'StoreProductCategoryEntity', Join::WITH, 'StoreProductCategoryEntity.id = product.storeProductCategoryID')

            ->andWhere('StoreProductCategoryEntity.id = :storeProductCategoryID')

            ->setParameter('storeProductCategoryID',$storeProductCategoryID)

            ->groupBy('StoreProductCategoryEntity.id')

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getProductsByStoreProductCategoryIDLevelOne($storeProductCategoryIdLevel1)
    {
        return $this->createQueryBuilder('product')

            ->select('product.id', 'product.productName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID','product.discount', 'product.description', 'product.status', 'product.productQuantity', 'product.commission', 'product.isCommission')
            ->addSelect('storeOwnerProfile.id as storeOwnerProfileID', 'storeOwnerProfile.storeOwnerName as storeOwnerName', 'storeOwnerProfile.image as storeImage', 'storeOwnerProfile.commission as storeCommission')

            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfile', Join::WITH, 'storeOwnerProfile.id = product.storeOwnerProfileID')

            ->leftJoin(StoreProductCategoryEntity::class, 'StoreProductCategoryEntity', Join::WITH, 'StoreProductCategoryEntity.id = product.storeProductCategoryID')

            ->andWhere('product.storeProductCategoryID = :storeProductCategoryIdLevel1')
            ->andWhere('storeOwnerProfile.status = :statusStore')
            ->andWhere('product.status = :status')

            ->setParameter('storeProductCategoryIdLevel1',$storeProductCategoryIdLevel1)
            ->setParameter('statusStore',StoreStatusConstant::$ACTIVE_STORE_STATUS)
            ->setParameter('status',ProductStatusConstant::$ACTIVE_PRODUCT_STATUS)

            ->groupBy('StoreProductCategoryEntity.id')

            ->getQuery()
            ->getResult();
    }

    public function getProductsTranslationByStoreProductCategoryIDLevelOne($storeProductCategoryIdLevel1)
    {
        return $this->createQueryBuilder('product')

            ->select('product.id', 'product.productName as primaryProductName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID','product.discount', 'product.description', 'product.status', 'product.productQuantity',
                'product.commission', 'product.isCommission', 'productTranslationEntity.productName', 'productTranslationEntity.language')
            ->addSelect('storeOwnerProfile.id as storeOwnerProfileID', 'storeOwnerProfile.storeOwnerName as storeOwnerName', 'storeOwnerProfile.image as storeImage', 'storeOwnerProfile.commission as storeCommission')

            ->leftJoin(
                StoreOwnerProfileEntity::class,
                'storeOwnerProfile',
                Join::WITH,
                'storeOwnerProfile.id = product.storeOwnerProfileID'
            )

            ->leftJoin(
                StoreProductCategoryEntity::class,
                'StoreProductCategoryEntity',
                Join::WITH,
                'StoreProductCategoryEntity.id = product.storeProductCategoryID'
            )

            ->leftJoin(
                ProductTranslationEntity::class,
                'productTranslationEntity',
                Join::WITH,
                'productTranslationEntity.productID = product.id'
            )

            ->andWhere('product.storeProductCategoryID = :storeProductCategoryIdLevel1')
            ->andWhere('storeOwnerProfile.status = :statusStore')
            ->andWhere('product.status = :store')

            ->setParameter('storeProductCategoryIdLevel1',$storeProductCategoryIdLevel1)
            ->setParameter('statusStore',StoreStatusConstant::$ACTIVE_STORE_STATUS)
            ->setParameter('store',ProductStatusConstant::$ACTIVE_PRODUCT_STATUS)

            ->groupBy('StoreProductCategoryEntity.id')

            ->getQuery()
            ->getResult();
    }

    public function getProductsSoldCount($id)
    {
        return $this->createQueryBuilder('product')

            ->select('sum(orderDetailEntity.countProduct) as soldCount')

            ->leftJoin(OrderDetailEntity::class, 'orderDetailEntity', Join::WITH, 'orderDetailEntity.productID = product.id')

            ->andWhere('product.id = :id')

            ->setParameter('id',$id)

            ->getQuery()
            ->getSingleScalarResult();
    }

    public function getLast30Products()
    {
        return $this->createQueryBuilder('product')

            ->select('product.id', 'product.productName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID', 'product.discount',
                'product.description', 'product.status', 'product.productQuantity', 'product.commission', 'product.isCommission')
            ->addSelect('storeOwnerProfile.id as storeOwnerProfileID', 'storeOwnerProfile.storeOwnerName as storeOwnerName', 'storeOwnerProfile.image as storeImage', 'storeOwnerProfile.commission as storeCommission')

            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfile', Join::WITH, 'storeOwnerProfile.id = product.storeOwnerProfileID')

            ->andWhere('product.status = :active')

            ->setParameter('active',self::STATUS_ACTIVE)

            ->addOrderBy('product.id','DESC')

            ->setMaxResults(30)

            ->getQuery()
            ->getResult();
    }

    public function getLast30ProductsTranslation()
    {
        return $this->createQueryBuilder('product')

            ->select('product.id', 'product.productImage', 'product.productName as primaryProductName', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID', 'product.discount',
                'product.description', 'product.status', 'product.productQuantity', 'productTranslationEntity.productName', 'productTranslationEntity.language', 'product.commission', 'product.isCommission')
            ->addSelect('storeOwnerProfile.id as storeOwnerProfileID', 'storeOwnerProfile.storeOwnerName as storeOwnerName', 'storeOwnerProfile.image as storeImage', 'storeOwnerProfile.commission as storeCommission')

            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfile', Join::WITH, 'storeOwnerProfile.id = product.storeOwnerProfileID')

            ->andWhere('product.status = :active')
            ->setParameter('active',self::STATUS_ACTIVE)

            ->leftJoin(
                ProductTranslationEntity::class,
                'productTranslationEntity',
                Join::WITH,
                'productTranslationEntity.productID = product.id'
            )

            ->addOrderBy('product.id','DESC')
            ->setMaxResults(30)

            ->getQuery()
            ->getResult();
    }

    public function getProductsStoreOwnerProfileId($storeOwnerProfileId)
    {
        return $this->createQueryBuilder('product')

            ->select('product.id', 'product.productName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID', 'product.discount', 'product.description', 'product.status', 'product.productQuantity', 'product.commission', 'product.isCommission')
            ->addSelect('storeOwnerProfile.id as storeOwnerProfileID', 'storeOwnerProfile.storeOwnerName as storeOwnerName', 'storeOwnerProfile.image as storeImage', 'storeOwnerProfile.commission as storeCommission')

            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfile', Join::WITH, 'storeOwnerProfile.id = product.storeOwnerProfileID')

            ->andWhere('product.storeOwnerProfileID =:storeOwnerProfileId')
            ->setParameter('storeOwnerProfileId',$storeOwnerProfileId)

            ->andWhere('product.status = :status')
            ->setParameter('status', ProductStatusConstant::$ACTIVE_PRODUCT_STATUS)

            ->andWhere('storeOwnerProfile.status = :status')
            ->setParameter('status', StoreStatusConstant::$ACTIVE_STORE_STATUS)

            ->getQuery()
            ->getResult();
    }

    public function getProductsTranslationsByStoreOwnerProfileId($storeOwnerProfileId)
    {
        return $this->createQueryBuilder('product')

            ->select('product.id', 'product.productName as primaryProductName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID', 'product.discount',
                'product.description', 'product.status', 'product.productQuantity', 'productTranslationEntity.productName', 'productTranslationEntity.language', 'product.commission', 'product.isCommission')
            ->addSelect('storeOwnerProfile.id as storeOwnerProfileID', 'storeOwnerProfile.storeOwnerName as storeOwnerName', 'storeOwnerProfile.image as storeImage', 'storeOwnerProfile.commission as storeCommission')

            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfile', Join::WITH, 'storeOwnerProfile.id = product.storeOwnerProfileID')

            ->andWhere('product.storeOwnerProfileID =:storeOwnerProfileId')
            ->setParameter('storeOwnerProfileId', $storeOwnerProfileId)

            ->andWhere('product.status = :status')
            ->setParameter('status', ProductStatusConstant::$ACTIVE_PRODUCT_STATUS)

            ->andWhere('storeOwnerProfile.status = :status')
            ->setParameter('status', StoreStatusConstant::$ACTIVE_STORE_STATUS)

            ->leftJoin(
                ProductTranslationEntity::class,
                'productTranslationEntity',
                Join::WITH,
                'productTranslationEntity.productID = product.id'
            )

            ->getQuery()
            ->getResult();
    }

    public function doesStoreOwnProduct($storeProfileID, $productID)
    {
        return $this->createQueryBuilder('product')

            ->select('product.productName')

            ->andWhere('product.storeOwnerProfileID =:storeOwnerProfileId')
            ->andWhere('product.id =:productID')
            ->setParameter('storeOwnerProfileId',$storeProfileID)
            ->setParameter('productID',$productID)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getStoreOwnersProfilesIDsByStoreProductCategoriesIDs($storeProductsCategoriesIDsArray)
    {
        return $this->createQueryBuilder('product')
            ->select('DISTINCT(product.storeOwnerProfileID)')

            ->andWhere('product.storeProductCategoryID IN (:storeProductsCategoriesIDsArray)')
            ->setParameter('storeProductsCategoriesIDsArray', $storeProductsCategoriesIDsArray)

            ->getQuery()
            ->getResult();
    }
}
