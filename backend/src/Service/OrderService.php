<?php

namespace App\Service;

use App\AutoMapping;
use App\Constant\LocalNotificationList;
use App\Constant\LocalStoreNotificationList;
use App\Constant\MessageConstant;
use App\Constant\NotificationStoreConstant;
use App\Constant\OrderStateConstant;
use App\Constant\StoreStatusConstant;
use App\Entity\ElectronicPaymentInfoEntity;
use App\Entity\OrderEntity;
use App\Manager\OrderManager;
use App\Request\ElectronicPaymentInfoCreateRequest;
use App\Request\OrderClientCreateRequest;
use App\Request\OrderClientSendCreateRequest;
use App\Request\OrderClientSpecialCreateRequest;
use App\Request\OrderStateRequest;
use App\Request\OrderUpdateBillCalculatedByCaptainRequest;
use App\Request\OrderUpdateProductCountByClientRequest;
use App\Request\OrderUpdateStateByCaptainRequest;
use App\Request\OrderUpdateInvoiceByCaptainRequest;
use App\Request\OrderUpdateByClientRequest;
use App\Request\OrderUpdateSpecialByClientRequest;
use App\Request\OrderUpdateSendByClientRequest;
use App\Request\OrderUpdateStateForEachStoreByCaptainRequest;
use App\Request\SendNotificationRequest;
use App\Response\AddInfoPayByClientResponse;
use App\Response\CountReportForStoreOwnerResponse;
use App\Response\OrderCancelResponse;
use App\Response\OrderDetailsByOrderNumberForStoreResponse;
use App\Response\OrderInfoForCaptainResponse;
use App\Response\OrderInfoResponse;
use App\Response\OrderResponse;
use App\Response\OrderClosestResponse;
use App\Response\OrderPendingResponse;
use App\Response\OrdersAndCountByStoreProfileIdResponse;
use App\Response\OrdersPendingForStoreResponse;
use App\Response\orderUpdateBillCalculatedByCaptainResponse;
use App\Response\OrderUpdateProductCountByClientResponse;
use App\Response\OrderUpdateStateForEachStoreResponse;
use App\Response\OrderUpdateStateResponse;
use App\Response\OrderUpdateInvoiceByCaptainResponse;
use App\Response\OrderClientSendCreateResponse;
use App\Response\AcceptedOrderResponse;
use App\Response\CountReportResponse;
use App\Response\OrdersByClientResponse;
use App\Response\CountOrdersInLastMonthForStoreResponse;
use App\Response\CountOrdersInLastMonthForCaptainResponse;
use App\Response\CountOrdersInLastMonthForClientResponse;
use App\Response\CountOrdersInLastMonthForProoductResponse;
use App\Response\StoreOrdersOngoingResponse;
use App\Constant\ResponseConstant;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;
use DateTime;
use App\Service\ElectronicPaymentInfoService;

class OrderService
{
    private $autoMapping;
    private $orderManager;
    private $storeOwnerProfileService;
    private $params;
    private $ratingService;
    private $notificationService;
    private $roomIdHelperService;
    private $dateFactoryService;
    private $captainProfileService;
    private $productService;
    private $orderDetailService;
    private $deliveryCompanyFinancialService;
    private $clientProfileService;
    private $notificationLocalService;
    private $orderLogService;
    private $userService;
    private $ordersInvoicesService;
    private $electronicPaymentInfoService;

    public function __construct(AutoMapping $autoMapping, OrderManager $orderManager, StoreOwnerProfileService $storeOwnerProfileService, ParameterBagInterface $params,  RatingService $ratingService
                                 , NotificationService $notificationService
                               , RoomIdHelperService $roomIdHelperService,  DateFactoryService $dateFactoryService, CaptainProfileService $captainProfileService, ProductService $productService, OrderDetailService $orderDetailService, DeliveryCompanyFinancialService $deliveryCompanyFinancialService,
                               ClientProfileService $clientProfileService, NotificationLocalService $notificationLocalService, OrderLogService $orderLogService, UserService $userService, OrdersInvoicesService $ordersInvoicesService, ElectronicPaymentInfoService $electronicPaymentInfoService
                                )
    {
        $this->autoMapping = $autoMapping;
        $this->orderManager = $orderManager;
        $this->storeOwnerProfileService = $storeOwnerProfileService;
        $this->ratingService = $ratingService;
        $this->roomIdHelperService = $roomIdHelperService;
        $this->dateFactoryService = $dateFactoryService;
        $this->params = $params->get('upload_base_url') . '/';
        $this->notificationService = $notificationService;
        $this->captainProfileService = $captainProfileService;
        $this->productService = $productService;
        $this->orderDetailService = $orderDetailService;
        $this->deliveryCompanyFinancialService = $deliveryCompanyFinancialService;
        $this->clientProfileService = $clientProfileService;
        $this->notificationLocalService = $notificationLocalService;
        $this->orderLogService = $orderLogService;
        $this->userService = $userService;
        $this->ordersInvoicesService = $ordersInvoicesService;
        $this->electronicPaymentInfoService = $electronicPaymentInfoService;
    }

    public function closestOrders($userId)
    {
       $captain = $this->captainProfileService->captainIsActive($userId);
    
       $response = ResponseConstant::$CAPTAIN_INACTIVE;

       if ($captain->getStatus() == ResponseConstant::$CAPTAIN_ACTIVE) {

           $response = [];

           $orders = $this->orderManager->closestOrders();

           foreach ($orders as $order){
                $response[] = $this->autoMapping->map('array', OrderClosestResponse::class, $order);
            }
       }

       return $response;
    }
    
    public function getPendingOrders():?array
    {
        $response = [];

        $orders = $this->orderManager->getPendingOrders();

        foreach ($orders as $order) {
            $response[] = $this->autoMapping->map('array', OrderPendingResponse::class, $order);
        }

        return $response;
    }

