<?php

namespace App\Repository;

use App\Entity\DeliveryCompanyFinancialCompensationEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method DeliveryCompanyFinancialCompensationEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method DeliveryCompanyFinancialCompensationEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method DeliveryCompanyFinancialCompensationEntity[]    findAll()
 * @method DeliveryCompanyFinancialCompensationEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class DeliveryCompanyFinancialCompensationEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, DeliveryCompanyFinancialCompensationEntity::class);
    }
    public function  getFinancialCompensations()
    {
        return $this->createQueryBuilder('FinancialCompensation') 
            ->select('FinancialCompensation.id, FinancialCompensation.kilometers, FinancialCompensation.maxKilometerBonus, FinancialCompensation.minKilometerBonus')
            ->getQuery()
            ->getResult();
    }

    public function  getFinancialCompensationById($id)
    {
        return $this->createQueryBuilder('FinancialCompensation') 
            ->andWhere("FinancialCompensation.id = :id ")
            ->setParameter('id',$id)
            ->getQuery()
            ->getOneOrNullResult();
    }
}
