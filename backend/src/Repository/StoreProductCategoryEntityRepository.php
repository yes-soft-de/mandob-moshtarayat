<?php

namespace App\Repository;

use App\Constant\CategoryLinkTypeConstant;
use App\Entity\CategoryLinkEntity;
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

            ->leftJoin(
                CategoryLinkEntity::class,
                'categoryLinkEntity',
                Join::WITH,
                'categoryLinkEntity.subCategoryLevelOneID = storeProductCategory.id'
            )

            ->andWhere('categoryLinkEntity.mainCategoryID = :storeCategoryID')
            ->setParameter('storeCategoryID', $storeCategoryID)

//            ->andWhere('storeProductCategory.isLevel1 = :isLevel1')
//            ->setParameter('isLevel1', 1)

            ->getQuery()
            ->getResult();
    }

    public function getProductCategoryLevelOneByProductCategoryLevelTwoID($storeProductCategoryLevelTwoID)
    {
        return $this->createQueryBuilder('storeProductCategory')
            ->select('storeProductCategory.id')

            ->leftJoin(
                CategoryLinkEntity::class,
                'categoryLinkEntity',
                Join::WITH,
                'categoryLinkEntity.subCategoryLevelOneID = storeProductCategory.id'
            )

            ->andWhere('categoryLinkEntity.subCategoryLevelTwoID = :subCategoryLevelTwoID')
            ->setParameter('subCategoryLevelTwoID', $storeProductCategoryLevelTwoID)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getSubCategoriesTranslationsByStoreCategoryID($storeCategoryID)
    {
        return $this->createQueryBuilder('storeProductCategory')
            ->select('storeProductCategory.id', 'storeProductCategory.productCategoryName as primaryStoreProductCategory', 'storeProductCategory.isLevel1', 'storeProductCategory.productCategoryImage',
             'storeProductCategoryTranslationEntity.productCategoryName', 'storeProductCategoryTranslationEntity.language')

            ->andWhere('storeProductCategory.isLevel1 = :isLevel1')
            ->setParameter('isLevel1', 1)

            ->leftJoin(
                StoreProductCategoryTranslationEntity::class,
                'storeProductCategoryTranslationEntity',
                Join::WITH,
                'storeProductCategoryTranslationEntity.storeProductCategoryID = storeProductCategory.id'
            )

            ->leftJoin(
                CategoryLinkEntity::class,
                'categoryLinkEntity',
                Join::WITH,
                'categoryLinkEntity.subCategoryLevelOneID = storeProductCategory.id'
            )

            ->andWhere('categoryLinkEntity.mainCategoryID = :storeCategoryID')
            ->setParameter('storeCategoryID', $storeCategoryID)

            ->getQuery()
            ->getResult();
    }

    public function getStoreProductCategoryTranslationByStoreProductCategoryIdAndLanguage($storeProductCategoryID, $language)
    {
        return $this->createQueryBuilder('storeProductCategory')
            ->select('storeProductCategory.id', 'storeProductCategory.productCategoryName as primaryStoreProductCategory', 'storeProductCategory.isLevel1', 'storeProductCategory.isLevel2', 'storeProductCategory.productCategoryImage',
                'storeProductCategoryTranslationEntity.productCategoryName', 'storeProductCategoryTranslationEntity.language')

            ->andWhere('storeProductCategory.id = :storeProductCategoryID')
            ->setParameter('storeProductCategoryID', $storeProductCategoryID)

            ->leftJoin(
                StoreProductCategoryTranslationEntity::class,
                'storeProductCategoryTranslationEntity',
                Join::WITH,
                'storeProductCategoryTranslationEntity.storeProductCategoryID = storeProductCategory.id'
            )

            ->andWhere('storeProductCategoryTranslationEntity.language = :language')
            ->setParameter('language', $language)

            ->getQuery()
            ->getOneOrNullResult();
    }
//edit for get products from subCategory one or two.
    public function getStoreProductsCategoryLevelTwoByStoreProductCategoryID($storeProductCategoryID)
    {
        return $this->createQueryBuilder('storeProductCategory')

            ->select('storeProductCategory.id', 'storeProductCategory.productCategoryName', 'storeProductCategory.isLevel1', 'storeProductCategory.productCategoryImage')

//            ->andWhere('storeProductCategory.storeProductCategoryID = :storeProductCategoryID')
//            //Add the next line to get only products that have a one subcategory .
//            ->orWhere('storeProductCategory.id = :storeProductCategoryID')
//            ->setParameter('storeProductCategoryID', $storeProductCategoryID)

//            ->andWhere('storeProductCategory.isLevel2 = :isLevel2')
//            ->setParameter('isLevel2', true)

            ->leftJoin(
                CategoryLinkEntity::class,
                'categoryLinkEntity',
                Join::WITH,
                'categoryLinkEntity.subCategoryLevelTwoID = storeProductCategory.id'
            )
            ->Where('categoryLinkEntity.subCategoryLevelOneID = :storeProductCategoryID')
            ->setParameter('storeProductCategoryID', $storeProductCategoryID)

            ->orWhere('storeProductCategory.id = :storeProductCategoryID')
            ->setParameter('storeProductCategoryID', $storeProductCategoryID)

            ->getQuery()
            ->getArrayResult();
    }

    public function getOnlyStoreProductsCategoryLevelTwoByStoreProductCategoryLevelOneID($storeProductCategoryID)
    {
        return $this->createQueryBuilder('storeProductCategory')
            ->select('storeProductCategory.id', 'storeProductCategory.productCategoryName', 'storeProductCategory.isLevel1', 'storeProductCategory.productCategoryImage')

//            ->andWhere('storeProductCategory.storeProductCategoryID = :storeProductCategoryID')
//            //Add the next line to get only products that have a one subcategory .
//            ->orWhere('storeProductCategory.id = :storeProductCategoryID')
            ->andWhere('storeProductCategory.isLevel2 = :isLevel2')
            ->setParameter('isLevel2', true)

            ->leftJoin(
                CategoryLinkEntity::class,
                'categoryLinkEntity',
                Join::WITH,
                'categoryLinkEntity.subCategoryLevelTwoID = storeProductCategory.id'
            )
            ->andWhere('categoryLinkEntity.subCategoryLevelOneID = :subCategoryLevelOneID')
            ->setParameter('subCategoryLevelOneID', $storeProductCategoryID)

            ->getQuery()
            ->getArrayResult();
    }

    public function getStoreProductsCategoryLevelTwoByStoreProductCategoryIdForAdmin($storeProductCategoryID)
    {
        return $this->createQueryBuilder('storeProductCategory')

            ->select('storeProductCategory.id', 'storeProductCategory.productCategoryName', 'storeProductCategory.isLevel1', 'storeProductCategory.productCategoryImage')

            ->where('storeProductCategory.storeProductCategoryID = :storeProductCategoryID')
            //Add the next line to get only products that have a one subcategory .
            ->orWhere('storeProductCategory.id = :storeProductCategoryID')
            ->andWhere('storeProductCategory.isLevel2 = :isLevel2')

            ->setParameter('isLevel2', true)
            ->setParameter('storeProductCategoryID', $storeProductCategoryID)

            ->getQuery()
            ->getArrayResult()
            ;
    }

    public function getStoreProductsCategoryLevelTwoTranslationsByStoreProductCategoryID($storeProductCategoryID)
    {
        return $this->createQueryBuilder('storeProductCategory')
            ->select('storeProductCategory.id', 'storeProductCategory.productCategoryName as primaryStoreProductCategory', 'storeProductCategory.isLevel1', 'storeProductCategory.productCategoryImage',
                'storeProductCategoryTranslationEntity.productCategoryName', 'storeProductCategoryTranslationEntity.language')

            ->andWhere('storeProductCategory.isLevel2 = :isLevel2')
            ->setParameter('isLevel2', true)

            ->leftJoin(
                StoreProductCategoryTranslationEntity::class,
                'storeProductCategoryTranslationEntity',
                Join::WITH,
                'storeProductCategoryTranslationEntity.storeProductCategoryID = storeProductCategory.id'
            )

            ->leftJoin(
                CategoryLinkEntity::class,
                'categoryLinkEntity',
                Join::WITH,
                'categoryLinkEntity.subCategoryLevelTwoID = storeProductCategory.id'
            )
            ->andWhere('categoryLinkEntity.subCategoryLevelOneID = :subCategoryLevelOneID')
            ->setParameter('subCategoryLevelOneID', $storeProductCategoryID)

            ->getQuery()
            ->getArrayResult();
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

    public function getStoreProductCategoryByID($id)
    {
        return $this->createQueryBuilder('storeProductCategory')
            ->select('storeProductCategory.id', 'storeProductCategory.productCategoryName', 'storeProductCategory.isLevel1', 'storeProductCategory.isLevel2', 'storeProductCategory.productCategoryImage')

            ->andWhere('storeProductCategory.id = :id')
            ->setParameter('id', $id)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getStoreProductsCategoriesIdLevelOneByStoreOwnerProfileID($storeOwnerProfileID)
    {
        return $this->createQueryBuilder('storeProductCategory')
            ->select('DISTINCT(storeProductCategory.id)')

            ->leftJoin(ProductEntity::class, 'ProductEntity', Join::WITH, 'ProductEntity.storeProductCategoryID = storeProductCategory.id')

            ->andWhere('ProductEntity.storeOwnerProfileID = :storeOwnerProfileID')

            ->setParameter('storeOwnerProfileID', $storeOwnerProfileID)

            ->getQuery()
            ->getResult();
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

    /*
     * Return all store categories
     */
    public function getStoreProductCategoryLevelOne($storeProductCategoryLevelTwoID)
    {
        return $this->createQueryBuilder('storeProductCategory')

            ->select('storeProductCategory.id', 'storeProductCategory.productCategoryName', 'storeProductCategory.productCategoryImage', 'storeProductCategory.language', 'categoryLinkEntity.subCategoryLevelTwoID')

            ->leftJoin(
                CategoryLinkEntity::class,
                'categoryLinkEntity',
                Join::WITH,
                'categoryLinkEntity.subCategoryLevelOneID = storeProductCategory.id'
            )

            ->andWhere('categoryLinkEntity.subCategoryLevelTwoID = :subCategoryLevelTwoID')
            ->setParameter('subCategoryLevelTwoID', $storeProductCategoryLevelTwoID)

            ->getQuery()
            ->getResult();
    }

    // Return all store categories level one directly without any condition
    public function getAllStoreProductCategoriesLevelOne()
    {
        return $this->createQueryBuilder('storeProductCategory')

            ->select('storeProductCategory.id', 'storeProductCategory.productCategoryName', 'storeProductCategory.productCategoryImage', 'storeProductCategory.language')

            ->andWhere('storeProductCategory.isLevel1 = :value')
            ->setParameter('value', 1)

            ->getQuery()
            ->getResult();
    }

    // Return all store categories level two directly without any condition
    public function getAllStoreProductCategoriesLevelTwo()
    {
        return $this->createQueryBuilder('storeProductCategory')

            ->select('storeProductCategory.id', 'storeProductCategory.productCategoryName', 'storeProductCategory.productCategoryImage', 'storeProductCategory.language')

            ->andWhere('storeProductCategory.isLevel2 = :value')
            ->setParameter('value', 1)

            ->getQuery()
            ->getResult();
    }

    public function getSubCategoriesLevelOneTranslations()
    {
        return $this->createQueryBuilder('storeProductCategory')
            ->select('storeProductCategory.id', 'storeProductCategory.productCategoryName as primaryStoreProductCategory', 'storeProductCategory.productCategoryImage', 'storeProductCategory.language', 'storeProductCategoryTranslationEntity.productCategoryName', 'storeProductCategoryTranslationEntity.language')

            ->leftJoin(
                StoreProductCategoryTranslationEntity::class,
                'storeProductCategoryTranslationEntity',
                Join::WITH,
                'storeProductCategoryTranslationEntity.storeProductCategoryID = storeProductCategory.id'
            )

            ->getQuery()
            ->getResult();
    }

    public function getAllStoreProductCategoriesLevelOneTranslations()
    {
        return $this->createQueryBuilder('storeProductCategory')
            ->select('storeProductCategory.id', 'storeProductCategory.productCategoryName as primaryStoreProductCategory', 'storeProductCategory.productCategoryImage', 'storeProductCategory.language', 'storeProductCategoryTranslationEntity.productCategoryName', 'storeProductCategoryTranslationEntity.language')

            ->andWhere('storeProductCategory.isLevel1 = :value')
            ->setParameter('value', 1)

            ->leftJoin(
                StoreProductCategoryTranslationEntity::class,
                'storeProductCategoryTranslationEntity',
                Join::WITH,
                'storeProductCategoryTranslationEntity.storeProductCategoryID = storeProductCategory.id'
            )

            ->getQuery()
            ->getResult();
    }

    public function getAllStoreProductCategoriesLevelTwoTranslations()
    {
        return $this->createQueryBuilder('storeProductCategory')
            ->select('storeProductCategory.id', 'storeProductCategory.productCategoryName as primaryStoreProductCategory', 'storeProductCategory.productCategoryImage', 'storeProductCategory.language', 'storeProductCategoryTranslationEntity.productCategoryName', 'storeProductCategoryTranslationEntity.language')

            ->andWhere('storeProductCategory.isLevel2 = :value')
            ->setParameter('value', 1)

            ->leftJoin(
                StoreProductCategoryTranslationEntity::class,
                'storeProductCategoryTranslationEntity',
                Join::WITH,
                'storeProductCategoryTranslationEntity.storeProductCategoryID = storeProductCategory.id'
            )

            ->getQuery()
            ->getResult();
    }
}
