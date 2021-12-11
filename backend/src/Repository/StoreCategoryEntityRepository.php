<?php

namespace App\Repository;

use App\Entity\StoreCategoryEntity;
use App\Entity\StoreCategoryTranslationEntity;
use App\Entity\StoreOwnerProfileEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;
use App\Entity\StoreProductCategoryEntity;

/**
 * @method StoreCategoryEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method StoreCategoryEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method StoreCategoryEntity[]    findAll()
 * @method StoreCategoryEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class StoreCategoryEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, StoreCategoryEntity::class);
    }

    public function getStoreCategories($userLocale, $essentialLanguage)
    {
        if($userLocale == $essentialLanguage || (!$userLocale))
        {
            return $this->createQueryBuilder('storeCategory')

                ->select('storeCategory.id', 'storeCategory.storeCategoryName', 'storeCategory.description', 'storeCategory.image', 'storeCategory.language')

                ->getQuery()
                ->getResult();
        }
        else
        {
            return $this->createQueryBuilder('storeCategory')

                ->select('storeCategory.id', 'storeCategoryTranslationEntity.storeCategoryName', 'storeCategoryTranslationEntity.description', 'storeCategory.image',
                 'storeCategoryTranslationEntity.language')

                ->leftJoin(
                    StoreCategoryTranslationEntity::class,
                    'storeCategoryTranslationEntity',
                    Join::WITH,
                    'storeCategoryTranslationEntity.storeCategoryID = storeCategory.id'
                )

                ->andWhere('storeCategoryTranslationEntity.language = :language')
                ->setParameter('language', $userLocale)

                ->getQuery()
                ->getResult();
        }
    }

    public function getStoreCategoryByID($userLocale, $primaryLanguage, $storeCategoryID)
    {
        if($userLocale == $primaryLanguage || (!$userLocale))
        {
            return $this->createQueryBuilder('store_category_entity')
                ->select('store_category_entity.id', 'store_category_entity.storeCategoryName', 'store_category_entity.description', 'store_category_entity.image', 'store_category_entity.language')

                ->andWhere('store_category_entity.id = :id')
                ->setParameter('id', $storeCategoryID)

                ->getQuery()
                ->getOneOrNullResult();
        }
        else
        {
            return $this->createQueryBuilder('store_category_entity')

                ->select('store_category_entity.id', 'storeCategoryTranslationEntity.storeCategoryName', 'storeCategoryTranslationEntity.description', 'store_category_entity.image',
                    'storeCategoryTranslationEntity.language')

                ->leftJoin(
                    StoreCategoryTranslationEntity::class,
                    'storeCategoryTranslationEntity',
                    Join::WITH,
                    'storeCategoryTranslationEntity.storeCategoryID = store_category_entity.id'
                )

                ->andWhere('storeCategoryTranslationEntity.language = :language')
                ->setParameter('language', $userLocale)

                ->andWhere('store_category_entity.id = :id')
                ->setParameter('id', $storeCategoryID)

                ->getQuery()
                ->getResult();
        }
    }

    public function getLast15StoreCategories()
    {
        return $this->createQueryBuilder('storeCategory')

            ->select('storeCategory.id', 'storeCategory.storeCategoryName', 'storeCategory.description', 'storeCategory.image')

            ->addOrderBy('storeCategory.id','DESC')

            ->setMaxResults(15)

            ->getQuery()
            ->getResult();
    }

    public function isItRelatedToSubcategoriesOrStore($id)
    {
        return $this->createQueryBuilder('storeCategory')

            ->select('StoreProductCategoryEntity.id')

            ->leftJoin(StoreProductCategoryEntity::class, 'StoreProductCategoryEntity', Join::WITH, 'StoreProductCategoryEntity.storeCategoryID = storeCategory.id')
            ->leftJoin(StoreOwnerProfileEntity::class, 'StoreOwnerProfileEntity', Join::WITH, 'StoreOwnerProfileEntity.storeCategoryId = storeCategory.id')

            ->andWhere('StoreProductCategoryEntity.storeCategoryID= :id')
            ->orWhere('StoreOwnerProfileEntity.storeCategoryId= :id')

            ->setParameter('id',$id)

            ->getQuery()
            ->getResult();
    }

    public function getStoreCategoriesByClientFavouriteCategoriesIDs($favouriteCategoriesIDsArray)
    {
        return $this->createQueryBuilder('storeCategory')
             ->select('storeCategory.id', 'storeCategory.storeCategoryName', 'storeCategory.description', 'storeCategory.image')

             ->andWhere("storeCategory.id IN (:categoriesIDs)")

             ->setParameter('categoriesIDs', $favouriteCategoriesIDsArray)

             ->getQuery()
             ->getResult();
    }
}
