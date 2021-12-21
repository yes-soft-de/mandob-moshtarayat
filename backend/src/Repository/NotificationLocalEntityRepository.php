<?php

namespace App\Repository;

use App\Entity\NotificationLocalEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method NotificationLocalEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method NotificationLocalEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method NotificationLocalEntity[]    findAll()
 * @method NotificationLocalEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class NotificationLocalEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, NotificationLocalEntity::class);
    }

    public function getLocalNotifications($userID)
    {
        return $this->createQueryBuilder('notificationLocal')
            ->select('notificationLocal.id', 'notificationLocal.title', 'notificationLocal.message', 'notificationLocal.userID', 'notificationLocal.createdAt', 'notificationLocal.orderNumber')
            ->where('notificationLocal.userID = :userID')
            ->setParameter('userID',$userID)
            ->getQuery()
            ->getResult();
    }
}