    public function orderUpdateStateByCaptain(OrderUpdateStateByCaptainRequest $request)
    {
        $response = ResponseConstant::$ERROR;
        $orderIds = $this->orderDetailService->getOrderId($request->getOrderNumber());
        if($orderIds){
            $request->setId($orderIds[0]['orderID']);
            $item = $this->orderManager->orderUpdateStateByCaptain($request);
            if($item){
                $orderDetailUpdate = $this->orderDetailService->orderUpdateStateByOrderState($request->getState(), $request->getOrderNumber(), $request->getCaptainID());
                if($orderDetailUpdate){
                    $storeIds = [];
                    foreach ($orderDetailUpdate['storeIds'] as $storeProfileId) {
                        $storeIds[] = $this->storeOwnerProfileService->getStoreIdByProfileId($storeProfileId);
                    }
                    //create log
                    $this->orderLogService->createOrderLogWithMultiStore($storeIds, $request->getOrderNumber(), $request->getState(), $item->getClientID(), $request->getCaptainID());

                    //create Notification Local
                    $this->notificationLocalService->createUpdateOrderStateClientNotificationLocal($request->getState(), $item->getClientID(), $request->getOrderNumber());

                    //create store notification local
                    $this->notificationLocalService->createStoreNotificationLocal($orderDetailUpdate['storeIds'], LocalStoreNotificationList::$STATE_TITLE, $request->getState(), $request->getOrderNumber(), true);

                    //create firebase notification for client
                    try {
                        $this->notificationService->notificationOrderUpdateForUser($item->getClientID(), $request->getOrderNumber(), MessageConstant::$MESSAGE_STATUS_ORDER_UPDATE);
                    }
                    catch (\Exception $e){
                        error_log($e);
                    }

                    //create firebase notification for store
                    try{

                        $this->notificationService->notificationOrderUpdateForStores($storeIds, $request->getOrderNumber(),NotificationStoreConstant::$MESSAGE_STORE_ORDER_UPDATE);
                    }
                    catch (\Exception $e){
                        error_log($e);
                    }
                }
            }

            $response = $this->autoMapping->map(OrderEntity::class, OrderUpdateStateResponse::class, $item);
       }

        return $response;
    }

    public function orderUpdateStateForEachStore(OrderUpdateStateForEachStoreByCaptainRequest $request)
    {
        $response = ResponseConstant::$ERROR;
        //update order state for each store.
        $orderDetails = $this->orderDetailService->orderUpdateStateForEachStore($request);
        if($orderDetails){
            $states = $this->orderDetailService->getOrderDetailStates($orderDetails->orderNumber);
            if($states) {
                foreach ($states as $state) {
                    $state = $this->generateOrderState($state);
                }
                if($state) {
                    $orderState = new OrderStateRequest();
                    $orderState->setId($orderDetails->orderID);
                    $orderState->setState($state['state']);
                    //update order state
                    $order = $this->orderManager->updateOrderState($orderState);
                    if($order) {
                       $storeOwnerProfile = $this->storeOwnerProfileService->getStoreOwnerProfileById($request->getStoreOwnerProfileID());

                       $storeId = $this->storeOwnerProfileService->getStoreIdByProfileId($request->getStoreOwnerProfileID());

                        //create log
                        $this->orderLogService->createOrderLog($request->getOrderNumber(), $request->getState(), $order->getClientID(), $order->getCaptainID(), $storeId);

                        //create Notification Local
                        $this->notificationLocalService->createUpdateOrderStateClientNotificationLocal($request->getState(), $order->getClientID(), $request->getOrderNumber(), $storeOwnerProfile->storeOwnerName);

                        //create store notification local
                        $this->notificationLocalService->createUpdateOrderStateStoreNotificationLocal($request->getState(),LocalNotificationList::$STATE_TITLE , $request->getStoreOwnerProfileID(), $request->getOrderNumber());

                        //create firebase notification for client
                        try{
                            $this->notificationService->notificationOrderUpdateForUser($order->getClientID(), $request->getOrderNumber(), MessageConstant::$MESSAGE_STATUS_ORDER_UPDATE);
                        }
                        catch (\Exception $e){
                            error_log($e);
                        }

                        //create firebase notification for store
                        try{
                            $this->notificationService->notificationOrderUpdateForUser($storeId, $request->getOrderNumber(), NotificationStoreConstant::$MESSAGE_STORE_ORDER_UPDATE);
                        }
                        catch (\Exception $e){
                            error_log($e);
                        }
                    }
                    $response = $this->autoMapping->map(OrderUpdateStateForEachStoreResponse::class, OrderUpdateStateForEachStoreResponse::class, $orderDetails);
                }
            }
        }

        return $response;
    }

    public function generateOrderState($state)
    {
            if ($state == "on way to pick order") {
                return $state;
            }

            elseif ($state == "in store") {
                return $state;
            }

            return $state;
    }

    public function getOrdersWithOutPending():?array
    {
        $response = [];

        $orders = $this->orderManager->getOrdersWithOutPending();

        foreach ($orders as $order) {
            $response[] = $this->autoMapping->map('array', OrderPendingResponse::class, $order);
        }

        return $response;
    }
    
    public function getOrdersWithStore($orders):?array
    {
        $response=[];

        foreach ($orders as $order) {
            if ($order['storeOwnerProfileID'] == true) {  
                $order['storeOwner'] = $this->storeOwnerProfileService->getStoreOwnerProfileById($order['storeOwnerProfileID']);
                if( $order['storeOwner'] != null ){
                    $order['storeOwnerName']=$order['storeOwner']->storeOwnerName;
                    $order['image']=$order['storeOwner']->image;
                    $order['branches']=$order['storeOwner']->branches;
                }
            }

            $response[] = $this->autoMapping->map('array', OrderClosestResponse::class, $order);
        }

        return $response;
    }

    public function getOrdersOngoing():?array
    {
        $response = [];
        $orders = $this->orderManager->getOrdersOngoing();

        foreach ($orders as $order) {
            $response[] = $this->autoMapping->map('array', OrderPendingResponse::class, $order);
        }

        return $response;
    }

     public function getOrdersInSpecificDate($fromDate, $toDate):?array
     {
        $response = [];

        $date = $this->dateFactoryService->returnSpecificDate($fromDate, $toDate);

        $orders = $this->orderManager->getOrdersInSpecificDate($date[0], $date[1]);

         foreach ($orders as $order) {
             $response[] = $this->autoMapping->map('array', OrderPendingResponse::class, $order);
         }

         return $response;
    }

