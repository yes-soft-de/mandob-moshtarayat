<?php


namespace App\Service;

use App\AutoMapping;
use App\Constant\NotificationStoreConstant;
use App\Entity\NotificationTokenEntity;
use App\Manager\NotificationManager;
use App\Service\RoomIdHelperService;
use App\Service\SupportService;
use App\Service\CaptainProfileService;
use App\Request\NotificationTokenRequest;
use App\Response\NotificationTokenResponse;
use Kreait\Firebase\Exception\FirebaseException;
use Kreait\Firebase\Exception\MessagingException;
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
    private $userService;

//    const CAPTAIN_TOPIC = 'captains';
    const URL = '/order_details';
    const URLCHAT = '/chat';

    public function __construct(AutoMapping $autoMapping, Messaging $messaging, NotificationManager $notificationManager, RoomIdHelperService $roomIdHelperService, supportService $supportService, CaptainProfileService $captainProfileService, UserService $userService)
    {
        $this->messaging = $messaging;
        $this->notificationManager = $notificationManager;
        $this->autoMapping = $autoMapping;
        $this->roomIdHelperService = $roomIdHelperService;
        $this->supportService = $supportService;
        $this->captainProfileService = $captainProfileService;
        $this->userService = $userService;
    }

    public function getTokens()
    {
        return $this->notificationManager->getTokens();
    }

    public function getAdminsTokens()
    {
        return $this->notificationManager->getAdminsTokens();
    }

    public function notificationToCaptains($orderNumber)
    {
        $getTokens = $this->getTokens();

        $tokens = [];

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
            ->withHighestPossiblePriority()->withData($payload);
//        $message = $message->withData($payload);

        $this->messaging->sendMulticast($message, $tokens);
    }

    /**
     * @throws MessagingException
     * @throws FirebaseException
     */
    public function notificationOrderUpdateForUser($userID, $orderNumber, $msg)
    {
        $token = $this->getNotificationTokenByUserID($userID);

        $devicesToken[] = $token;

        $payload = [
            'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
            'navigate_route' => self::URL,
            'argument' => $orderNumber,
        ];

        $msg = $msg." ".$orderNumber;

        $message = CloudMessage::new()
            ->withNotification(
                Notification::create(DeliveryCompanyNameConstant::$Delivery_Company_Name, $msg))
            ->withDefaultSounds()
            ->withHighestPossiblePriority()->withData($payload);

//        $message = $message->withData($payload);

        $this->messaging->sendMulticast($message, $devicesToken);
    }

    public function getStoreTokens($storeIDs)
    {
        return $this->notificationManager->getStoreTokens($storeIDs);
    }

    /**
     * @throws MessagingException
     * @throws FirebaseException
     */
    public function notificationOrderUpdateForStores($storeIds, $orderNumber, $msg)
    {
        $storeIDs = array_unique($storeIds);

        $tokens = [];

        $getTokens = $this->getStoreTokens($storeIDs);
        foreach ($getTokens as $token) {
            $tokens[] = $token['token'];
        }

        $payload = [
            'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
            'navigate_route' => self::URL,
            'argument' => $orderNumber,
        ];

        $msg = $msg." ".$orderNumber;

        $message = CloudMessage::new()
            ->withNotification(
                Notification::create(DeliveryCompanyNameConstant::$Delivery_Company_Name, $msg))
            ->withDefaultSounds()
            ->withHighestPossiblePriority()->withData($payload);

//        $message = $message->withData($payload);

        $this->messaging->sendMulticast($message, $tokens);
    }

    public function notificationNewChat(NotificationTokenRequest $request)
    {
        if($request->getUserType() == "captain"){
            $item = $this->notificationManager->getCaptainRoomID($request->getRoomID());
            $item = $item["captainID"];
        }

        elseif($request->getUserType() == "store"){
            $item = $this->notificationManager->getStoreRoomID($request->getRoomID());

            $item = $item["storeOwnerID"];
        }

        elseif($request->getUserType() == "client"){
            $item = $this->notificationManager->getClientRoomID($request->getRoomID());
            $item = $item["clientID"];
        }

        elseif($request->getUserType() == "admin"){
           return $this->notificationNewChatToAdmins();
        }

        $payload = [
            'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
            'navigate_route' => self::URLCHAT,
            'argument' => $request->getRoomID(),
        ];

        if($item) {

            $devicesToken = [];

            $userToken = $this->notificationManager->getNotificationTokenByUserID($item);

            $devicesToken[] = $userToken;

            $message = CloudMessage::new()
                ->withNotification(Notification::create(DeliveryCompanyNameConstant::$Delivery_Company_Name, MessageConstant::$MESSAGE_NEW_CHAT))->withDefaultSounds()
                ->withHighestPossiblePriority();

            $message = $message->withData($payload);
            $this->messaging->sendMulticast($message, $devicesToken);
        }

        return $devicesToken;
    }

    public function notificationNewChatToAdmins(){

        $getTokens = $this->getAdminsTokens();

        $devicesToken = [];

        foreach ($getTokens as $token) {
            $devicesToken[] = $token['token'];
        }
        $payload = [
            'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
            'navigate_route' => self::URLCHAT,
            'argument' => "",
        ];


        $message = CloudMessage::new()
                ->withNotification(Notification::create(DeliveryCompanyNameConstant::$Delivery_Company_Name, MessageConstant::$MESSAGE_NEW_CHAT))->withDefaultSounds()
                ->withHighestPossiblePriority();

        $message = $message->withData($payload);

        $this->messaging->sendMulticast($message, $devicesToken);

        return $devicesToken;
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
