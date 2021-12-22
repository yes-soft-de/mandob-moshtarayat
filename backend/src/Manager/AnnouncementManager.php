<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\AnnouncementEntity;
use App\Repository\AnnouncementEntityRepository;
use App\Request\AnnouncementCreateRequest;
use App\Request\AnnouncementUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;


class AnnouncementManager
{
    private $autoMapping;
    private $entityManager;
    private $announcementEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, AnnouncementEntityRepository $announcementEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->announcementEntityRepository = $announcementEntityRepository;
    }

    public function createAnnouncement(AnnouncementCreateRequest $request)
    {
        $entity = $this->autoMapping->map(AnnouncementCreateRequest::class, AnnouncementEntity::class, $request);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }

    public function updateAnnouncement(AnnouncementUpdateRequest $request)
    {
        $entity = $this->announcementEntityRepository->find($request->getId());

        if (!$entity) {
            return null;
        }
        $entity = $this->autoMapping->mapToObject(AnnouncementUpdateRequest::class, AnnouncementEntity::class, $request, $entity);

        $this->entityManager->flush();

        return $entity;
    } 

    public function getAnnouncementById($id)
    {
        return $this->announcementEntityRepository->getAnnouncementById($id);
    }

    public function getAnnouncements()
    {
       return $this->announcementEntityRepository->getAnnouncements();
    }
}