    public function getCountOrdersEveryStoreInLastMonth():?array
    {
       $response = [];
       $items = [];
       $storeIds = [];

       $date = $this->dateFactoryService->returnLastMonthDate();

       $storeOwnerProfileIDs = $this->orderDetailService->getStoreOrderInSpecificDate($date[0],$date[1]);

       foreach ($storeOwnerProfileIDs as $storeOwnerProfileID){
           $storeIds[] = $storeOwnerProfileID['storeOwnerProfileID'];
       }
       // replace the empty value with a string
        $storeIdsWithoutNull = array_replace($storeIds,array_fill_keys(array_keys($storeIds, null),''));
        //The number of duplicate values
        $val = array_count_values($storeIdsWithoutNull);

        foreach($val as $key => $value) {
            $store = $this->storeOwnerProfileService->getStoreInfoById($key);
            if($store) {
                $items[] = [
                    'storeOwnerProfileID' => $key,
                    'storeOwnerName' => $store['storeOwnerName'],
                    'countOrdersInMonth' => $value,
                    'image' => $store['image'],
                ];
            }
        }

        foreach ($items as $item){
            $item['image'] = $this->getImageParams($item['image'], $this->params . $item['image'], $this->params);

            $response[] = $this->autoMapping->map('array', CountOrdersInLastMonthForStoreResponse::class, $item);
        }

        return $response;
   }

    public function getCountOrdersEveryCaptainInLastMonth():?array
    {
       $response=[];

       $date = $this->dateFactoryService->returnLastMonthDate();
 
       $items = $this->orderManager->getCountOrdersEveryCaptainInLastMonth($date[0],$date[1]);

        foreach ($items as $item) {
            $item['image'] = $this->getImageParams($item['image'], $this->params . $item['image'], $this->params);

            $response[] = $this->autoMapping->map('array', CountOrdersInLastMonthForCaptainResponse::class, $item);
        }

        return $response;
   }
   
    public function getCountOrdersEveryClientInLastMonth():?array
    {
       $response=[];

       $date = $this->dateFactoryService->returnLastMonthDate();

       $items = $this->orderManager->getCountOrdersEveryClientInLastMonth($date[0],$date[1]);

       foreach ($items as $item) {
           $item['image'] = $this->getImageParams($item['image'], $this->params . $item['image'], $this->params);

           $response[] = $this->autoMapping->map('array', CountOrdersInLastMonthForClientResponse::class, $item);
        }

       return $response;
   }

    public function getCountOrdersEveryProductInLastMonth():?array
    {
       $response=[];

       $date = $this->dateFactoryService->returnLastMonthDate();

       $items = $this->orderDetailService->getCountOrdersEveryProductInLastMonth($date[0],$date[1]);
     
        foreach ($items as $item) {
            $item['productImage'] = $this->getImageParams($item['productImage'], $this->params . $item['productImage'], $this->params);

            $response[] = $this->autoMapping->map('array', CountOrdersInLastMonthForProoductResponse::class, $item);
        }

        return $response;
   }

    public function getAcceptedOrderByCaptainId($captainID):array
    {
        $response = [];

        $orders = $this->orderManager->getAcceptedOrderByCaptainId($captainID);

        foreach ($orders as $order) {
            $response[] = $this->autoMapping->map('array', AcceptedOrderResponse::class, $order);
        }

        return $response;
    }

    public function createClientOrder(OrderClientCreateRequest $request)
    {  
        $response = ResponseConstant::$ORDER_NOT_CREATED;
        $storeIDs = [];
        $storeIds = [];
        $orderNumber = 1;

        $lastOrderNumber = $this->orderDetailService->getLastOrderNumber();
        if ($lastOrderNumber) {
            $orderNumber = $lastOrderNumber['orderNumber'] + 1;
       }

        $roomID = $this->roomIdHelperService->roomIdGenerate();

        $item = $this->orderManager->createClientOrder($request, $roomID);
        if ($item) {
            $orderDetails = $request->getOrderDetails();

            foreach ($orderDetails as $orderDetail) {
               $productID = $orderDetail['productID'];
               $countProduct = $orderDetail['countProduct'];
               $storeOwnerProfileID = $orderDetail['storeOwnerProfileID'];

               $orderDetail = $this->orderDetailService->createOrderDetail($item->getId(), $productID, $countProduct, $orderNumber, $item->getState(), $storeOwnerProfileID);
               if(!$orderDetail) {
                   return $response;
               }
            //  Calculate the remaining product quantity after the order.
               $this->productService->updateProductQuantity($productID, $countProduct);

               $storeIDs[] = $orderDetail->storeOwnerProfileID;
            }

            foreach ($storeIDs  as $storeProfileId) {
                $storeIds[] = $this->storeOwnerProfileService->getStoreIdByProfileId($storeProfileId);
            }
            //create log
            $this->orderLogService->createOrderLogWithMultiStore($storeIds, $orderNumber, $item->getState(), $request->getClientID(),0);

            if($item->getState() == "pending") {
                //create store notification local
                $this->notificationLocalService->createStoreNotificationLocal($storeIDs, LocalStoreNotificationList::$NEW_ORDER_TITLE, LocalStoreNotificationList::$CREATE_ORDER_SUCCESS, $orderNumber);

                //create client notification local
                $this->notificationLocalService->createNotificationLocal($request->getClientID(), LocalNotificationList::$NEW_ORDER_TITLE, LocalNotificationList::$CREATE_ORDER_SUCCESS, $orderNumber);

                //create firebase notification
                try{
                    $this->notificationService->notificationToCaptains($orderNumber);
                }
                catch (\Exception $e){
                    error_log($e);
                }
                //create firebase notification store
                try{
                    $this->notificationService->notificationOrderUpdateForStores($storeIds, $orderNumber, NotificationStoreConstant::$MESSAGE_STORE_NEW_ORDER);
                }
                catch (\Exception $e){
                    error_log($e);
                }
            }

            $response = $this->getOrderDetailsForClient($orderNumber);
        }

        return $response;
    }

    public function createClientSendOrder(OrderClientSendCreateRequest $request)
    {  
        $response = ResponseConstant::$ORDER_NOT_CREATED;

        $orderNumber = 1;

        $lastOrderNumber = $this->orderDetailService->getLastOrderNumber();
        if ($lastOrderNumber) {
            $orderNumber = $lastOrderNumber['orderNumber'] + 1;
       }

        $roomID = $this->roomIdHelperService->roomIdGenerate();

        $item = $this->orderManager->createClientSendOrder($request, $roomID);
        if ($item) {
            $orderDetail = $this->orderDetailService->createOrderDetail($item->getId(), null, null, $orderNumber, $item->getState());
            if(!$orderDetail){
                return $response;
            }

            //create log
            $this->orderLogService->createOrderLog($orderNumber, $item->getState(), $request->getClientID(), 0);

            //create notification local
            $this->notificationLocalService->createNotificationLocal($request->getClientID(), LocalNotificationList::$NEW_ORDER_TITLE, LocalNotificationList::$CREATE_ORDER_SUCCESS, $orderNumber);

            $response = $this->autoMapping->map(OrderEntity::class, OrderClientSendCreateResponse::class, $item);
            $response->orderDetail['orderNumber'] = $orderDetail->orderNumber;
            $response->orderDetail['orderDetailId'] = $orderDetail->id;
          }

        return $response;
    }

