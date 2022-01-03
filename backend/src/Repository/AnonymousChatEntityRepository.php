<?php

namespace App\Repository;

use App\Entity\AnonymousChatEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method AnonymousChatEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method AnonymousChatEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method AnonymousChatEntity[]    findAll()
 * @method AnonymousChatEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class AnonymousChatEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, AnonymousChatEntity::class);
    }

    public function getAnonymousUsersWhoNeedSupport()
    {
        return $this->createQueryBuilder('anonymousChatEntity')
            ->select('anonymousChatEntity.id', 'anonymousChatEntity.roomID', 'anonymousChatEntity.name as clientName', 'anonymousChatEntity.createdAt')

            ->andWhere('anonymousChatEntity.needSupport = :needSupport')
            ->setParameter('needSupport', 1)

            ->getQuery()
            ->getResult();
    }

}
