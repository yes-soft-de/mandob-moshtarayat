<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\AppointmentEntity;
use App\Repository\AppointmentEntityRepository;
use App\Request\AppointmentCreateRequest;
use App\Request\AppointmentUpdateIsDoneRequest;
use Doctrine\ORM\EntityManagerInterface;


class AppointmentManager
{
    private $autoMapping;
    private $entityManager;
    private $appointmentEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, AppointmentEntityRepository $appointmentEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->appointmentEntityRepository = $appointmentEntityRepository;
    }

    public function createAppointment(AppointmentCreateRequest $request)
    {
        $entity = $this->autoMapping->map(AppointmentCreateRequest::class, AppointmentEntity::class, $request);
        $entity->setIsDone(false);
        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }

    public function getAppointments()
    {
        return $this->appointmentEntityRepository->getAppointments();
    }

    public function updateAppointment(AppointmentUpdateIsDoneRequest $request)
    {
        $entity = $this->appointmentEntityRepository->find($request->getId());

        if (!$entity) {
            return null;
        }
        $entity = $this->autoMapping->mapToObject(AppointmentUpdateIsDoneRequest::class, AppointmentEntity::class, $request, $entity);

        $this->entityManager->flush();

        return $entity;
    }
}
