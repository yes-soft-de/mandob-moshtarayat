<?php

namespace App\Repository;

use App\Entity\StoreOwnerBranchEntity;
use App\Entity\StoreOwnerProfileEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;

/**
 * @method StoreOwnerBranchEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method StoreOwnerBranchEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method StoreOwnerBranchEntity[]    findAll()
 * @method StoreOwnerBranchEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class StoreOwnerBranchEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, StoreOwnerBranchEntity::class);
    }

    public function getBranchesByStoreOwnerProfileID($storeOwnerProfileID)
    {
        return $this->createQueryBuilder('BranchesEntity')
            ->select('BranchesEntity.id', 'BranchesEntity.storeOwnerProfileID', 'BranchesEntity.location', 'BranchesEntity.city', 'BranchesEntity.branchName','userProfileEntity.free','userProfileEntity.storeOwnerName','userProfileEntity.status','BranchesEntity.isActive') 

            ->leftJoin(StoreOwnerProfileEntity::class, 'userProfileEntity', Join::WITH, 'userProfileEntity.id = BranchesEntity.storeOwnerProfileID')

            ->andWhere("BranchesEntity.storeOwnerProfileID = :storeOwnerProfileID ")

            ->setParameter('storeOwnerProfileID',$storeOwnerProfileID)
            ->getQuery()
            ->getResult();
    }

    public function branchesByStoreOwnerProfileID($storeOwnerProfileID)
    {
        return $this->createQueryBuilder('BranchesEntity')
            ->select('BranchesEntity.id', 'BranchesEntity.storeOwnerProfileID', 'BranchesEntity.location', 'BranchesEntity.city', 'BranchesEntity.branchName') 

            ->andWhere("BranchesEntity.storeOwnerProfileID = :storeOwnerProfileID ")

            ->setParameter('storeOwnerProfileID',$storeOwnerProfileID)
            ->getQuery()
            ->getResult();
    }

    public function getBrancheById($userId)
    {
        return $this->createQueryBuilder('BranchesEntity')
            ->select('BranchesEntity.id', 'BranchesEntity.ownerID', 'BranchesEntity.location', 'BranchesEntity.city', 'BranchesEntity.branchName') 

            ->andWhere("BranchesEntity.ownerID = :userId ")

            ->setParameter('userId',$userId)
            ->getQuery()
            ->getResult();
    }
}