    public function createClientSpecialOrder(OrderClientSpecialCreateRequest $request)
    {  
        $response = ResponseConstant::$ORDER_NOT_CREATED;

        $orderNumber = 1;

        $lastOrderNumber = $this->orderDetailService->getLastOrderNumber();
        if ($lastOrderNumber) {
            $orderNumber = $lastOrderNumber['orderNumber'] + 1;
       }

        $roomID = $this->roomIdHelperService->roomIdGenerate();

        $item = $this->orderManager->createClientSpecialOrder($request, $roomID);
        if ($item) {
            $orderDetail = $this->orderDetailService->createOrderDetail($item->getId(), null, null, $orderNumber, $item->getState(),$request->getStoreOwnerProfileID());
            if(!$orderDetail){
               return $response;
            }

            $storeId = $this->storeOwnerProfileService->getStoreIdByProfileId($request->getStoreOwnerProfileID());

            //create log
            $this->orderLogService->createOrderLog($orderNumber, $item->getState(), $request->getClientID(), 0, $storeId);
            if($item->getState() == "pending") {
                //create notification local
                $this->notificationLocalService->createNotificationLocal($request->getClientID(), LocalNotificationList::$NEW_ORDER_TITLE, LocalNotificationList::$CREATE_ORDER_SUCCESS, $orderNumber);

                //create store notification local
                $this->notificationLocalService->createNotificationLocal($request->getStoreOwnerProfileID(), LocalStoreNotificationList::$NEW_ORDER_TITLE, LocalStoreNotificationList::$CREATE_ORDER_SUCCESS, $orderNumber);

                //create firebase notification captain
                try {
                    $this->notificationService->notificationToCaptains($orderNumber);
                } catch (\Exception $e) {
                    error_log($e);
                }

                //create firebase notification store
                try {
                    $this->notificationService->notificationOrderUpdateForUser($storeId, $orderNumber, NotificationStoreConstant::$MESSAGE_STORE_NEW_ORDER);
                } catch (\Exception $e) {
                    error_log($e);
                }

                //create firebase notification client
                try {
                    $this->notificationService->notificationOrderUpdateForUser($request->getClientID(), $orderNumber, LocalNotificationList::$CREATE_ORDER_SUCCESS);
                } catch (\Exception $e) {
                    error_log($e);
                }
            }

            $response = $this->getOrderDetailsForClient($orderNumber);
        }
          
        return $response;
    }

    public function getOrderStatusByOrderNumber($orderNumber) 
    {
        $response = [];

        $orderDetails = $this->orderDetailService->getOrderIdByOrderNumber($orderNumber);
        if($orderDetails) {
            $order = $this->orderManager->orderStatusByOrderId($orderDetails[0]->orderID);
            if ($order[0]['storeOwnerProfileID']) {
                if($orderDetails[0]->storeOwnerProfileID){
                    $storeOwner = $this->storeOwnerProfileService->getStoreOwnerProfileById($orderDetails[0]->storeOwnerProfileID);

                    $response['orderDetails'] = $orderDetails;
                    $response['storeOwner'] = $storeOwner;
                }
            }
            $response['order'] = $order[0];
    }
        return $response;
    }

    public function getOrderDetailsByOrderNumberForAdmin($orderNumber)
    {
        $response = [];

        $item['orderDetails'] = $this->orderDetailService->getOrderDetailsByOrderNumberForAdmin($orderNumber);
        $deliveryCost = $this->deliveryCompanyFinancialService->deliveryCost();
        if(!$deliveryCost){
            $item['deliveryCost'] = (string) 0;
        }
        else{
            $item['deliveryCost'] = (string) $deliveryCost['deliveryCost'];
        }

        $item['invoices'] = $this->ordersInvoicesService->getInvoicesByOrderNumber($orderNumber);
        $item['rate'] = $this->ratingService->getAvgOrder($orderNumber);

        if($item['orderDetails']) {

            $item['order'] = $this->orderManager->orderStatusByOrderId($item['orderDetails'][0]->orderID);
            $item['order']['orderCost'] = round($item['order']['orderCost'], 1);
            $item['vatTax'] = $this->getVatTax($item['order']['orderCost']);

            if($item['order']['payment'] == "card"){
                $item['payInfo'] = $this->electronicPaymentInfoService->getPayInfoByOrderNumber($orderNumber);
            }

            $response = $this->autoMapping->map('array', OrderInfoResponse::class, $item);
        }

        return $response;
    }

    public function getOrderDetailsByOrderNumberForCaptain($orderNumber)
    {
        $response = [];

        $item['orderDetails'] = $this->orderDetailService->getOrderDetailsByOrderNumberForCaptain($orderNumber);

        $deliveryCost = $this->deliveryCompanyFinancialService->deliveryCost();
        if(!$deliveryCost){
            $item['deliveryCost'] = (string) 0;
        }
        else{
            $item['deliveryCost'] = (string) $deliveryCost['deliveryCost'];
        }
        $item['invoices'] = $this->ordersInvoicesService->getInvoicesByOrderNumber($orderNumber);

        $item['rate'] = $this->ratingService->getAvgOrder($orderNumber);
        if($item['orderDetails']) {
            $item['order'] = $this->orderManager->orderStatusByOrderId($item['orderDetails'][0]->orderID);
            $item['order']['orderCost'] = round($item['order']['orderCost'], 1);
            $item['vatTax'] = $this->getVatTax($item['order']['orderCost']);

            $response = $this->autoMapping->map('array', OrderInfoForCaptainResponse::class, $item);
        }
        return $response;
    }

