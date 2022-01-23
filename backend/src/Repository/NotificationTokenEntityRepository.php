<?php

namespace App\Repository;

use App\Entity\AnonymousChatEntity;
use App\Entity\ClientProfileEntity;
use App\Entity\NotificationTokenEntity;
use App\Entity\StaffProfileEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\SupportEntity;
use App\Entity\CaptainProfileEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;
/**
 * @method NotificationTokenEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method NotificationTokenEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method NotificationTokenEntity[]    findAll()
 * @method NotificationTokenEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class NotificationTokenEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, NotificationTokenEntity::class);
    }

    public function getCaptainTokens()
    {
        return $this->createQueryBuilder('NotificationTokenEntity')
            ->select('NotificationTokenEntity.token')

            ->leftJoin(CaptainProfileEntity::class, 'captainProfileEntity', Join::WITH, 'captainProfileEntity.captainID = NotificationTokenEntity.userID')

            ->andWhere("captainProfileEntity.status = :status ")

            ->setParameter('status', 'active')

            ->getQuery()
            ->getResult();
    }

    public function getAnonymousToken($anonymousChatID)
    {
        return $this->createQueryBuilder('NotificationTokenEntity')
            ->select('anonymousChatEntity.token')

            ->leftJoin(AnonymousChatEntity::class, 'anonymousChatEntity', Join::WITH, 'anonymousChatEntity.id = :anonymousChatID')

            ->andWhere("anonymousChatEntity.id = :anonymousChatID ")

            ->setParameter('anonymousChatID', $anonymousChatID)

            ->groupBy('anonymousChatEntity.id')

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getAdminsTokens()
    {
        return $this->createQueryBuilder('NotificationTokenEntity')
            ->select('NotificationTokenEntity.token')

            ->leftJoin(StaffProfileEntity::class, 'staffProfileEntity', Join::WITH, 'staffProfileEntity.adminID = NotificationTokenEntity.userID')

            ->andWhere('staffProfileEntity.adminID = NotificationTokenEntity.userID')

            ->getQuery()
            ->getResult();
    }

    public function getStoreTokens($storeIDs)
    {
        return $this->createQueryBuilder('NotificationTokenEntity')
            ->select('NotificationTokenEntity.token')

            ->andWhere("NotificationTokenEntity.userID IN (:storeIDs)")

            ->setParameter('storeIDs', $storeIDs)

            ->getQuery()
            ->getResult();
    }
}