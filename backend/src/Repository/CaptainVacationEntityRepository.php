<?php

namespace App\Repository;

use App\Entity\CaptainVacationEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method CaptainVacationEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method CaptainVacationEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method CaptainVacationEntity[]    findAll()
 * @method CaptainVacationEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class CaptainVacationEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, CaptainVacationEntity::class);
    }
}
