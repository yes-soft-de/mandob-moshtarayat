<?php

namespace App\Repository;

use App\Entity\RatingEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method RatingEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method RatingEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method RatingEntity[]    findAll()
 * @method RatingEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class RatingEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, RatingEntity::class);
    }

    public function getAvgRating($itemID, $itemType)
    {
        return $this->createQueryBuilder('Rating')
               ->select('AVG(Rating.rating) as rate ')
              
               ->andWhere('Rating.itemID = :itemID')
               ->andWhere('Rating.itemType = :itemType')

               ->setParameter('itemID', $itemID)
               ->setParameter('itemType', $itemType)

               ->getQuery()
               ->getOneOrNullResult();
    }
    public function getAvgOrder($orderNumber)
    {
        return $this->createQueryBuilder('Rating')
               ->select('AVG(Rating.rating) as rate ')
              
               ->andWhere('Rating.orderNumber = :orderNumber')

               ->setParameter('orderNumber', $orderNumber)

               ->getQuery()
               ->getResult();
    }
}
