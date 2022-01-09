<?php

namespace App\Repository;

use App\Entity\StoreCategoryEntity;
use App\Entity\StoreProductCategoryEntity;
use App\Entity\StoreProductCategoryTranslationEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method StoreProductCategoryTranslationEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method StoreProductCategoryTranslationEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method StoreProductCategoryTranslationEntity[]    findAll()
 * @method StoreProductCategoryTranslationEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class StoreProductCategoryTranslationEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, StoreProductCategoryTranslationEntity::class);
    }

    // return StoreProductCategoryTranslationEntity
    public function getByStoreProductCategoryIdAndLanguage($storeProductCategoryID, $language)
    {
        return $this->createQueryBuilder('storeProductCategoryTranslationEntity')

            ->andWhere('storeProductCategoryTranslationEntity.storeProductCategoryID = :storeProductCategoryID')
            ->setParameter('storeProductCategoryID', $storeProductCategoryID)

            ->andWhere('storeProductCategoryTranslationEntity.language = :language')
            ->setParameter('language', $language)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getByStoreCategoryIdAndLanguage($storeCategoryID, $language)
    {
        return $this->createQueryBuilder('storeProductCategoryTranslationEntity')
            ->select('storeProductCategoryTranslationEntity.id', 'storeProductCategoryTranslationEntity.storeProductCategoryID', 'storeProductCategoryTranslationEntity.productCategoryName',
             'storeProductCategoryTranslationEntity.language', 'storeProductCategoryEntity.productCategoryImage')

            ->andWhere('storeProductCategoryTranslationEntity.language = :language')
            ->setParameter('language', $language)

            ->leftJoin(
                StoreProductCategoryEntity::class,
                'storeProductCategoryEntity',
                Join::WITH,
                'storeProductCategoryEntity.id = storeProductCategoryTranslationEntity.storeProductCategoryID'
            )

            ->andWhere('storeProductCategoryEntity.storeCategoryID = :storeCategoryID')
            ->setParameter('storeCategoryID', $storeCategoryID)

            ->getQuery()
            ->getResult();
    }

    public function getStoreProductCategoriesTranslationsByStoreProductCategoryIdAndLanguage($storeProductCategoryID, $language)
    {
        return $this->createQueryBuilder('storeProductCategoryTranslationEntity')
            ->select('storeProductCategoryTranslationEntity.id', 'storeProductCategoryTranslationEntity.storeProductCategoryID', 'storeProductCategoryTranslationEntity.productCategoryName',
                'storeProductCategoryTranslationEntity.language', 'storeProductCategoryEntity.productCategoryImage')

            ->andWhere('storeProductCategoryTranslationEntity.language = :language')
            ->setParameter('language', $language)

            ->leftJoin(
                StoreProductCategoryEntity::class,
                'storeProductCategoryEntity',
                Join::WITH,
                'storeProductCategoryEntity.id = storeProductCategoryTranslationEntity.storeProductCategoryID'
            )

            ->andWhere('storeProductCategoryEntity.storeProductCategoryID = :storeProductCategoryID')
            ->setParameter('storeProductCategoryID', $storeProductCategoryID)

            ->getQuery()
            ->getResult();
    }

    public function getStoreProductCategoryTranslationsByStoreProductCategoryID($storeProductCategoryID)
    {
        return $this->createQueryBuilder('storeProductCategoryTranslationEntity')
            ->select('storeProductCategoryTranslationEntity.id', 'storeProductCategoryTranslationEntity.storeProductCategoryID', 'storeProductCategoryTranslationEntity.productCategoryName',
                'storeProductCategoryTranslationEntity.language')

            ->andWhere('storeProductCategoryTranslationEntity.storeProductCategoryID = :storeProductCategoryID')
            ->setParameter('storeProductCategoryID', $storeProductCategoryID)

            ->getQuery()
            ->getResult();
    }
}
