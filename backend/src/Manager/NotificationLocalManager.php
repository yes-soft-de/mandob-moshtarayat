<?php


namespace App\Manager;

use App\AutoMapping;
use App\Entity\NotificationLocalEntity;
use App\Repository\NotificationLocalEntityRepository;
use App\Request\NotificationLocalCreateRequest;
use Doctrine\ORM\EntityManagerInterface;


class NotificationLocalManager
{
    /**
     * @var NotificationLocalEntityRepository
     */
    private $notificationLocalEntityRepository;
    /**
     * @var EntityManagerInterface
     */
    private $entityManager;
    /**
     * @var AutoMapping
     */
    private $autoMapping;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, NotificationLocalEntityRepository $notificationLocalEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->notificationLocalEntityRepository = $notificationLocalEntityRepository;
    }

    public function createNotificationLocal(NotificationLocalCreateRequest $request)
    {
        $entity = $this->autoMapping->map(NotificationLocalCreateRequest::class, NotificationLocalEntity::class, $request);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }

    public function getLocalNotificationById($id)
    {
        return $this->notificationLocalEntityRepository->find($id);
    }

    public function getLocalNotifications($userID)
    {
        return $this->notificationLocalEntityRepository->getLocalNotifications($userID);
    }
}
