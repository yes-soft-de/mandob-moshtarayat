<?php


namespace App\Service;

use App\AutoMapping;
use App\Entity\NotificationLocalEntity;
use App\Manager\NotificationLocalManager;
use App\Request\NotificationLocalCreateRequest;
use App\Response\NotificationLocalResponse;

class NotificationLocalService
{
    /**
     * @var NotificationLocalManager
     */
    private $notificationLocalManager;
    /**
     * @var AutoMapping
     */
    private $autoMapping;

    public function __construct(AutoMapping $autoMapping, NotificationLocalManager $notificationLocalManager)
    {
        $this->autoMapping = $autoMapping;
        $this->notificationLocalManager = $notificationLocalManager;
    }

    public function createNotificationLocal($userID, $title, $message, $orderNumber)
    {
        $request = new NotificationLocalCreateRequest();
        $request->setUserID($userID);
        $request->setTitle($title);
        $request->setMessage($message);
        $request->setOrderNumber($orderNumber);
        $item = $this->notificationLocalManager->createNotificationLocal($request);

        return $this->autoMapping->map(NotificationLocalEntity::class, NotificationLocalResponse::class, $item);
    }

    public function getLocalNotificationById($id)
    {
        $item = $this->notificationLocalManager->getLocalNotificationById($id);
        return $this->autoMapping->map(NotificationLocalEntity::class, NotificationLocalResponse::class, $item);

    }

    public function getLocalNotifications($userID)
    {
        $response = [];
        $items = $this->notificationLocalManager->getLocalNotifications($userID);
        foreach ($items as $item) {
            $response[] = $this->autoMapping->map("array", NotificationLocalResponse::class, $item);
        }
        return $response;
    }
}