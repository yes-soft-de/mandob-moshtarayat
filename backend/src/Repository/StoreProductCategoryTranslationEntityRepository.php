<?php

namespace App\Repository;

use App\Entity\StoreProductCategoryTranslationEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
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

}
