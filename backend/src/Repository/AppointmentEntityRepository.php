<?php

namespace App\Repository;

use App\Entity\AppointmentEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method AppointmentEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method AppointmentEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method AppointmentEntity[]    findAll()
 * @method AppointmentEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class AppointmentEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, AppointmentEntity::class);
    }

    public function getAppointments()
    {
        return $this->createQueryBuilder('DatingEntityRepository')
            ->select('DatingEntityRepository.id','DatingEntityRepository.userName', 'DatingEntityRepository.phone', 'DatingEntityRepository.isDone')
            ->getQuery()
            ->getResult();
    }
}
