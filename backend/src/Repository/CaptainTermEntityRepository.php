<?php

namespace App\Repository;

use App\Entity\CaptainTermEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method CaptainTermEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method CaptainTermEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method CaptainTermEntity[]    findAll()
 * @method CaptainTermEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class CaptainTermEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, CaptainTermEntity::class);
    }

    public function getTermsCaptain()
    {
        return $this->createQueryBuilder('terms')
            ->select('terms.id', 'terms.content')             
            ->getQuery()
            ->getResult();
    }

    public function getTermsCaptainById($id) 
    {
        return $this->createQueryBuilder('terms') 
            ->andWhere('terms.id = :id')   
            ->setParameter('id',$id)        
            ->getQuery()
            ->getOneOrNullResult();
    }
}