    public function getOrderDetailsForClient($orderNumber)
    {
        $response = [];

        $item['orderDetails'] = $this->orderDetailService->orderDetailsForClient($orderNumber);

        $deliveryCost = $this->deliveryCompanyFinancialService->deliveryCost();
        if(!$deliveryCost){
            $item['deliveryCost'] = (string) 0;
        }
        else{
            $item['deliveryCost'] = (string) $deliveryCost['deliveryCost'];
        }
        $item['invoices'] = $this->ordersInvoicesService->getInvoicesByOrderNumber($orderNumber);

        $item['rate'] = $this->ratingService->getAvgOrder($orderNumber);
        if($item['orderDetails']) {
            $item['order'] = $this->orderManager->orderStatusByOrderId($item['orderDetails'][0]->orderID);
            $item['order']['orderCost'] = round($item['order']['orderCost'], 1);
            $item['vatTax'] = $this->getVatTax($item['order']['orderCost']);

            if($item['order']['payment'] == "card"){
                $item['payInfo'] = $this->electronicPaymentInfoService->getPayInfoByOrderNumber($orderNumber);
            }

            $response = $this->autoMapping->map('array', OrderInfoResponse::class, $item);
        }
        return $response;
    }

    public function getVatTax($orderCost) {
        $item = [];
        $item['itemsTotal'] = $orderCost;
        $item['vatTax'] = ($orderCost * 15) / 100;
        $item['total'] = round($item['vatTax'] + $orderCost, 1);

        return $item;
    }
    public function orderUpdateByClient(OrderUpdateByClientRequest $request)
    {
        $response = ResponseConstant::$ERROR;

        $orderId = $this->orderDetailService->getOrderId($request->getOrderNumber());

        if($orderId) {
            $order = $this->orderManager->orderStatusByOrderId($orderId[0]['orderID']);
            if($order['state'] != OrderStateConstant::$ORDER_STATE_PENDING and $order['state'] != OrderStateConstant::$ORDER_STATE_NOT_PAID ) {
                //notification local
                $this->notificationLocalService->createNotificationLocal($request->getClientID(), LocalNotificationList::$UPDATE_ORDER_TITLE, LocalNotificationList::$UPDATE_ORDER_ERROR_CAPTAIN_IN_STORE, $request->getOrderNumber());
                //create firebase notification for client
                try {
                    $this->notificationService->notificationOrderUpdateForUser($request->getClientID(), $request->getOrderNumber(), MessageConstant::$UPDATE_ORDER_ERROR_CAPTAIN_IN_STORE);
                }
                catch (\Exception $e){
                    error_log($e);
                }
                return ResponseConstant::$ORDER_NOT_UPDATE_STATE;
            }

            $orderUpdate = $this->orderManager->updateOrderByClient($request, $orderId[0]['orderID']);
            if($orderUpdate) {
                $products = $request->getProducts();

                foreach ($products as $product) {

                    $productID = $product['productID'];
                    $countProduct = $product['countProduct'];

                    $orderDetail = new OrderUpdateProductCountByClientRequest();
                    $orderDetail->setCountProduct($countProduct);
                    $orderDetail->setOrderNumber($request->getOrderNumber());
                    $orderDetail->setProductId($productID);

                    $updateProductCount = $this->orderDetailService->UpdateProductCount($orderDetail);
                }
                //notification local
                $this->notificationLocalService->createNotificationLocal($request->GetClientID(), LocalNotificationList::$UPDATE_ORDER_TITLE, LocalNotificationList::$UPDATE_ORDER_SUCCESS, $request->getOrderNumber());

                //create firebase notification for client
                try {
                    $this->notificationService->notificationOrderUpdateForUser($request->getClientID(), $request->getOrderNumber(), LocalNotificationList::$UPDATE_ORDER_SUCCESS);
                }
                catch (\Exception $e){
                    error_log($e);
                }

                $response = $this->autoMapping->map(OrderUpdateProductCountByClientResponse::class, OrderUpdateProductCountByClientResponse::class, $updateProductCount);
            }
        }

        return $response;
    }
//The feature has been discontinued within this project
    public function orderSpecialUpdateByClient(OrderUpdateSpecialByClientRequest $request, $userID)
    {
        $response = "Not updated!!";

        $orderDetails = $this->orderDetailService->getOrderIdWithOutStoreProductByOrderNumber($request->getOrderNumber());
        if($orderDetails) {
            $order = $this->orderManager->orderStatusByOrderId($orderDetails[0]->getOrderID());
            if($order[0]['state'] == 'in store') {

                //notification local
                $this->notificationLocalService->createNotificationLocal($userID, LocalNotificationList::$UPDATE_ORDER_TITLE, LocalNotificationList::$UPDATE_ORDER_ERROR_CAPTAIN_IN_STORE, $request->getOrderNumber());

                return $response = "you can't edit, captain in the store.";
            }

                $orderUpdate = $this->orderManager->orderSpecialUpdateByClient($request, $orderDetails[0]->getOrderID());
                if($orderUpdate) {

                    foreach ($orderDetails as $orderDetail) {

                        $orderDetailDelete = $this->orderDetailService->orderDetailDelete($orderDetail->getId());
                    }

                    if ($orderDetailDelete == "Deleted") {
                        $createOrderDetail = $this->orderDetailService->createOrderDetail($orderDetails[0]->getOrderID(), null, null, $request->getOrderNumber());

                        //notification local
                        $this->notificationLocalService->createNotificationLocal($userID, LocalNotificationList::$UPDATE_ORDER_TITLE, LocalNotificationList::$UPDATE_ORDER_SUCCESS, $request->getOrderNumber());

                        return $response = $this->getOrderStatusByOrderNumber($request->getOrderNumber());
                    } 
                }     
        }       

        return $response;
    }
//The feature has been discontinued within this project
    public function orderSendUpdateByClient(OrderUpdateSendByClientRequest $request, $userID)
    {
        $response = "Not updated!!";

        $orderDetails = $this->orderDetailService->getOrderIdWithOutStoreProductByOrderNumber($request->getOrderNumber());
        if($orderDetails) {
            $order = $this->orderManager->orderStatusByOrderId($orderDetails[0]->getOrderID());
            if($order[0]['state'] == 'in store') {
                //notification local
                $this->notificationLocalService->createNotificationLocal($userID, LocalNotificationList::$UPDATE_ORDER_TITLE, LocalNotificationList::$UPDATE_ORDER_ERROR_CAPTAIN_IN_STORE, $request->getOrderNumber());

                return $response = "you can't edit, captain in the store.";
            }

                $orderUpdate = $this->orderManager->orderSendUpdateByClient($request, $orderDetails[0]->getOrderID());
                if($orderUpdate) {

                    foreach ($orderDetails as $orderDetail) {
                         $orderDetailDelete = $this->orderDetailService->orderDetailDelete($orderDetail->getId());
                    }

                    if ($orderDetailDelete == "Deleted") {
                        $createOrderDetail = $this->orderDetailService->createOrderDetail($orderDetails[0]->getOrderID(), null, null, $request->getOrderNumber());

                        //notification local
                        $this->notificationLocalService->createNotificationLocal($userID, LocalNotificationList::$UPDATE_ORDER_TITLE, LocalNotificationList::$UPDATE_ORDER_SUCCESS, $request->getOrderNumber());

                        return $response = $this->getOrderStatusByOrderNumber($request->getOrderNumber());
                    }
                }     
        }       

        return $response;
    }

