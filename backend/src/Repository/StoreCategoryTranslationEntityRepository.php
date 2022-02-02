<?php

namespace App\Repository;

use App\Entity\StoreCategoryEntity;
use App\Entity\StoreCategoryTranslationEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method StoreCategoryTranslationEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method StoreCategoryTranslationEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method StoreCategoryTranslationEntity[]    findAll()
 * @method StoreCategoryTranslationEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class StoreCategoryTranslationEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, StoreCategoryTranslationEntity::class);
    }

    // return StoreCategoryTranslationEntity
    public function getByStoreCategoryIdAndLanguage($storeCategoryID, $language)
    {
        return $this->createQueryBuilder('storeCategoryTranslationEntity')

            ->andWhere('storeCategoryTranslationEntity.storeCategoryID = :storeCategoryID')
            ->setParameter('storeCategoryID', $storeCategoryID)

            ->andWhere('storeCategoryTranslationEntity.language = :language')
            ->setParameter('language', $language)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getStoreCategoriesTranslationByLanguage($language)
    {
        return $this->createQueryBuilder('storeCategoryTranslationEntity')
            ->select('storeCategoryTranslationEntity.id', 'storeCategoryTranslationEntity.storeCategoryID', 'storeCategoryTranslationEntity.storeCategoryName', 'storeCategoryTranslationEntity.description',
             'storeCategoryTranslationEntity.language', 'storeCategoryEntity.image')

            ->andWhere('storeCategoryTranslationEntity.language = :language')
            ->setParameter('language', $language)

            ->leftJoin(
                StoreCategoryEntity::class,
                'storeCategoryEntity',
                Join::WITH,
                'storeCategoryEntity.id = storeCategoryTranslationEntity.storeCategoryID'
            )

            ->getQuery()
            ->getResult();
    }

    public function getAllStoreCategoryTranslationsByStoreCategoryID($storeCategoryID)
    {
        return $this->createQueryBuilder('storeCategoryTranslationEntity')
            ->select('storeCategoryTranslationEntity.id', 'storeCategoryTranslationEntity.language', 'storeCategoryTranslationEntity.storeCategoryName', 'storeCategoryTranslationEntity.storeCategoryName',
             'storeCategoryTranslationEntity.description')

            ->andWhere('storeCategoryTranslationEntity.storeCategoryID = :storeCategoryID')
            ->setParameter('storeCategoryID', $storeCategoryID)

            ->getQuery()
            ->getResult();
    }

    public function getAllStoreCategoryTranslationsEntitiesByStoreCategoryID($storeCategoryID)
    {
        return $this->createQueryBuilder('storeCategoryTranslationEntity')

            ->andWhere('storeCategoryTranslationEntity.storeCategoryID = :storeCategoryID')
            ->setParameter('storeCategoryID', $storeCategoryID)

            ->getQuery()
            ->getResult();
    }
}
