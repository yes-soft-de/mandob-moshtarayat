<?php

namespace App\Repository;

use App\Constant\RepresentativeStoreLinkTypeConstant;
use App\Entity\RepresentativeStoreLinkEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method RepresentativeStoreLinkEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method RepresentativeStoreLinkEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method RepresentativeStoreLinkEntity[]    findAll()
 * @method RepresentativeStoreLinkEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class RepresentativeStoreLinkEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, RepresentativeStoreLinkEntity::class);
    }

    public function getRepresentativeStoreLinkByStoreOwnerIP($storeOwnerIP): ?array
    {
        return $this->createQueryBuilder('representativeStoreLinkEntity')
            ->select('representativeStoreLinkEntity.id', 'representativeStoreLinkEntity.linkStatus', 'representativeStoreLinkEntity.representativeUserID', 'representativeStoreLinkEntity.storeOwnerUserID',
             'representativeStoreLinkEntity.storeOwnerIP')

            ->andWhere('representativeStoreLinkEntity.storeOwnerIP = :storeOwnerIP')
            ->setParameter('storeOwnerIP', $storeOwnerIP)

            ->andWhere('representativeStoreLinkEntity.linkStatus = :status')
            ->setParameter('status', RepresentativeStoreLinkTypeConstant::$REPRESENTATIVE_STORE_NOT_LINKED)

            ->getQuery()
            ->getOneOrNullResult();
    }
}
