<?php

namespace App\Repository;

use App\Entity\ClientPaymentEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method ClientPaymentEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method ClientPaymentEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method ClientPaymentEntity[]    findAll()
 * @method ClientPaymentEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ClientPaymentEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, ClientPaymentEntity::class);
    }   
}
