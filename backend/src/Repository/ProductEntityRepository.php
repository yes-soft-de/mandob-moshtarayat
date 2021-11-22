<?php

namespace App\Repository;

use App\Entity\ProductEntity;
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

    public function getProductsByCategoryIdAndStoreOwnerProfileId($storeProductCategoryID, $storeOwnerProfileId)
    {
        return $this->createQueryBuilder('product')
            ->select('product.id', 'product.productName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID','product.discount','product.description')

            ->andWhere('product.storeProductCategoryID =:storeProductCategoryID')
            ->andWhere('product.storeOwnerProfileID =:storeOwnerProfileId')

            ->setParameter('storeProductCategoryID',$storeProductCategoryID)
            ->setParameter('storeOwnerProfileId',$storeOwnerProfileId)
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
            ->select('product.id', 'product.productName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID', 'product.description', 'product.status')

            ->addSelect('storeOwnerProfile.id as storeOwnerProfileID', 'storeOwnerProfile.storeOwnerName as storeOwnerName','storeOwnerProfile.storeOwnerID', 'storeOwnerProfile.image', 'storeOwnerProfile.story', 'storeOwnerProfile.free', 'storeOwnerProfile.status', 'storeOwnerProfile.phone', 'storeOwnerProfile.storeOwnerID')

            ->addSelect('storeOwnerBranch.location','storeOwnerBranch.branchName','storeOwnerBranch.city')

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
            
            ->andWhere('product.id = :id')
            ->setParameter('id', $id)

            ->groupBy('product.id')

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getProductsTopWanted()
    {
        return $this->createQueryBuilder('product')
            ->select('product.id', 'product.productName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID','product.discount', 'product.description')

            ->addSelect('count(orderDetailEntity.productID) as countProduct, orderDetailEntity.productID')

            ->addSelect('storeOwnerProfile.id as storeOwnerProfileID', 'storeOwnerProfile.storeOwnerName as storeOwnerName', 'storeOwnerProfile.image', 'storeOwnerProfile.phone', 'storeOwnerProfile.status')

            ->addSelect('storeOwnerBranch.location','storeOwnerBranch.branchName')

            ->addSelect('DeliveryCompanyFinancialEntity.deliveryCost')

            ->leftJoin(OrderDetailEntity::class, 'orderDetailEntity', Join::WITH, 'orderDetailEntity.productID = product.id')

            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfile', Join::WITH, 'storeOwnerProfile.id = product.storeOwnerProfileID')
            
            ->leftJoin(StoreOwnerBranchEntity::class, 'storeOwnerBranch', Join::WITH, 'storeOwnerBranch.storeOwnerProfileID = storeOwnerProfile.id ')

            ->leftJoin(DeliveryCompanyFinancialEntity::class, 'DeliveryCompanyFinancialEntity', Join::WITH, 'product.id = product.id')

            ->andWhere('orderDetailEntity.productID = product.id')
            ->andWhere('storeOwnerProfile.status = :status')
            ->setParameter('status', self::STATUS_ACTIVE)

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
             ->select('product.id', 'product.productName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID', 'product.discount','product.description')

            ->addSelect('count(orderDetailEntity.productID) as countProduct, orderDetailEntity.productID')

            ->addSelect('storeOwnerProfile.id as storeOwnerProfileID', 'storeOwnerProfile.storeOwnerName as storeOwnerName', 'storeOwnerProfile.image', 'storeOwnerProfile.phone')

            ->addSelect('storeOwnerBranch.location','storeOwnerBranch.branchName')

            ->addSelect('DeliveryCompanyFinancialEntity.deliveryCost')

            ->leftJoin(OrderDetailEntity::class, 'orderDetailEntity', Join::WITH, 'orderDetailEntity.productID = product.id')
            
            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfile', Join::WITH, 'storeOwnerProfile.id = product.storeOwnerProfileID')
            
            ->leftJoin(StoreOwnerBranchEntity::class, 'storeOwnerBranch', Join::WITH, 'storeOwnerBranch.storeOwnerProfileID = storeOwnerProfile.id ')

            ->leftJoin(DeliveryCompanyFinancialEntity::class, 'DeliveryCompanyFinancialEntity', Join::WITH, 'product.id = product.id')

            ->andWhere('product.storeOwnerProfileID = :storeOwnerProfileId')

            ->addGroupBy('orderDetailEntity.productID')
            ->having('count(orderDetailEntity.productID) > 0')
            ->setMaxResults(20)
            ->setParameter('storeOwnerProfileId',$storeOwnerProfileId)
            ->addOrderBy('countProduct','DESC')
            ->getQuery()
            ->getResult();
    }

    public function getStoreProductsByProfileId($storeOwnerProfileId)
    {
        return $this->createQueryBuilder('product')
        ->select('product.id', 'product.productName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID', 'product.discount','product.description')
       
        ->andWhere('product.storeOwnerProfileID = :storeOwnerProfileId')
        ->setParameter('storeOwnerProfileId',$storeOwnerProfileId)
        ->getQuery()
        ->getResult();
    }

    public function getStoreProducts($storeOwnerProfileId)
    {
        return $this->createQueryBuilder('product')
        ->select('product.id', 'product.productName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID', 'product.discount','product.description','product.status')

        ->andWhere('product.storeOwnerProfileID = :storeOwnerProfileId')
        ->setParameter('storeOwnerProfileId',$storeOwnerProfileId)
        ->getQuery()
        ->getResult();
    }

    public function getProductsByStoreProductCategoryID($storeProductCategoryID)
    {
        return $this->createQueryBuilder('product')
        ->select('product.id', 'product.productName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID', 'product.discount','product.description','product.status')

        ->andWhere('product.storeProductCategoryID = :storeProductCategoryID')
        ->andWhere('product.status = :status')
        ->setParameter('storeProductCategoryID',$storeProductCategoryID)
        ->setParameter('status','active')
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
            ->select('product.id', 'product.productName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID')

            ->addSelect('storeOwnerProfile.id as storeOwnerProfileID', 'storeOwnerProfile.storeOwnerName as storeOwnerName', 'storeOwnerProfile.image as storeImage')
            
            ->addSelect('DeliveryCompanyFinancialEntity.deliveryCost')
            
            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfile', Join::WITH, 'storeOwnerProfile.id = product.storeOwnerProfileID')

            ->leftJoin(DeliveryCompanyFinancialEntity::class, 'DeliveryCompanyFinancialEntity', Join::WITH, 'product.id = product.id')
           
            ->andWhere('product.productName LIKE :productName')

            ->setParameter('productName', '%'.$name.'%')

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
            ->select('product.id', 'product.productName', 'product.productImage', 'product.productPrice', 'product.storeOwnerProfileID', 'product.storeProductCategoryID','product.discount', 'product.description', 'product.status')

            ->leftJoin(StoreProductCategoryEntity::class, 'StoreProductCategoryEntity', Join::WITH, 'StoreProductCategoryEntity.id = product.storeProductCategoryID')

            ->andWhere('StoreProductCategoryEntity.storeProductCategoryID = :storeProductCategoryIdLevel1')
            ->setParameter('storeProductCategoryIdLevel1',$storeProductCategoryIdLevel1)
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

}
