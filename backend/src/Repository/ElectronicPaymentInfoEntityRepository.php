<?php

namespace App\Repository;

use App\Entity\ElectronicPaymentInfoEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method ElectronicPaymentInfoEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method ElectronicPaymentInfoEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method ElectronicPaymentInfoEntity[]    findAll()
 * @method ElectronicPaymentInfoEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ElectronicPaymentInfoEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, ElectronicPaymentInfoEntity::class);
    }

    // /**
    //  * @return ElectronicPaymentInfoEntity[] Returns an array of ElectronicPaymentInfoEntity objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('e')
            ->andWhere('e.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('e.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?ElectronicPaymentInfoEntity
    {
        return $this->createQueryBuilder('e')
            ->andWhere('e.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
