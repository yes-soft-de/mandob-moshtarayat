<?php

namespace App\Repository;

use App\Entity\VerificationEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method VerificationEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method VerificationEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method VerificationEntity[]    findAll()
 * @method VerificationEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class VerificationEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, VerificationEntity::class);
    }

    // return verification entity
    public function getVerificationCodeByCode($verificationCode)
    {
        return $this->createQueryBuilder('verificationEntity')

            ->andWhere('verificationEntity.code = :verificationCode')
            ->setParameter('verificationCode', $verificationCode)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getByUserIdAndCode($userID, $verificationCode)
    {
        return $this->createQueryBuilder('verificationEntity')
            ->select('verificationEntity.id', 'verificationEntity.code', 'verificationEntity.userID', 'verificationEntity.createdAt')

            ->andWhere('verificationEntity.code = :verificationCode')
            ->setParameter('verificationCode', $verificationCode)

            ->andWhere('verificationEntity.userID = :userID')
            ->setParameter('userID', $userID)

            ->getQuery()
            ->getOneOrNullResult();
    }

    // return verification entity
    public function getVerificationCodeByUserID($userID)
    {
        return $this->createQueryBuilder('verificationEntity')

            ->andWhere('verificationEntity.userID = :userID')
            ->setParameter('userID', $userID)

            ->getQuery()
            ->getResult();
    }

}
