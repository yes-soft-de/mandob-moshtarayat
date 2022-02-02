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


    public function  deliveryCompanyPaymentsToStore($storeOwnerProfileID)
    {
        return $this->createQueryBuilder('paymentsToStore')

            ->select('paymentsToStore.id, paymentsToStore.storeOwnerProfileID, paymentsToStore.amount, paymentsToStore.date, paymentsToStore.note')

            ->andWhere('paymentsToStore.storeOwnerProfileID = :storeOwnerProfileID')

            ->setParameter('storeOwnerProfileID', $storeOwnerProfileID)

            ->getQuery()
            ->getResult();
    }

    public function deliveryCompanySumPaymentsToStore($storeOwnerProfileID)
    {
        return $this->createQueryBuilder('paymentsToStore')

            ->select('sum(paymentsToStore.amount) as sumPaymentsFromCompany')

            ->andWhere('paymentsToStore.storeOwnerProfileID = :storeOwnerProfileID')

            ->setParameter('storeOwnerProfileID', $storeOwnerProfileID)

            ->getQuery()
            ->getSingleScalarResult();
    }

    public function deliveryCompanySumPaymentsToStoreInSpecificDate($storeOwnerProfileID, $fromDate, $toDate)
    {
        return $this->createQueryBuilder('paymentsToStore')

            ->select('sum(paymentsToStore.amount) as sumPayments ')

            ->where('paymentsToStore.storeOwnerProfileID = :storeOwnerProfileID')
            ->andWhere('paymentsToStore.date >= :fromDate')
            ->andWhere('paymentsToStore.date < :toDate')

            ->setParameter('storeOwnerProfileID', $storeOwnerProfileID)
            ->setParameter('fromDate', $fromDate)
            ->setParameter('toDate', $toDate)

            ->getQuery()
            ->getSingleScalarResult();
    }

    public function deliveryCompanyPaymentsToStoreInSpecificDate($storeOwnerProfileID, $ToDate, $toDate)
    {
        return $this->createQueryBuilder('paymentsToStore')

            ->select('paymentsToStore.id, paymentsToStore.storeOwnerProfileID, paymentsToStore.amount, paymentsToStore.date, paymentsToStore.note')

            ->where('paymentsToStore.storeOwnerProfileID = :storeOwnerProfileID')
            ->andWhere('paymentsToStore.date >= :ToDate')
            ->andWhere('paymentsToStore.date < :toDate')

            ->setParameter('storeOwnerProfileID', $storeOwnerProfileID)
            ->setParameter('ToDate', $ToDate)
            ->setParameter('toDate', $toDate)

            ->getQuery()
            ->getResult();
    }
}
