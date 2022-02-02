<?php

namespace App\Repository;

use App\Entity\ProductTranslationEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method ProductTranslationEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method ProductTranslationEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method ProductTranslationEntity[]    findAll()
 * @method ProductTranslationEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ProductTranslationEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, ProductTranslationEntity::class);
    }

    // return ProductTranslationEntity
    public function getByProductIdAndLanguage($productID, $language)
    {
        return $this->createQueryBuilder('productTranslationEntity')

            ->andWhere('productTranslationEntity.productID = :productID')
            ->setParameter('productID', $productID)

            ->andWhere('productTranslationEntity.language = :language')
            ->setParameter('language', $language)

            ->getQuery()
            ->getOneOrNullResult();
    }

    // for testing issues: update language code
    public function getAllProductsTranslationsByLanguage($language)
    {
        return $this->createQueryBuilder('productTranslationEntity')

            ->andWhere('productTranslationEntity.language = :language')
            ->setParameter('language', $language)

            ->getQuery()
            ->getResult();
    }
}