    public function orderCancel($orderNumber, $userID)
    {
        $response= [];

        $orderDetails = $this->orderDetailService->getStoreOwnerProfileIdAndOrderIDByOrderNumber($orderNumber);

        if($orderDetails) {
            $order = $this->orderManager->orderStatusByOrderId($orderDetails[0]['orderID']);

            $halfHourLaterTime = date_modify($order['createdAt'],'+30 minutes');

            $nowDate = new DateTime('now');
            
            if ( $halfHourLaterTime < $nowDate) {
                //notification local
                $this->notificationLocalService->createNotificationLocal($userID, LocalNotificationList::$CANCEL_ORDER_TITLE, LocalNotificationList::$CANCEL_ORDER_ERROR_TIME, $orderNumber);

                //create firebase notification for client
                try {
                    $this->notificationService->notificationOrderUpdateForUser($userID, $orderNumber, LocalNotificationList::$CANCEL_ORDER_ERROR_TIME);
                }
                catch (\Exception $e){
                    error_log($e);
                }

                $response=ResponseConstant::$ORDER_NOT_REMOVE_TIME;
            }

            elseif ($order['state'] != OrderStateConstant::$ORDER_STATE_PENDING and $order['state'] != OrderStateConstant::$ORDER_STATE_NOT_PAID ) {
                //notification local
                $this->notificationLocalService->createNotificationLocal($userID, LocalNotificationList::$CANCEL_ORDER_TITLE, LocalNotificationList::$CANCEL_ORDER_ERROR_ACCEPTED, $orderNumber);

                //create firebase notification for client
                try {
                    $this->notificationService->notificationOrderUpdateForUser($userID, $orderNumber, LocalNotificationList::$CANCEL_ORDER_ERROR_ACCEPTED);
                }
                catch (\Exception $e){
                    error_log($e);
                }

                $response = ResponseConstant::$ORDER_NOT_REMOVE_CAPTAIN_RECEIVED;
            }

            else {
                $item = $this->orderManager->orderCancel($orderDetails[0]['orderID']);

                if($item) {

                    $orderDetailUpdate = $this->orderDetailService->orderUpdateStateByOrderState(OrderStateConstant::$ORDER_STATE_CANCEL , $orderNumber, null);

                    foreach ($orderDetailUpdate['storeIds'] as $storeProfileId) {
                        $storeIds[] = $this->storeOwnerProfileService->getStoreIdByProfileId($storeProfileId);
                    }
                    //----> start create log
                    // if order type is product order or special order
                    if ($item->getOrderType() == 1 ||  $item->getOrderType() == 2) {
                        $this->orderLogService->createOrderLogWithMultiStore($storeIds, $orderNumber, OrderStateConstant::$ORDER_STATE_CANCEL, $userID, 0);
                    }

                    //notification local for client
                    $this->notificationLocalService->createNotificationLocal($userID, LocalNotificationList::$CANCEL_ORDER_TITLE, LocalNotificationList::$CANCEL_ORDER_SUCCESS, $orderNumber);

                    //notification local for store
                    $this->notificationLocalService->createStoreNotificationLocal($orderDetailUpdate['storeIds'], LocalNotificationList::$CANCEL_ORDER_TITLE,  NotificationStoreConstant::$MESSAGE_STORE_ORDER_CANCEL, $orderNumber);

                    //create firebase notification for client
                    try {
                        $this->notificationService->notificationOrderUpdateForUser($userID, $orderNumber, LocalNotificationList::$CANCEL_ORDER_SUCCESS);
                    }
                    catch (\Exception $e){
                        error_log($e);
                    }

                    //create firebase notification for store
                    try {
                        $this->notificationService->notificationOrderUpdateForStores($storeIds, $orderNumber, NotificationStoreConstant::$MESSAGE_STORE_ORDER_CANCEL);
                    }
                    catch (\Exception $e){
                        error_log($e);
                    }
                }

                $response = $this->autoMapping->map(OrderEntity::class, OrderCancelResponse::class, $item);
            }
        }

        return $response;
    }

    public function getOrdersByClientID($clientID): array
    {
        $response = [];

        $orders = $this->orderManager->getOrdersByClientID($clientID);

        foreach ($orders as $order) {
           $order['amount'] = $order['deliveryCost'] + $order['orderCost'];

           $response[] = $this->autoMapping->map('array', OrdersByClientResponse::class, $order);
       }

        return $response;
    }

    public function getOrdersDeliveredAndCancelledByClientId($clientID)
    {
        $response = [];

        $orders = $this->orderManager->getOrdersDeliveredAndCancelledByClientId($clientID);
        foreach ($orders as $order) {
           $order['amount'] = $order['deliveryCost'] + $order['orderCost'];

           $response[] = $this->autoMapping->map('array', OrdersByClientResponse::class, $order);
       }

        return $response;
    }

    public function orderUpdateInvoiceByCaptain(OrderUpdateInvoiceByCaptainRequest $request)
    {
        $response = ResponseConstant::$ERROR;

        $orderInvoice = $this->ordersInvoicesService->orderUpdateInvoiceByCaptain($request);

        if(!$orderInvoice) {
            return $response;
        }
        $request->setOrderInvoiceId($orderInvoice->id);

        $item = $this->orderDetailService->orderUpdateInvoiceByCaptain($request);

        if(!$item) {
            return $response;
        }

        return $this->autoMapping->map(OrderUpdateInvoiceByCaptainResponse::class, OrderUpdateInvoiceByCaptainResponse::class, $orderInvoice);
    }

    public function orderUpdateBillCalculatedByCaptain(OrderUpdateBillCalculatedByCaptainRequest $request)
    {
        $response = "Not updated!!";

        $orderDetails = $this->orderDetailService->getOrderIdByOrderNumber($request->getOrderNumber());
        if($orderDetails){
            $request->setId($orderDetails[0]->orderID);

            $item = $this->orderManager->orderUpdateBillCalculatedByCaptain($request);

            $response = $this->autoMapping->map(OrderEntity::class, orderUpdateBillCalculatedByCaptainResponse::class, $item);
       }
        return $response;
    }

