<?php

namespace App\Repository;

use App\Entity\CaptainProfileEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\OrderEntity;
use App\Entity\StoreOwnerBranchEntity;
use App\Entity\UserEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;

/**
 * @method CaptainProfileEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method CaptainProfileEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method CaptainProfileEntity[]    findAll()
 * @method CaptainProfileEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class CaptainProfileEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, CaptainProfileEntity::class);
    }

    public function getCaptainprofile($captainID)
    {
        return $this->createQueryBuilder('captainProfile')

            ->andWhere('captainProfile.captainID=:captainID')
            ->setParameter('captainID', $captainID)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getCaptainProfileByCaptainID($captainID)
    {
        return $this->createQueryBuilder('captainProfile')
            ->addSelect('captainProfile.id', 'captainProfile.captainID', 'captainProfile.captainName', 'captainProfile.image', 'captainProfile.location', 'captainProfile.age', 'captainProfile.car', 'captainProfile.drivingLicence', 'captainProfile.salary', 'captainProfile.status', 'captainProfile.specialLink', 'captainProfile.phone', 'captainProfile.isOnline', 'captainProfile.bankName', 'captainProfile.bankAccountNumber', 'captainProfile.stcPay', 'captainProfile.mechanicLicense', 'captainProfile.identity', 'captainProfile.bounce')
            ->addSelect('UserEntity.createDate')
            ->leftJoin(UserEntity::class, 'UserEntity', Join::WITH, 'UserEntity.id = captainProfile.captainID')
            ->andWhere('captainProfile.captainID=:captainID')
            
            ->setParameter('captainID', $captainID)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getByCaptainIDForUpdate($captainID)
    {
        return $this->createQueryBuilder('captainProfile')

            ->andWhere('captainProfile.captainID = :captainID')
            ->setParameter('captainID', $captainID)
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getCaptainProfileByID($captainProfileId)
    {
        return $this->createQueryBuilder('captainProfile')
            ->addSelect('captainProfile.id', 'captainProfile.captainID', 'captainProfile.captainName', 'captainProfile.image', 'captainProfile.location', 'captainProfile.age', 'captainProfile.car', 'captainProfile.drivingLicence', 'captainProfile.salary', 'captainProfile.status', 'captainProfile.state as vacationStatus', 'captainProfile.bounce', 'captainProfile.roomID', 'captainProfile.specialLink', 'captainProfile.isOnline', 'captainProfile.newMessageStatus', 'captainProfile.bankName', 'captainProfile.bankAccountNumber', 'captainProfile.stcPay', 'captainProfile.mechanicLicense', 'captainProfile.identity')
            ->addSelect('OrderEntity.state')

            ->leftJoin(OrderEntity::class, 'OrderEntity', Join::WITH, 'OrderEntity.captainID = captainProfile.captainID')

            ->andWhere('captainProfile.id=:captainProfileId')
            
            ->setParameter('captainProfileId', $captainProfileId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getCaptainsInactive()
    {
        return $this->createQueryBuilder('captainProfile')
            ->addSelect('captainProfile.id', 'captainProfile.captainID', 'captainProfile.captainName', 'captainProfile.image', 'captainProfile.location', 'captainProfile.age', 'captainProfile.car', 'captainProfile.drivingLicence', 'captainProfile.salary', 'captainProfile.status', 'captainProfile.specialLink', 'captainProfile.mechanicLicense', 'captainProfile.identity')

            ->andWhere("captainProfile.status = :inactive ")
            ->setParameter('inactive', 'inactive')
            ->getQuery()
            ->getResult();
    }

    public function getCaptainsState($state)
    {
        return  $this->createQueryBuilder('captainProfile')
         
            ->select('captainProfile.id', 'captainProfile.captainID', 'captainProfile.captainName', 'captainProfile.image', 'captainProfile.location', 'captainProfile.age', 'captainProfile.car', 'captainProfile.drivingLicence', 'captainProfile.salary', 'captainProfile.status', 'captainProfile.bounce', 'captainProfile.specialLink')
            ->addSelect('OrderEntity.captainID', 'OrderEntity.state')
            
            ->leftJoin(OrderEntity::class, 'OrderEntity', Join::WITH, 'OrderEntity.captainID = captainProfile.captainID')
            ->andWhere("OrderEntity.state = 'in store' or OrderEntity.state = 'picked' or OrderEntity.state = 'ongoing' or OrderEntity.state = 'cash'") 
            // ->andWhere('OrderEntity.state =:state')
            ->addGroupBy('captainProfile.id')
            ->addGroupBy('captainProfile.captainID')
            ->addGroupBy('captainProfile.captainName')
            ->addGroupBy('captainProfile.image')
            ->addGroupBy('captainProfile.location')
            ->addGroupBy('captainProfile.age')
            ->addGroupBy('captainProfile.car')
            ->addGroupBy('captainProfile.drivingLicence')
            ->addGroupBy('captainProfile.salary')
            ->addGroupBy('captainProfile.status')
            ->addGroupBy('captainProfile.bounce')
            ->addGroupBy('captainProfile.specialLink')
            ->addGroupBy('OrderEntity.state')
            // ->setParameter('state', $state)
            ->getQuery()
            ->getResult();
    }

    public function captainIsActive($captainID)
    {
        return $this->createQueryBuilder('captainProfile')
            ->select('captainProfile.status')

            ->andWhere('captainProfile.captainID = :captainID')

            ->setParameter('captainID', $captainID)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function countpendingCaptains()
    {
        return $this->createQueryBuilder('captainProfile')
            ->select('count (captainProfile.id) as countPendingCaptains')

            ->andWhere("captainProfile.status = :inactive")
            ->setParameter('inactive', 'inactive')
            ->getQuery()
            ->getOneOrNullResult();
    }
    
    public function countOngoingCaptains()
    {
        return $this->createQueryBuilder('captainProfile')
            ->select('count (OrderEntity.captainID) as countOngoingCaptains')

            ->join(OrderEntity::class, 'OrderEntity')

            ->andWhere("OrderEntity.state = :ongoing")
            ->setParameter('ongoing','ongoing')
            ->getQuery()
            ->getOneOrNullResult();
    }
   
    public function countDayOfCaptains()
    {
        return $this->createQueryBuilder('captainProfile')
            ->select('count (captainProfile.id) as countDayOfCaptains')

            ->andWhere("captainProfile.state = 'vacation'")
            ->setParameter('vacation','vacation')
            ->getQuery()
            ->getOneOrNullResult();
    }
   
    public function getCaptainsInVacation()
    {
        return $this->createQueryBuilder('captainProfile')
            ->select('captainProfile.id', 'captainProfile.captainID', 'captainProfile.captainName', 'captainProfile.image', 'captainProfile.location', 'captainProfile.age', 'captainProfile.car', 'captainProfile.drivingLicence', 'captainProfile.salary', 'captainProfile.status', 'captainProfile.state', 'captainProfile.specialLink')

            ->andWhere("captainProfile.state = :vacation")
            ->setParameter('vacation', 'vacation')
            ->getQuery()
            ->getResult();
    }

    public function getCaptainAsArray($id)
    {
        return $this->createQueryBuilder('captainProfile')

            ->select('captainProfile.id', 'captainProfile.captainID', 'captainProfile.captainName', 'captainProfile.image', 'captainProfile.location', 'captainProfile.age', 'captainProfile.car', 'captainProfile.drivingLicence', 'captainProfile.salary', 'captainProfile.status', 'captainProfile.bounce', 'captainProfile.specialLink', 'captainProfile.bankName', 'captainProfile.bankAccountNumber', 'captainProfile.stcPay')

            ->andWhere('captainProfile.id =:id')
            ->setParameter('id', $id)
            ->getQuery()
            ->getResult();
    }

    public function getCaptainAsArrayByCaptainId($captainId)
    {
        return $this->createQueryBuilder('captainProfile')

            ->select('captainProfile.id', 'captainProfile.captainID', 'captainProfile.captainName', 'captainProfile.image', 'captainProfile.salary',  'captainProfile.bounce')

            ->andWhere('captainProfile.captainID =:captainID')
            ->setParameter('captainID', $captainId)
            ->getQuery()
            ->getResult();
    }

    public function getCaptains()
    {
        return $this->createQueryBuilder('captainProfile')

            ->select('captainProfile.id', 'captainProfile.captainID', 'captainProfile.captainName', 'captainProfile.image', 'captainProfile.location', 'captainProfile.age', 'captainProfile.car', 'captainProfile.drivingLicence', 'captainProfile.salary', 'captainProfile.status', 'captainProfile.bounce', 'captainProfile.specialLink','captainProfile.newMessageStatus')

            ->addSelect('orderEntity.id as orderID', 'orderEntity.date', 'orderEntity.source', 'orderEntity.branchId', 'orderEntity.payment', 'orderEntity.destination','branchesEntity.location','branchesEntity.branchName','branchesEntity.city as branchCity','orderEntity.ownerID','orderEntity.captainID')

            ->addSelect('StoreOwnerProfileEntity.id', 'StoreOwnerProfileEntity.storeOwnerName', 'StoreOwnerProfileEntity.storeOwnerName', 'StoreOwnerProfileEntity.image', 'StoreOwnerProfileEntity.story', 'StoreOwnerProfileEntity.free')

            ->leftJoin(OrderEntity::class, 'orderEntity', Join::WITH, 'captainProfile.id = orderEntity.captainID')

            ->leftJoin(StoreOwnerBranchEntity::class, 'branchesEntity', Join::WITH, 'orderEntity.branchId = branchesEntity.id')

            ->leftJoin(StoreOwnerProfileEntity::class, 'StoreOwnerProfileEntity', Join::WITH, 'orderEntity.ownerID = StoreOwnerProfileEntity.storeOwnerName')

            ->getQuery()
            ->getResult();
    }

    public function getAllCaptains()
    {
        return $this->createQueryBuilder('captainProfile')
            ->select('captainProfile.id', 'captainProfile.captainID', 'captainProfile.captainName', 'captainProfile.image', 'captainProfile.location', 'captainProfile.age', 'captainProfile.car', 'captainProfile.drivingLicence', 'captainProfile.salary', 'captainProfile.status', 'captainProfile.state', 'captainProfile.roomID', 'captainProfile.bounce', 'captainProfile.specialLink', 'captainProfile.isOnline', 'captainProfile.newMessageStatus', 'captainProfile.bankName', 'captainProfile.bankAccountNumber', 'captainProfile.stcPay', 'captainProfile.phone')

            ->getQuery()
            ->getResult();
    }
    
    public function getcaptainByRoomID($roomID)
    {
        return $this->createQueryBuilder('captainProfile')
            ->andWhere('captainProfile.roomID = :roomID')
            ->setParameter('roomID',$roomID)
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getTop5Captains()
    {
        return $this->createQueryBuilder('captainProfileEntity')
           
            ->select( 'captainProfileEntity.captainName', 'captainProfileEntity.car', 'captainProfileEntity.age', 'captainProfileEntity.salary', 'captainProfileEntity.bounce', 'captainProfileEntity.image', 'captainProfileEntity.specialLink')

            ->addSelect('OrderEntity.captainID', 'count(OrderEntity.captainID) countOrdersDeliverd')

            ->leftJoin(OrderEntity::class, 'OrderEntity', Join::WITH, 'OrderEntity.captainID = captainProfileEntity.captainID')

            // ->andWhere("OrderEntity.state =:deliverd")
            // ->setParameter('deliverd', 'deliverd')
            ->addGroupBy('OrderEntity.captainID')
            
            ->having('count(OrderEntity.captainID) > 0')
            ->setMaxResults(5)
            ->addOrderBy('countOrdersDeliverd','DESC')
            ->getQuery()
            ->getResult();
    }

    public function getTopCaptainsInLastMonthDate($fromDate, $toDate)
    {
        return $this->createQueryBuilder('captainProfileEntity')

            ->select('captainProfileEntity.captainName', 'captainProfileEntity.car', 'captainProfileEntity.age', 'captainProfileEntity.salary', 'captainProfileEntity.bounce', 'captainProfileEntity.image', 'captainProfileEntity.specialLink', 'captainProfileEntity.drivingLicence')
            
            ->addSelect('OrderEntity.captainID', 'count(OrderEntity.captainID) countOrdersInMonth')
           
            ->leftJoin(OrderEntity::class, 'OrderEntity', Join::WITH, 'OrderEntity.captainID = captainProfileEntity.captainID')

             ->where('OrderEntity.date >= :fromDate')
             ->andWhere('OrderEntity.date < :toDate')
            ->addGroupBy('OrderEntity.captainID')
            
            ->having('count(OrderEntity.captainID) > 0')
            ->setMaxResults(15)
            ->addOrderBy('countOrdersInMonth','DESC')
         
            ->setParameter('fromDate', $fromDate)
            ->setParameter('toDate', $toDate)
            ->getQuery()
            ->getResult();
    }

    public function countCaptains()
    {
        return  $this->createQueryBuilder('captainProfileEntity')
                ->select('count(captainProfileEntity.id) as count')
                ->andWhere("captainProfileEntity.status = :active")
                ->setParameter('active', 'active')
                ->getQuery()
                ->getSingleScalarResult();
    }

    public function captainFilter($name)
    {
        return $this->createQueryBuilder('captainProfileEntity')
        ->select('captainProfileEntity.id','captainProfileEntity.captainID','captainProfileEntity.captainName', 'captainProfileEntity.image')

            ->andWhere('captainProfileEntity.captainName LIKE :name')

            ->setParameter('name', '%'.$name.'%')
            ->setMaxResults(20)
            ->getQuery()
            ->getResult();
    }
}
