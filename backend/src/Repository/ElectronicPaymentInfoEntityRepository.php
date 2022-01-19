<?php

namespace App\Repository;

use App\Entity\ClientProfileEntity;
use App\Entity\ElectronicPaymentInfoEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
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


    public function getElectronicPaymentInfo()
    {
        return $this->createQueryBuilder('electronicPaymentInfoEntity')

            ->select('electronicPaymentInfoEntity.id', 'electronicPaymentInfoEntity.orderNumber', 'electronicPaymentInfoEntity.transactionID', 'electronicPaymentInfoEntity.token', 'electronicPaymentInfoEntity.amount', 'electronicPaymentInfoEntity.payStatus', 'electronicPaymentInfoEntity.createdAt', 'electronicPaymentInfoEntity.updatedAt', 'electronicPaymentInfoEntity.clientID')
            ->addSelect('clientProfileEntity.clientName')

            ->leftJoin(ClientProfileEntity::class,'clientProfileEntity',Join::WITH, 'clientProfileEntity.clientID = electronicPaymentInfoEntity.clientID')

            ->getQuery()
            ->getResult();
    }

}
