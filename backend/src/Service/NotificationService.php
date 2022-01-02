<?php


namespace App\Service;

use App\AutoMapping;
use App\Entity\NotificationTokenEntity;
use App\Manager\NotificationManager;
use App\Request\SendNotificationRequest;
use App\Service\RoomIdHelperService;
use App\Service\SupportService;
use App\Service\CaptainProfileService;
use App\Request\NotificationTokenRequest;
use App\Response\NotificationTokenResponse;
use Kreait\Firebase\Messaging;
use Kreait\Firebase\Messaging\CloudMessage;
use Kreait\Firebase\Messaging\Notification;
use App\Constant\MessageConstant;
use App\Constant\DeliveryCompanyNameConstant;
use Kreait\Firebase\Messaging\ApnsConfig;

class NotificationService
{
    private $messaging;
    private $notificationManager;
    private $roomIdHelperService;
    private $supportService;
    private $autoMapping;
    private $captainProfileService;

//    const CAPTAIN_TOPIC = 'captains';
    const URL = '/order_details';

    public function __construct(AutoMapping $autoMapping, Messaging $messaging, NotificationManager $notificationManager, RoomIdHelperService $roomIdHelperService, supportService $supportService, CaptainProfileService $captainProfileService)
    {
        $this->messaging = $messaging;
        $this->notificationManager = $notificationManager;
        $this->autoMapping = $autoMapping;
        $this->roomIdHelperService = $roomIdHelperService;
        $this->supportService = $supportService;
        $this->captainProfileService = $captainProfileService;
    }

    public function getTokens()
    {
        return $this->notificationManager->getTokens();
    }

    public function notificationToCaptain($orderNumber)
    {
        $getTokens = $this->getTokens();
        foreach ($getTokens as $token) {
            $tokens[] = $token['token'];
        }

        $payload = [
            'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
            'navigate_route' => self::URL,
            'argument' => $orderNumber,
        ];

        $message = CloudMessage::new()
            ->withNotification(
                Notification::create(DeliveryCompanyNameConstant::$Delivery_Company_Name, MessageConstant::$MESSAGE_CAPTAIN_NEW_ORDER))
            ->withDefaultSounds()
            ->withHighestPossiblePriority();

        $message = $message->withData($payload);

        $this->messaging->sendMulticast($message, $tokens);
    }

    public function notificationOrderUpdateForClient($clientID, $orderNumber)
    {
        $payload = [
            'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
            'navigate_route' => self::URL,
            'argument' => $orderNumber,
        ];

        $msg = MessageConstant::$MESSAGE_STATUS_ORDER_UPDATE." ".$orderNumber;

        $devicesToken = [];

        $firstUserToken = $this->getNotificationTokenByUserID($clientID);

        $devicesToken[] = $firstUserToken;

        $message = CloudMessage::new()
            ->withNotification(Notification::create(DeliveryCompanyNameConstant::$Delivery_Company_Name,$msg ))
            ->withDefaultSounds()
            ->withHighestPossiblePriority();
        $message = $message->withData($payload);

        $this->messaging->sendMulticast($message, $devicesToken);
    }
//TODO
    public function notificationOrderUpdateForStore( $storeIds)
    {
        $storeIDs = array_unique($storeIds);
    }

    public function notificationNewChat($request)
    {
        $item = $this->roomIdHelperService->getByRoomID($request->getRoomID());
        if($item) {
            $devicesToken = [];
            $userTokenOne = $this->getNotificationTokenByUserID($item['captainID']);
            $devicesToken[] = $userTokenOne;
            $userTokenTwo = $this->getNotificationTokenByUserID($item['ownerID']);
            $devicesToken[] = $userTokenTwo;

            $message = CloudMessage::new()
                ->withNotification(Notification::create(DeliveryCompanyNameConstant::$Delivery_Company_Name, MessageConstant::$MESSAGE_NEW_CHAT));

            $this->messaging->sendMulticast($message, $devicesToken);   
        }    
    }

    public function updateNewMessageStatusInReport($request)
    {  
        $response=[];

        //NewMessageStatus = true
        $item = $this->supportService->update($request,true);
        if($item) {
            $response[] =  $this->autoMapping->map('array', NotificationTokenResponse::class, $item);
        }
        return $response;
    }

    public function updateNewMessageStatusInCaptain($request)
    {
        $response=[];

        //NewMessageStatus = true
        $item = $this->captainProfileService->updateCaptainNewMessageStatus($request,true);
        if($item) {
            $response[] =  $this->autoMapping->map('array', NotificationTokenResponse::class, $item);
        }

        return $response;
    }

    public function notificationToCaptainFromAdmin($request)
    {
        $response=[];

        $item = $this->getCaptainRoomID($request->getRoomID());
       
        if($item) {
            $devicesToken = [];
            $userTokenOne = $this->getNotificationTokenByUserID($item[0]['captainID']);
            $devicesToken[] = $userTokenOne;
            $message = CloudMessage::new()
                ->withNotification(Notification::create(DeliveryCompanyNameConstant::$Delivery_Company_Name, MessageConstant::$MESSAGE_NEW_CHAT_FROM_ADMIN));
                
            $this->messaging->sendMulticast($message, $devicesToken); 
            $this->messaging->sendMulticast($message, $devicesToken);  
            $response[]= $this->autoMapping->map('array',NotificationTokenResponse::class, $devicesToken);
        }
        return $response;       
    }

    public function notificationToReportFromAdmin($request)
    {
        $response=[];

        $item = $this->getByReprotRoomID($request->getRoomID());
       
        if($item) {
            $devicesToken = [];
            $userTokenOne = $this->getNotificationTokenByUserID($item[0]['userId']);
            $devicesToken[] = $userTokenOne;
            $message = CloudMessage::new()
                ->withNotification(Notification::create(DeliveryCompanyNameConstant::$Delivery_Company_Name, MessageConstant::$MESSAGE_NEW_CHAT_FROM_ADMIN));

            $this->messaging->sendMulticast($message, $devicesToken);  
            $response[]= $this->autoMapping->map('array',NotificationTokenResponse::class, $devicesToken);
        } 

        return $response;
    }

    public function notificationTokenCreate(NotificationTokenRequest $request)
    {
        $userRegister = $this->notificationManager->notificationTokenCreate($request);

        return $this->autoMapping->map(NotificationTokenEntity::class,NotificationTokenResponse::class, $userRegister);
    }

    public function getNotificationTokenByUserID($userID)
    {
        return $this->notificationManager->getNotificationTokenByUserID($userID);
    }

    public function getByReprotRoomID($roomID)
    {
        return $this->notificationManager->getByReprotRoomID($roomID);
    }

    public function getCaptainRoomID($roomID)
    {
        return $this->notificationManager->getCaptainRoomID($roomID);
    }
}
