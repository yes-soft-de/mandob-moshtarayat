<?php

namespace App\Repository;

use App\Entity\StaffProfileEntity;
use App\Entity\UserEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method StaffProfileEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method StaffProfileEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method StaffProfileEntity[]    findAll()
 * @method StaffProfileEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class StaffProfileEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, StaffProfileEntity::class);
    }

    public function getCaptainProfileByCaptainID($adminID)
    {
        return $this->createQueryBuilder('staff')

            ->select('staff.id', 'staff.adminID')
            ->addSelect('UserEntity.createDate')

            ->leftJoin(UserEntity::class, 'UserEntity', Join::WITH, 'UserEntity.id = staff.adminID')

            ->andWhere('staff.adminID=:adminID')

            ->setParameter('adminID', $adminID)

            ->getQuery()
            ->getOneOrNullResult();
    }

}
