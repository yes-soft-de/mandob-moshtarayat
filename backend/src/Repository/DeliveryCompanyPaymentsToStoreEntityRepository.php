<?php

namespace App\Repository;

use App\Entity\DeliveryCompanyPaymentsToStoreEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method DeliveryCompanyPaymentsToStoreEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method DeliveryCompanyPaymentsToStoreEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method DeliveryCompanyPaymentsToStoreEntity[]    findAll()
 * @method DeliveryCompanyPaymentsToStoreEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class DeliveryCompanyPaymentsToStoreEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, DeliveryCompanyPaymentsToStoreEntity::class);
    }

    // /**
    //  * @return DeliveryCompanyPaymentsToStoreEntity[] Returns an array of DeliveryCompanyPaymentsToStoreEntity objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('d')
            ->andWhere('d.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('d.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?DeliveryCompanyPaymentsToStoreEntity
    {
        return $this->createQueryBuilder('d')
            ->andWhere('d.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
