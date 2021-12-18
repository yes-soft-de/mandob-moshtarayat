<?php

namespace App\Repository;

use App\Entity\VerificationEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method VerificationEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method VerificationEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method VerificationEntity[]    findAll()
 * @method VerificationEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class VerificationEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, VerificationEntity::class);
    }

}
