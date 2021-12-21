<?php

namespace App\Repository;

use App\Entity\AnnouncementEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method AnnouncementEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method AnnouncementEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method AnnouncementEntity[]    findAll()
 * @method AnnouncementEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class AnnouncementEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, AnnouncementEntity::class);
    }

    public function  getAnnouncementById($id)
    {
        return $this->createQueryBuilder('UpdateEntity') 
            ->andWhere("UpdateEntity.id = :id ")
            ->setParameter('id',$id)
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function  getAnnouncements()
    {
        return $this->createQueryBuilder('UpdateEntity') 
            ->select('UpdateEntity.id, UpdateEntity.title, UpdateEntity.content')
            ->getQuery()
            ->getResult();
    }
}
