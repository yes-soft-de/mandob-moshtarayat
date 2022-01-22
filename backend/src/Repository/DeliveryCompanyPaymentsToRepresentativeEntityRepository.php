<?php

namespace App\Repository;

use App\Entity\DeliveryCompanyPaymentsToRepresentativeEntity;
use App\Entity\MandobProfileEntity;
use App\Entity\UserEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method DeliveryCompanyPaymentsToRepresentativeEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method DeliveryCompanyPaymentsToRepresentativeEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method DeliveryCompanyPaymentsToRepresentativeEntity[]    findAll()
 * @method DeliveryCompanyPaymentsToRepresentativeEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class DeliveryCompanyPaymentsToRepresentativeEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, DeliveryCompanyPaymentsToRepresentativeEntity::class);
    }

    public function getDeliveryCompanyPaymentsToRepresentativeByRepresentativeID($representativeID): ?array
    {
        return $this->createQueryBuilder('paymentsToRepresentative')
            ->select('paymentsToRepresentative.id', 'paymentsToRepresentative.representativeID', 'paymentsToRepresentative.amount, paymentsToRepresentative.date, paymentsToRepresentative.note')

            ->leftJoin(
                UserEntity::class,
                'userEntity',
                Join::WITH,
                'userEntity.userID = paymentsToRepresentative.representativeID'
            )

            ->leftJoin(
                MandobProfileEntity::class,
                'mandobProfileEntity',
                Join::WITH,
                'mandobProfileEntity.mandobID = userEntity.id'
            )

            ->andWhere('userEntity.id = :representativeID')
            ->setParameter('representativeID', $representativeID)

            ->getQuery()
            ->getResult();
    }
}
