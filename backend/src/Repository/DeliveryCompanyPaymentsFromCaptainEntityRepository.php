<?php

namespace App\Repository;

use App\Entity\DeliveryCompanyPaymentsFromCaptainEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method DeliveryCompanyPaymentsFromCaptainEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method DeliveryCompanyPaymentsFromCaptainEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method DeliveryCompanyPaymentsFromCaptainEntity[]    findAll()
 * @method DeliveryCompanyPaymentsFromCaptainEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class DeliveryCompanyPaymentsFromCaptainEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, DeliveryCompanyPaymentsFromCaptainEntity::class);
    }

    public function  deliveryCompanyPaymentsFromCaptain($captainId)
    {
        return $this->createQueryBuilder('paymentsFromCaptain')
               ->select('paymentsFromCaptain.id, paymentsFromCaptain.captainId, paymentsFromCaptain.amount, paymentsFromCaptain.date, paymentsFromCaptain.note')

               ->andWhere('paymentsFromCaptain.captainId = :captainId')
               
               ->setParameter('captainId', $captainId)

               ->getQuery()
               ->getResult();
    }

    public function deliveryCompanySumPaymentsFromCaptain($captainId)
    {
        return $this->createQueryBuilder('paymentsFromCaptain')
               ->select('sum(paymentsFromCaptain.amount) as sumPaymentsToCompany')
               ->andWhere('paymentsFromCaptain.captainId = :captainId')
               ->setParameter('captainId', $captainId)

               ->getQuery()
               ->getResult();
    }
    
    public function deliveryCompanySumPaymentsFromCaptains()
    {
        return $this->createQueryBuilder('paymentsFromCaptain')
               ->select('sum(paymentsFromCaptain.amount) as sumPaymentsToCompany')
               ->getQuery()
               ->getResult();
    }
    
    public function deliveryCompanySumPaymentsFromCaptainInSpecificDate($captainId, $fromDate, $toDate)
    {
        return $this->createQueryBuilder('paymentsFromCaptain')
               ->select('sum(paymentsFromCaptain.amount) as sumPayments ')

               ->where('paymentsFromCaptain.captainId = :captainId')
               ->andWhere('paymentsFromCaptain.date >= :fromDate')
               ->andWhere('paymentsFromCaptain.date < :toDate')
               
               ->setParameter('captainId', $captainId)
               ->setParameter('fromDate', $fromDate)
               ->setParameter('toDate', $toDate)
               ->getQuery()
               ->getResult();
    }

    public function deliveryCompanyPaymentsFromCaptainInSpecificDate($captainId, $fromDate, $toDate)
    {
        return $this->createQueryBuilder('paymentsFromCaptain')
               ->select('paymentsFromCaptain.id, paymentsFromCaptain.captainId, paymentsFromCaptain.amount, paymentsFromCaptain.date, paymentsFromCaptain.note')

               ->where('paymentsFromCaptain.captainId = :captainId')
               ->andWhere('paymentsFromCaptain.date >= :fromDate')
               ->andWhere('paymentsFromCaptain.date < :toDate')
               ->setParameter('captainId', $captainId)
               ->setParameter('fromDate', $fromDate)
               ->setParameter('toDate', $toDate)
               ->getQuery()
               ->getResult();
    }

}
