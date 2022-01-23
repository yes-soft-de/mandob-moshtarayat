<?php


namespace App\Manager;

use App\AutoMapping;
use App\Entity\NotificationTokenEntity;
use App\Repository\NotificationTokenEntityRepository;
use App\Request\NotificationTokenRequest;
use Doctrine\ORM\EntityManagerInterface;

class NotificationManager
{
    private $autoMapping;
    private $entityManager;
    /**
     * @var NotificationTokenEntityRepository
     */
    private $notificationTokenEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, NotificationTokenEntityRepository $notificationTokenEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->notificationTokenEntityRepository = $notificationTokenEntityRepository;
    }

    public function getCaptainTokens()
    {
        return $this->notificationTokenEntityRepository->getCaptainTokens();
    }

    public function getAdminsTokens()
    {
        return $this->notificationTokenEntityRepository->getAdminsTokens();
    }

    public function getStoreTokens($storeIDs)
    {
        return $this->notificationTokenEntityRepository->getStoreTokens($storeIDs);
    }

    public function notificationTokenCreate(NotificationTokenRequest $request)
    {
        $create = $this->autoMapping->map(NotificationTokenRequest::class, NotificationTokenEntity::class, $request);

        $item = $this->notificationTokenEntityRepository->findBy(['userID' => $request->getUserID()]);
        if ($item)
        {
            $this->entityManager->remove($item[0]);
            $this->entityManager->flush();
        }

        if ($request->getDate())
        {
            $create->setDate($request->getDate());
        }

        $this->entityManager->persist($create);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $create;
    }

    public function deleteToken($id)
    {
        $item = $this->notificationTokenEntityRepository->find($id);

        if ($item)
        {
            $this->entityManager->remove($item);
            $this->entityManager->flush();
        }
    }

    public function getNotificationTokenByUserID($userID)
    {
        $token = $this->notificationTokenEntityRepository->findBy(['userID' => $userID]);

        return $token[0]->getToken();
    }

    public function getCaptainRoomID($roomID)
    {
        return $this->notificationTokenEntityRepository->getCaptainRoomID($roomID);
    }

    public function getStoreRoomID($roomID)
    {
        return $this->notificationTokenEntityRepository->getStoreRoomID($roomID);
    }

    public function getClientRoomID($roomID)
    {
        return $this->notificationTokenEntityRepository->getClientRoomID($roomID);
    }

    public function getAnonymousToken($anonymousChatID)
    {
        return $this->notificationTokenEntityRepository->getAnonymousToken($anonymousChatID);
    }
}
