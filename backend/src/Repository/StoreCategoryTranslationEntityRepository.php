<?php

namespace App\Repository;

use App\Entity\StoreCategoryTranslationEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
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

}
