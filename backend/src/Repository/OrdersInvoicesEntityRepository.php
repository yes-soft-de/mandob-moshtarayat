<?php

namespace App\Repository;

use App\Entity\OrdersInvoicesEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method OrdersInvoicesEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method OrdersInvoicesEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method OrdersInvoicesEntity[]    findAll()
 * @method OrdersInvoicesEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class OrdersInvoicesEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, OrdersInvoicesEntity::class);
    }

    // /**
    //  * @return OrdersInvoicesEntity[] Returns an array of OrdersInvoicesEntity objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('o')
            ->andWhere('o.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('o.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?OrdersInvoicesEntity
    {
        return $this->createQueryBuilder('o')
            ->andWhere('o.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
