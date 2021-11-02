<?php

namespace App\Repository;

use App\Entity\DeliveryCompanyPaymentsToCaptainEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method DeliveryCompanyPaymentsToCaptainEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method DeliveryCompanyPaymentsToCaptainEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method DeliveryCompanyPaymentsToCaptainEntity[]    findAll()
 * @method DeliveryCompanyPaymentsToCaptainEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class DeliveryCompanyPaymentsToCaptainEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, DeliveryCompanyPaymentsToCaptainEntity::class);
    }

    public function  deliveryCompanyPaymentsToCaptain($captainId)
    {
        return $this->createQueryBuilder('paymentsToCaptain')
               ->select('paymentsToCaptain.id, paymentsToCaptain.captainId, paymentsToCaptain.amount, paymentsToCaptain.date, paymentsToCaptain.note')

               ->andWhere('paymentsToCaptain.captainId = :captainId')
               
               ->setParameter('captainId', $captainId)

               ->getQuery()
               ->getResult();
    }

    public function deliveryCompanySumPaymentsToCaptain($captainId)
    {
        return $this->createQueryBuilder('paymentsToCaptain')
               ->select('sum(paymentsToCaptain.amount) as sumPaymentsFromCompany')
               ->andWhere('paymentsToCaptain.captainId = :captainId')
               ->setParameter('captainId', $captainId)

               ->getQuery()
               ->getResult();
    }
    
    public function deliveryCompanySumPaymentsToCaptainInSpecificDate($captainId, $ToDate, $toDate)
    {
        return $this->createQueryBuilder('paymentsToCaptain')
               ->select('sum(paymentsToCaptain.amount) as sumPayments ')

               ->where('paymentsToCaptain.captainId = :captainId')
               ->andWhere('paymentsToCaptain.date >= :ToDate')
               ->andWhere('paymentsToCaptain.date < :toDate')
               
               ->setParameter('captainId', $captainId)
               ->setParameter('ToDate', $ToDate)
               ->setParameter('toDate', $toDate)
               ->getQuery()
               ->getResult();
    }

    public function deliveryCompanyPaymentsToCaptainInSpecificDate($captainId, $ToDate, $toDate)
    {
        return $this->createQueryBuilder('paymentsToCaptain')
               ->select('paymentsToCaptain.id, paymentsToCaptain.captainId, paymentsToCaptain.amount, paymentsToCaptain.date, paymentsToCaptain.note')

               ->where('paymentsToCaptain.captainId = :captainId')
               ->andWhere('paymentsToCaptain.date >= :ToDate')
               ->andWhere('paymentsToCaptain.date < :toDate')
               ->setParameter('captainId', $captainId)
               ->setParameter('ToDate', $ToDate)
               ->setParameter('toDate', $toDate)
               ->getQuery()
               ->getResult();
    }

}
