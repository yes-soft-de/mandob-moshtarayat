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

}
