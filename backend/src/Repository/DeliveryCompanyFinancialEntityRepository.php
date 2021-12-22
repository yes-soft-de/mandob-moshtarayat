<?php

namespace App\Repository;

use App\Entity\DeliveryCompanyFinancialEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method DeliveryCompanyFinancialEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method DeliveryCompanyFinancialEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method DeliveryCompanyFinancialEntity[]    findAll()
 * @method DeliveryCompanyFinancialEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class DeliveryCompanyFinancialEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, DeliveryCompanyFinancialEntity::class);
    }

    public function  getDeliveryCompanyFinancialById($id)
    {
        return $this->createQueryBuilder('DeliveryCompanyFinancialEntity') 
            ->andWhere('DeliveryCompanyFinancialEntity.id = :id')
            ->setParameter('id',$id)
            ->getQuery()
            ->getOneOrNullResult();
    }
    
    public function  getDeliveryCompanyFinancialAll()
    {
        return $this->createQueryBuilder('DeliveryCompanyFinancialEntity') 
            ->select('DeliveryCompanyFinancialEntity.id','DeliveryCompanyFinancialEntity.deliveryCost')
            ->getQuery()
            ->getResult();
    }
}
