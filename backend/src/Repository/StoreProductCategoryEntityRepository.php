<?php

namespace App\Repository;

use App\Entity\ProductEntity;
use App\Entity\StoreProductCategoryEntity;
use App\Entity\StoreProductCategoryTranslationEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method StoreProductCategoryEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method StoreProductCategoryEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method StoreProductCategoryEntity[]    findAll()
 * @method StoreProductCategoryEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class StoreProductCategoryEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, StoreProductCategoryEntity::class);
    }

    public function getStoreProductsCategoryForStoreSpecific($storeOwnerProfileId)
    {
        return $this->createQueryBuilder('storeProductCategory')

            ->select('storeProductCategory.id', 'storeProductCategory.productCategoryName', 'storeProductCategory.storeOwnerProfileId', 'storeProductCategory.productCategoryImage')

            ->andWhere('storeProductCategory.storeOwnerProfileId = :storeOwnerProfileId')
            
            ->setParameter('storeOwnerProfileId', $storeOwnerProfileId)

            ->getQuery()
            ->getResult()
        ;
    }

    public function getStoreProductCategoryStoreSpecific($storeOwnerProfileId)
    {
        return $this->createQueryBuilder('storeProductCategory')

            ->select('storeProductCategory.id', 'storeProductCategory.productCategoryName', 'storeProductCategory.storeOwnerProfileId', 'storeProductCategory.productCategoryImage')

            ->leftJoin(ProductEntity::class, 'ProductEntity', Join::WITH, 'ProductEntity.storeOwnerProfileID = :storeOwnerProfileId')

            ->andWhere('storeProductCategory.id = ProductEntity.storeProductCategoryID')

            ->setParameter('storeOwnerProfileId', $storeOwnerProfileId)

            ->groupBy('storeProductCategory.id')
            ->getQuery()
            ->getResult()
        ;
    }

    public function getSubCategoriesByStoreCategoryID($storeCategoryID)
    {
        return $this->createQueryBuilder('storeProductCategory')

            ->select('storeProductCategory.id', 'storeProductCategory.productCategoryName', 'storeProductCategory.isLevel1', 'storeProductCategory.productCategoryImage')

            ->andWhere('storeProductCategory.storeCategoryID = :storeCategoryID')
            ->andWhere('storeProductCategory.isLevel1 = :isLevel1')

            ->setParameter('storeCategoryID', $storeCategoryID)
            ->setParameter('isLevel1', 1)

            ->getQuery()
            ->getResult();
    }

    public function getSubCategoriesTranslationsByStoreCategoryID($storeCategoryID)
    {
        return $this->createQueryBuilder('storeProductCategory')
            ->select('storeProductCategory.id', 'storeProductCategory.productCategoryName as primaryStoreProductCategory', 'storeProductCategory.isLevel1', 'storeProductCategory.productCategoryImage',
             'storeProductCategoryTranslationEntity.productCategoryName', 'storeProductCategoryTranslationEntity.language')

            ->andWhere('storeProductCategory.storeCategoryID = :storeCategoryID')
            ->andWhere('storeProductCategory.isLevel1 = :isLevel1')

            ->setParameter('storeCategoryID', $storeCategoryID)
            ->setParameter('isLevel1', 1)

            ->leftJoin(
                StoreProductCategoryTranslationEntity::class,
                'storeProductCategoryTranslationEntity',
                Join::WITH,
                'storeProductCategoryTranslationEntity.storeProductCategoryID = storeProductCategory.id'
            )

            ->getQuery()
            ->getResult();
    }

    public function getStoreProductsCategoryLevelTwoByStoreProductCategoryID($storeProductCategoryID)
    {
        return $this->createQueryBuilder('storeProductCategory')

            ->select('storeProductCategory.id', 'storeProductCategory.productCategoryName', 'storeProductCategory.isLevel1', 'storeProductCategory.productCategoryImage')

            ->where('storeProductCategory.storeProductCategoryID = :storeProductCategoryID')
            ->andWhere('storeProductCategory.isLevel2 = :isLevel2')

            ->setParameter('isLevel2', true)
            ->setParameter('storeProductCategoryID', $storeProductCategoryID)

            ->getQuery()
            ->getArrayResult()
        ;
    }

    public function getStoreProductsCategoryLevelTwoByStoreOwnerProfile($storeOwnerProfileID)
    {
        return $this->createQueryBuilder('storeProductCategory')
            ->select('storeProductCategory.id', 'storeProductCategory.productCategoryName', 'storeProductCategory.isLevel2', 'storeProductCategory.productCategoryImage')

            ->leftJoin(ProductEntity::class, 'ProductEntity', Join::WITH, 'ProductEntity.storeOwnerProfileID = :storeOwnerProfileID')

            ->andWhere('ProductEntity.storeOwnerProfileID = :storeOwnerProfileID')
            ->andWhere('storeProductCategory.isLevel2 = :isLevel2')

            ->setParameter('storeOwnerProfileID', $storeOwnerProfileID)
            ->setParameter('isLevel2', 1)

            ->groupBy('storeProductCategory.id')

            ->getQuery()
            ->getResult()
            ;
    }

    public function getCategoriesLevel1ById($id)
    {
        return $this->createQueryBuilder('storeProductCategory')
            ->select('storeProductCategory.id', 'storeProductCategory.productCategoryName', 'storeProductCategory.isLevel1', 'storeProductCategory.productCategoryImage')
             ->andWhere('storeProductCategory.id = :id')

            ->setParameter('id', $id)

            ->getQuery()
            ->getResult();
    }

    public function getStoreProductsCategoriesIdLevelOneByStoreOwnerProfileID($storeOwnerProfileID)
    {
        return $this->createQueryBuilder('storeProductCategory')
            ->select('storeProductCategory.storeProductCategoryID')

            ->leftJoin(ProductEntity::class, 'ProductEntity', Join::WITH, 'ProductEntity.storeProductCategoryID = storeProductCategory.id')

            ->andWhere('ProductEntity.storeOwnerProfileID = :storeOwnerProfileID')

            ->setParameter('storeOwnerProfileID', $storeOwnerProfileID)

            ->groupBy('storeProductCategory.storeProductCategoryID')

            ->getQuery()
            ->getResult()
            ;
    }

    public function isItRelatedToProductsOrOtherCategory($id)
    {
        return $this->createQueryBuilder('storeProductCategory')

            ->select('ProductEntity.id')

            ->leftJoin(ProductEntity::class, 'ProductEntity', Join::WITH, 'ProductEntity.storeProductCategoryID = storeProductCategory.id')

            ->andWhere('ProductEntity.storeProductCategoryID= :id')
            ->orWhere('storeProductCategory.storeProductCategoryID= :id')

            ->setParameter('id',$id)

            ->getQuery()
            ->getResult();
    }

    public function isItRelatedToCategoryLevelTwo($id)
    {
        return $this->createQueryBuilder('storeProductCategory')

            ->select('storeProductCategory.id')

            ->where('storeProductCategory.storeProductCategoryID = :id')
            ->andWhere('storeProductCategory.isLevel2 = :isLevel2')

            ->setParameter('isLevel2', true)
            ->setParameter('id', $id)

            ->getQuery()
            ->getResult()
            ;
    }
}
