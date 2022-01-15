<?php

namespace App\Repository;

use App\Entity\MandobProfileEntity;
use App\Entity\UserEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method MandobProfileEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method MandobProfileEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method MandobProfileEntity[]    findAll()
 * @method MandobProfileEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class MandobProfileEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, MandobProfileEntity::class);
    }

    public function getMandobProfileByMandobID($mandobID)
    {
        return $this->createQueryBuilder('profile')

            ->addSelect('profile.id', 'profile.mandobID', 'profile.mandobName', 'profile.image', 'profile.location', 'profile.status', 'profile.phone', 'profile.bankName', 'profile.bankAccountNumber', 'profile.stcPay', 'profile.age')
            ->addSelect('UserEntity.createDate')

            ->leftJoin(UserEntity::class, 'UserEntity', Join::WITH, 'UserEntity.id = profile.mandobID')

            ->andWhere('profile.mandobID=:mandobID')

            ->setParameter('mandobID', $mandobID)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getMandobProfile($mandobID)
    {
        return $this->createQueryBuilder('profile')

            ->andWhere('profile.mandobID = :mandobID')

            ->setParameter('mandobID', $mandobID)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function mandobFilterByStatus($status)
    {
        return $this->createQueryBuilder('profile')
            ->select('profile.id', 'profile.mandobID', 'profile.mandobName', 'profile.image', 'profile.location', 'profile.status', 'profile.phone', 'profile.bankName', 'profile.bankAccountNumber', 'profile.stcPay', 'profile.age', 'profile.roomID')

            ->andWhere('profile.status = :status')

            ->setParameter('status', $status)

            ->getQuery()
            ->getResult();
    }

    public function getProfileByMandobID($mandobID)
    {
        return $this->createQueryBuilder('profile')
            ->select('profile.id', 'profile.mandobID', 'profile.mandobName', 'profile.image', 'profile.status', 'profile.phone', 'profile.bankName', 'profile.bankAccountNumber', 'profile.stcPay',
                'profile.age', 'profile.roomID')

            ->andWhere('profile.mandobID = :mandobID')
            ->setParameter('mandobID', $mandobID)

            ->getQuery()
            ->getOneOrNullResult();
    }
}