    public function countReport()
    {
        $item['countCompletedOrders'] = $this->orderManager->countCompletedOrders();
        $item['countOngoingOrders'] = $this->orderManager->countOngoingOrders();
        $item['countCaptains'] = $this->captainProfileService->countCaptains();
        $item['countClients'] = $this->clientProfileService->countClients();
        $item['countStores'] = $this->storeOwnerProfileService->countStores();
        $item['countProducts'] = $this->productService->countProducts();
        $item['countOrdersInToday'] = $this->countOrdersInToday();
        
        $response = $this->autoMapping->map("array", CountReportResponse::class, $item);
        
        return $response;
    }

    public function countOrdersInToday() { 
       $date = $this->dateFactoryService->returnTodayDate();

       return $this->orderManager->countOrdersInToday($date[0], $date[1]);
    }

    public function countOrdersInTodayForStoreOwner($orderIds)
    {
       $date = $this->dateFactoryService->returnTodayDate();

       return $this->orderManager->countOrdersInTodayForStoreOwner($date[0], $date[1], $orderIds);
    }

    public function getOrdersAndCountByStoreProfileId($storeOwnerProfileId)
    {
        $orderIds = $this->orderDetailService->getOrderIds($storeOwnerProfileId);

        $item['countOrders'] = $this->orderManager->countStoreOrders($orderIds);
        $item['orders'] = $this->orderDetailService->getStoreOrders($storeOwnerProfileId);

        return $this->autoMapping->map('array', OrdersAndCountByStoreProfileIdResponse::class, $item);

    }

    public function getOrdersAndCountByCaptainId($captainId): array
    {
        $response = [];

        $item = [];

        $countOrders = $this->orderManager->countCaptainOrders($captainId);

        $orders = $this->orderManager->getOrdersByCaptainId($captainId);
        
        $response['ordersCount'] = $countOrders;

        foreach ($orders as $order) {
            $order['amount'] = $order['deliveryCost'] + $order['orderCost'];
            
            $item[] = $this->autoMapping->map('array', OrdersByClientResponse::class, $order);
        }

        $response['orders'] = $item;

        return $response;
    }

    public function getStoreOrdersOngoingForStoreOwner($userID)
    {
        $response = [];

        $item = $this->userService->getStoreProfileId($userID);

        $store = $this->storeOwnerProfileService->storeIsActive($userID);
        if ($store->getStatus() === StoreStatusConstant::$INACTIVE_STORE_STATUS) {
            $response = ResponseConstant::$STORE_INACTIVE;
        }

        elseif ($store->getStatus() === StoreStatusConstant::$ACTIVE_STORE_STATUS) {
            $orders = $this->orderDetailService->getStoreOrdersOngoingForStoreOwner($item['id']);

            foreach ($orders as $order) {
                $order['orderCost'] = (float)$this->orderDetailService->getTotalProductsPriceByOrderNumberAndStoreIDForStore($order['orderNumber'], $item['id']);

                $response[] = $this->autoMapping->map('array', StoreOrdersOngoingResponse::class, $order);
            }
        }

        return $response;
    }

    public function getStoreOrdersInSpecificDate($fromDate, $toDate, $userID):?array
    {
        $response = [];

        $date = $this->dateFactoryService->returnSpecificDate($fromDate, $toDate);

        $storeOwnerProfileID = $this->userService->getStoreProfileId($userID);

        $orders = $this->orderDetailService->getStoreOrdersInSpecificDate($date[0], $date[1], $storeOwnerProfileID['id']);


        foreach ($orders as $order) {
            $order['invoiceAmount'] = $this->orderDetailService->getTotalProductsPriceByOrderNumberAndStoreIDForStoreOrders($order['orderNumber'], $storeOwnerProfileID['id']);

            $response[] = $this->autoMapping->map('array', OrdersPendingForStoreResponse::class, $order);
        }
        return $response;
    }

    public function getStoreOrders($userID):?array
    {
        $response = [];

        $storeOwnerProfileID = $this->userService->getStoreProfileId($userID);

        $orders = $this->orderDetailService->getStoreOrders($storeOwnerProfileID);

        foreach ($orders as $order) {
            $order['invoiceAmount'] = (float)$this->orderDetailService->getTotalProductsPriceByOrderNumberAndStoreIDForStore($order['orderNumber'], $storeOwnerProfileID);

            $response[] = $this->autoMapping->map('array', OrdersPendingForStoreResponse::class, $order);
        }

        return $response;
    }

        public function countReportForStoreOwner($userID)
    {
        $storeOwnerProfileId = $this->userService->getStoreProfileId($userID);

        $orderIds = $this->orderDetailService->getOrderIds($storeOwnerProfileId);

        $item['countCompletedOrders'] =  $this->orderManager->countCompletedOrdersForStoreOwner($orderIds);
        $item['countOngoingOrders'] =  $this->orderManager->countOngoingOrdersForStoreOwner($orderIds);
        $item['countOrdersInToday'] = $this->countOrdersInTodayForStoreOwner($orderIds);

        return $this->autoMapping->map("array", CountReportForStoreOwnerResponse::class, $item);
    }

    public function getOrderDetailsByOrderNumberForStore($orderNumber, $userId)
    {
        $response = [];

        $storeOwnerProfileID = $this->userService->getStoreProfileId($userId);

        $item['orderDetails'] = $this->orderDetailService->getOrderDetailsByOrderNumberForStore($orderNumber, $storeOwnerProfileID);

        $item['rate'] = $this->ratingService->getAvgOrder($orderNumber);
        if($item['orderDetails']) {
            $response = $this->autoMapping->map('array', OrderDetailsByOrderNumberForStoreResponse::class, $item);
        }

        return $response;
    }

    public function getImageParams($imageURL, $image, $baseURL): array
    {
        $item['imageURL'] = $imageURL;
        $item['image'] = $image;
        $item['baseURL'] = $baseURL;

        return $item;
    }

    public function getStorePendingOrders($userId): array
    {
        $response = [];

        $storeOwnerProfileID = $this->userService->getStoreProfileId($userId);

        $orders = $this->orderDetailService->getStorePendingOrders($storeOwnerProfileID);
        foreach ($orders as $order) {
            $order['invoiceAmount'] = (float)$this->orderDetailService->getTotalProductsPriceByOrderNumberAndStoreIDForStore($order['orderNumber'], $storeOwnerProfileID);

            $response[] = $this->autoMapping->map('array', OrdersPendingForStoreResponse::class, $order);
        }

        return $response;
    }

