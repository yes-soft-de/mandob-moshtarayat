<?php

namespace App\Repository;

use App\Entity\RepresentativeDueEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method RepresentativeDueEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method RepresentativeDueEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method RepresentativeDueEntity[]    findAll()
 * @method RepresentativeDueEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class RepresentativeDueEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, RepresentativeDueEntity::class);
    }

    public function getSumRepresentativeDueByRepresentativeUserID($representativeUserID)
    {
        return $this->createQueryBuilder('representativeDueEntity')
            ->select('SUM(representativeDueEntity.dueAmount)')

            ->andWhere('representativeDueEntity.representativeUserID = :representativeUserID')
            ->setParameter('representativeUserID', $representativeUserID)

            ->getQuery()
            ->getSingleScalarResult();
    }
}
