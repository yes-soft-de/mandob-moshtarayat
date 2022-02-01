<?php


namespace App\Service;

use App\AutoMapping;
use App\Constant\LocalNotificationList;
use App\Constant\LocalStoreNotificationList;
use App\Constant\OrderStateConstant;
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

    public function getLocalStoreNotifications($userID)
    {
        $response = [];

        $items = $this->notificationLocalManager->getLocalStoreNotifications($userID);

        foreach ($items as $item) {
            $response[] = $this->autoMapping->map("array", NotificationLocalResponse::class, $item);
        }

        return $response;
    }

    public function createUpdateOrderStateClientNotificationLocal($state, $userID, $orderNumber, $storeName = null)
    {
        if ($state == OrderStateConstant::$ORDER_STATE_ON_WAY){
            $state = LocalNotificationList::$STATE_ON_WAY_PICK_ORDER." ".$storeName;
        }
        if ($state == OrderStateConstant::$ORDER_STATE_IN_STORE){
            $state =  LocalNotificationList::$STATE_IN_STORE." ".$storeName;
        }
        if ($state == OrderStateConstant::$ORDER_STATE_PICKED){
            $state =  LocalNotificationList::$STATE_PICKED." ".$storeName;
        }
        if ($state == OrderStateConstant::$ORDER_STATE_ONGOING){
            $state =  LocalNotificationList::$STATE_ONGOING;
        }
        if ($state == OrderStateConstant::$ORDER_STATE_DELIVERED){
            $state =  LocalNotificationList::$STATE_DELIVERED;
        }

        $this->createNotificationLocal($userID,  LocalNotificationList::$STATE_TITLE, $state, $orderNumber);
    }

    public function createStoreNotificationLocal($storeIDs, $title, $message, $orderNumber, $stateChange  = null )
    {
        //remove item duplicated
        $storeIDs = array_unique($storeIDs);
        foreach ($storeIDs as $storeOwnerProfileID){
            if($stateChange == true){
                $this->createUpdateOrderStateStoreNotificationLocal($message, $title, $storeOwnerProfileID, $orderNumber);
            }
            else {
                //create store notification local
                $this->createNotificationLocal($storeOwnerProfileID, $title, $message, $orderNumber);
            }
        }
    }

    public function createUpdateOrderStateStoreNotificationLocal($state, $title, $userID, $orderNumber)
    {
        if ($state == OrderStateConstant::$ORDER_STATE_ON_WAY){
            $state = LocalStoreNotificationList::$STATE_ON_WAY_PICK_ORDER;
        }
        if ($state == OrderStateConstant::$ORDER_STATE_IN_STORE){
            $state =  LocalStoreNotificationList::$STATE_IN_STORE;
        }
        if ($state == OrderStateConstant::$ORDER_STATE_PICKED){
            $state =  LocalStoreNotificationList::$STATE_PICKED;
        }
        if ($state == OrderStateConstant::$ORDER_STATE_ONGOING){
            $state =  LocalStoreNotificationList::$STATE_ONGOING;
        }
        if ($state == OrderStateConstant::$ORDER_STATE_DELIVERED){
            $state =  LocalStoreNotificationList::$STATE_DELIVERED;
        }
        if ($state == OrderStateConstant::$ORDER_STATE_CANCEL){
            $state =  LocalStoreNotificationList::$CANCEL_ORDER_SUCCESS;
        }

        $this->createNotificationLocal($userID,  $title, $state, $orderNumber);
    }
}