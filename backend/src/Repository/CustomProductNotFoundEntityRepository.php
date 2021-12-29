<?php

namespace App\Repository;

use App\Entity\CustomProductNotFoundEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method CustomProductNotFoundEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method CustomProductNotFoundEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method CustomProductNotFoundEntity[]    findAll()
 * @method CustomProductNotFoundEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class CustomProductNotFoundEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, CustomProductNotFoundEntity::class);
    }

    public function getCustomProductsNotFound()
    {
        return $this->createQueryBuilder('CustomProduct')

            ->addSelect('CustomProduct.id', 'CustomProduct.productName', 'CustomProduct.productImage', 'CustomProduct.detail', 'CustomProduct.clientID')
            ->getQuery()
            ->getResult();
    }

    public function getCustomProductNotFound($id)
    {
        return $this->createQueryBuilder('CustomProduct')

            ->addSelect('CustomProduct.id', 'CustomProduct.productName', 'CustomProduct.productImage', 'CustomProduct.detail', 'CustomProduct.clientID')

            ->andWhere('CustomProduct.id = :id')

            ->setParameter('id',$id)

            ->getQuery()
            ->getOneOrNullResult();
    }
}
