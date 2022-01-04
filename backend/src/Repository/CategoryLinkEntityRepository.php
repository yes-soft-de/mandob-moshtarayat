<?php

namespace App\Repository;

use App\Entity\CategoryLinkEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method CategoryLinkEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method CategoryLinkEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method CategoryLinkEntity[]    findAll()
 * @method CategoryLinkEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class CategoryLinkEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, CategoryLinkEntity::class);
    }

}