    public function addInfoPay(ElectronicPaymentInfoCreateRequest $request)
    {
        $storeIds = [];

        $orderId = $this->orderDetailService->getOrderId($request->getOrderNumber());

        $item = $this->electronicPaymentInfoService->addInfoPay($request);
        if(!$item){
            return ResponseConstant::$ERROR;
        }

        if($orderId) {
            $orderUpdate = $this->orderManager->orderStateUpdateByPayInfo($request->getOrderNumber(), $request->getPayStatus(), $orderId[0]['orderID']);
            if (!$orderUpdate) {
                return ResponseConstant::$ERROR;
            }

            $orderDetail =  $this->orderDetailService->orderUpdateStateByOrderState($orderUpdate->getState(),$request->getOrderNumber(),null);

            if(!$orderDetail){
                return ResponseConstant::$ERROR;
            }

            if($request->getPayStatus() == "paid") {
                foreach ($orderDetail['storeIds'] as $storeProfileId) {
                    $storeIds[] = $this->storeOwnerProfileService->getStoreIdByProfileId($storeProfileId);
                }
                //create log
                $this->orderLogService->createOrderLogWithMultiStore($storeIds, $request->getOrderNumber(), OrderStateConstant::$ORDER_STATE_PENDING, $request->getClientID(),0);

                //create store notification local
                $this->notificationLocalService->createStoreNotificationLocal($storeIds, LocalStoreNotificationList::$NEW_ORDER_TITLE, LocalStoreNotificationList::$CREATE_ORDER_SUCCESS, $request->getOrderNumber());

                //create client notification local
                $this->notificationLocalService->createNotificationLocal($request->getClientID(), LocalNotificationList::$NEW_ORDER_TITLE, LocalNotificationList::$CREATE_ORDER_SUCCESS, $request->getOrderNumber());

                //create firebase notification
                try{
                    $this->notificationService->notificationToCaptains($request->getOrderNumber());
                }
                catch (\Exception $e){
                    error_log($e);
                }
                //create firebase notification store
                try{
                    $this->notificationService->notificationOrderUpdateForStores($storeIds, $request->getOrderNumber(), NotificationStoreConstant::$MESSAGE_STORE_NEW_ORDER);
                }
                catch (\Exception $e){
                    error_log($e);
                }
            }

            else {
                foreach ($orderDetail['storeIds'] as $storeProfileId) {
                    $storeIds[] = $this->storeOwnerProfileService->getStoreIdByProfileId($storeProfileId);
                }

                //create log
                $this->orderLogService->createOrderLogWithMultiStore($storeIds, $request->getOrderNumber(), OrderStateConstant::$ORDER_STATE_NOT_PAID, $request->getClientID(),0);

                //create client notification local
                $this->notificationLocalService->createNotificationLocal($request->getClientID(), LocalNotificationList::$NEW_ORDER_TITLE, LocalNotificationList::$ORDER_NOT_CREATE , $request->getOrderNumber());

            }
        }

        return $this->autoMapping->map(ElectronicPaymentInfoEntity::class, AddInfoPayByClientResponse::class, $item);
    }

    public function getCountOrdersEveryStoreInSpecificDate($fromDate, $toDate):?array
    {
        $response = [];
        $items = [];
        $storeIds = [];

        $date = $this->dateFactoryService->returnSpecificDate($fromDate, $toDate);

        $storeOwnerProfileIDs = $this->orderDetailService->getStoreOrderInSpecificDate($date[0],$date[1]);

        foreach ($storeOwnerProfileIDs as $storeOwnerProfileID){
            $storeIds[] = $storeOwnerProfileID['storeOwnerProfileID'];
        }
        // replace the empty value with a string
        $storeIdsWithoutNull = array_replace($storeIds,array_fill_keys(array_keys($storeIds, null),''));
        //The number of duplicate values
        $val = array_count_values($storeIdsWithoutNull);

        foreach($val as $key => $value) {
            $store = $this->storeOwnerProfileService->getStoreInfoById($key);
            if($store) {
                $items[] = [
                    'storeOwnerProfileID' => $key,
                    'storeOwnerName' => $store['storeOwnerName'],
                    'countOrdersInMonth' => $value,
                    'image' => $store['image'],
                ];
            }
        }

        foreach ($items as $item){
            $item['image'] = $this->getImageParams($item['image'], $this->params . $item['image'], $this->params);

            $response[] = $this->autoMapping->map('array', CountOrdersInLastMonthForStoreResponse::class, $item);
        }

        return $response;
    }

    public function getCountOrdersEveryCaptainInSpecificDate($fromDate, $toDate):?array
    {
        $response=[];

        $date = $this->dateFactoryService->returnSpecificDate($fromDate, $toDate);

        $items = $this->orderManager->getCountOrdersEveryCaptainInLastMonth($date[0],$date[1]);

        foreach ($items as $item) {
            $item['image'] = $this->getImageParams($item['image'], $this->params . $item['image'], $this->params);

            $response[] = $this->autoMapping->map('array', CountOrdersInLastMonthForCaptainResponse::class, $item);
        }

        return $response;
    }

    public function getCountOrdersEveryClientInSpecificDate($fromDate, $toDate):?array
    {
        $response=[];

        $date = $this->dateFactoryService->returnSpecificDate($fromDate, $toDate);

        $items = $this->orderManager->getCountOrdersEveryClientInLastMonth($date[0],$date[1]);

        foreach ($items as $item) {
            $item['image'] = $this->getImageParams($item['image'], $this->params . $item['image'], $this->params);

            $response[] = $this->autoMapping->map('array', CountOrdersInLastMonthForClientResponse::class, $item);
        }

        return $response;
    }

    public function getCountOrdersEveryProductInSpecificDate($fromDate, $toDate):?array
    {
        $response=[];

        $date = $this->dateFactoryService->returnSpecificDate($fromDate, $toDate);

        $items = $this->orderDetailService->getCountOrdersEveryProductInLastMonth($date[0],$date[1]);

        foreach ($items as $item) {
            $item['productImage'] = $this->getImageParams($item['productImage'], $this->params . $item['productImage'], $this->params);

            $response[] = $this->autoMapping->map('array', CountOrdersInLastMonthForProoductResponse::class, $item);
        }

        return $response;
    }

}
