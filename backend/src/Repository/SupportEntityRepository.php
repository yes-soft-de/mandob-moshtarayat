<?php

namespace App\Repository;

use App\Entity\SupportEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use App\Entity\StoreOwnerProfileEntity;
use Doctrine\ORM\Query\Expr\Join;
/**
 * @method SupportEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method SupportEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method SupportEntity[]    findAll()
 * @method SupportEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class SupportEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, SupportEntity::class);
    }

    public function getSupports()
    {
        return $this->createQueryBuilder('ReportEntity')
            ->addSelect('ReportEntity.id', 'ReportEntity.orderId', 'ReportEntity.reason', 'ReportEntity.userId', 'userProfileEntity.storeOwnerName', 'ReportEntity.roomID', 'ReportEntity.newMessageStatus') 

            ->leftJoin(StoreOwnerProfileEntity::class, 'userProfileEntity', Join::WITH, 'userProfileEntity.userID = ReportEntity.userId')
            
            ->getQuery()
            ->getResult();
    }

    public function getSupport($id)
    {
        return $this->createQueryBuilder('ReportEntity')
            ->addSelect('ReportEntity.id', 'ReportEntity.orderId', 'ReportEntity.reason', 'ReportEntity.userId', 'userProfileEntity.storeOwnerName', 'ReportEntity.roomID', 'ReportEntity.newMessageStatus') 

            ->leftJoin(StoreOwnerProfileEntity::class, 'userProfileEntity', Join::WITH, 'userProfileEntity.userID = ReportEntity.userId')
            ->andWhere('ReportEntity.id = :id')
            ->setParameter('id',$id)
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getreortByRoomID($roomID)
    {
        return $this->createQueryBuilder('ReportEntity')
            ->andWhere('ReportEntity.roomID = :roomID')
            ->setParameter('roomID',$roomID)
            ->getQuery()
            ->getOneOrNullResult();
    }
}
