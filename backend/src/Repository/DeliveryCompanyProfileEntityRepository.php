<?php

namespace App\Repository;

use App\Entity\DeliveryCompanyProfileEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use App\Entity\CaptainProfileEntity;
use App\Entity\StoreOwnerProfileEntity;
use Doctrine\ORM\Query\Expr\Join;

/**
 * @method DeliveryCompanyProfileEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method DeliveryCompanyProfileEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method DeliveryCompanyProfileEntity[]    findAll()
 * @method DeliveryCompanyProfileEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class DeliveryCompanyProfileEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, DeliveryCompanyProfileEntity::class);
    }
 
    public function  getcompanyinfoById($id)
    {
        return $this->createQueryBuilder('CompanyInfoEntity') 
            ->andWhere("CompanyInfoEntity.id = :id ")
            ->setParameter('id',$id)
            ->getQuery()
            ->getOneOrNullResult();
    }
    
    public function  getcompanyinfoAll()
    {
        return $this->createQueryBuilder('CompanyInfoEntity') 
            ->select('CompanyInfoEntity.id, CompanyInfoEntity.phone, CompanyInfoEntity.phone2, CompanyInfoEntity.whatsapp, CompanyInfoEntity.fax, CompanyInfoEntity.bank, CompanyInfoEntity.stc, CompanyInfoEntity.email')
            ->getQuery()
            ->getResult();
    }

    public function  getAllCompanyInfoForStoreOwner($storeOwnerID)
    {
        return $this->createQueryBuilder('CompanyInfoEntity') 
            ->select('CompanyInfoEntity.id, CompanyInfoEntity.phone, CompanyInfoEntity.phone2, CompanyInfoEntity.whatsapp, CompanyInfoEntity.fax, CompanyInfoEntity.bank, CompanyInfoEntity.stc, CompanyInfoEntity.email')
            ->addSelect('userProfileEntity.roomID')
            ->leftJoin(StoreOwnerProfileEntity::class, 'userProfileEntity', Join::WITH, 'userProfileEntity.storeOwnerID = :storeOwnerID')
            ->setParameter('storeOwnerID',$storeOwnerID)
            ->getQuery()
            ->getResult();
    }

    public function getAllCompanyInfoForCaptain($captainID)
    {
        return $this->createQueryBuilder('CompanyInfoEntity') 
            ->select('CompanyInfoEntity.id, CompanyInfoEntity.phone, CompanyInfoEntity.phone2, CompanyInfoEntity.whatsapp, CompanyInfoEntity.fax, CompanyInfoEntity.bank, CompanyInfoEntity.stc, CompanyInfoEntity.email')
            ->addSelect('captainProfileEntity.roomID')
            ->leftJoin(CaptainProfileEntity::class, 'captainProfileEntity', Join::WITH, 'captainProfileEntity.captainID = :captainID')
            ->setParameter('captainID',$captainID)
            ->getQuery()
            ->getResult();
    }
}
