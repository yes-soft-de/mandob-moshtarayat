<?php

namespace App\Repository;

use App\Entity\ClientProfileEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method ClientProfileEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method ClientProfileEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method ClientProfileEntity[]    findAll()
 * @method ClientProfileEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ClientProfileEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, ClientProfileEntity::class);
    }

    public function getClientProfileByClientID($clientID)
    {
        return $this->createQueryBuilder('clientProfile')
            ->select('clientProfile.id', 'clientProfile.clientName','clientProfile.clientID', 'clientProfile.image', 'clientProfile.phone', 'clientProfile.roomID', 'clientProfile.location')

            ->andWhere('clientProfile.clientID = :clientID')

            ->setParameter('clientID', $clientID)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getClientProfileByID($id)
    {
        return $this->createQueryBuilder('clientProfile')
            ->select('clientProfile.id', 'clientProfile.clientName','clientProfile.clientID', 'clientProfile.image', 'clientProfile.phone', 'clientProfile.roomID', 'clientProfile.location')

            ->andWhere('clientProfile.id = :id')

            ->setParameter('id', $id)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getClientsProfile()
    {
        return $this->createQueryBuilder('clientProfile')
            ->select('clientProfile.id', 'clientProfile.clientName','clientProfile.clientID', 'clientProfile.image', 'clientProfile.phone','clientProfile.location')

            ->setMaxResults(25)
            ->addOrderBy('clientProfile.id','ASC')
            ->getQuery()
            ->getResult();
    }

    public function countClients()
    {
        return $this->createQueryBuilder('clientProfile')
        ->select('count(clientProfile.id) as count')
        ->getQuery()
        ->getSingleScalarResult();
    }

    public function clientsByName($name)
    {
        return $this->createQueryBuilder('clientProfile')
        ->select('clientProfile.id', 'clientProfile.clientName','clientProfile.clientID', 'clientProfile.image', 'clientProfile.phone','clientProfile.location')

            ->andWhere('clientProfile.clientName LIKE :name')

            ->setParameter('name', '%'.$name.'%')
            ->getQuery()
            ->getResult();
    }
}
