<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\OrderLogEntity;
use App\Manager\OrderLogManager;
use App\Response\OrderLogOwnerResponse;
use App\Response\OrderLogResponse;
use App\Response\OrderLogCaptainResponse;
use App\Response\OrderLogTimeLineResponse;
use App\Response\OrderLogsResponse;
use App\Service\DateFactoryService;


class OrderLogService
{
    private $autoMapping;
    private $orderLogManager;
    private $dateFactoryService;

    public function __construct(AutoMapping $autoMapping, OrderLogManager $orderLogManager, DateFactoryService $dateFactoryService)
    {
        $this->autoMapping = $autoMapping;
        $this->orderLogManager = $orderLogManager;
        $this->dateFactoryService = $dateFactoryService;
    }

    public function createOrderLogWithMultiStore($storeIDs, $orderNumber, $state, $clientID, $captainID )
    {
        //remove item duplicated
        $storeIDs = array_unique($storeIDs);
        foreach ($storeIDs as $storeID){
            $this->createOrderLog($orderNumber, $state, $clientID, $captainID, $storeID );
        }
    }

    public function createOrderLog($orderNumber, $state, $clientID, $captainID, $storeOwnerProfileID = 0)
    {
        //TODO It is better to build a request file instead of using parameters
        $item['orderNumber'] = $orderNumber;
        $item['state'] = $state;
        $item['userID'] = $clientID;
        $item['storeOwnerProfileID'] = $storeOwnerProfileID;
        $item['captainID'] = $captainID;

        $result = $this->orderLogManager->createOrderLog($item);

        return $this->autoMapping->map(OrderLogEntity::class, OrderLogResponse::class, $result);
    }
    
    public function getOrderLogByOrderNumber($orderNumber)
    {
        return $this->orderLogManager->getOrderLogByOrderNumber($orderNumber);
    }

    public function getOrderLogsByOrderNumber($orderNumber)
    {
        return $this->orderLogManager->getOrderLogsByOrderNumber($orderNumber);
    }

    public function getOrderLogsTimeLineNew($orderNumber): array
    {
        $response=[];

        $items = $this->getOrderLogsByOrderNumber($orderNumber);

        foreach ($items as $item) {

            $firstDate = $this->getFirstDate($item['orderNumber']);

            $acceptOrderDate = $this->getAcceptOrderDate($item['orderNumber']);

            $lastDate = $this->getLastDate($item['orderNumber']);

            if($firstDate[0]['createdAt'] && $lastDate[0]['createdAt']) {
                $state['completionTime'] = $this->dateFactoryService->subtractTwoDates($firstDate[0]['createdAt'], $lastDate[0]['createdAt']);
            }

            if(isset($acceptOrderDate[0]['createdAt'])) {
                if ($acceptOrderDate[0]['createdAt'] && $lastDate[0]['createdAt']) {
                    $state['deliveredTime'] = $this->dateFactoryService->subtractTwoDates($acceptOrderDate[0]['createdAt'], $lastDate[0]['createdAt']);
                }
            }
        }

        if(isset($lastDate)) {
            $state['currentStage'] = $lastDate[0]['state'];

            $orderStatus = $this->autoMapping->map('array', OrderLogTimeLineResponse::class, $state);
            $logs = $this->orderLog($orderNumber);

            $response['orderStatus'] = $orderStatus ;
            $response['logs'] = $logs ;
        }

        return  $response;
    }

//this remove item duplicated
    public function orderLog($orderNumber): array
    {
        $items = $this->getOrderLogsByOrderNumber($orderNumber);

        $temp = array_unique(array_column($items, 'state'));

        $items = array_intersect_key($items, $temp);

        foreach ($items as $item){
            $logs[] = $this->autoMapping->map('array', OrderLogsResponse::class, $item);
        }

        return $logs;
    }

    public function getFirstDate($orderNumber)
    {
        return $this->orderLogManager->getFirstDate($orderNumber);
    }

    public function getAcceptOrderDate($orderNumber)
    {
        return $this->orderLogManager->getAcceptOrderDate($orderNumber);
    }

    public function getLastDate($orderNumber)
    {
        return $this->orderLogManager->getLastDate($orderNumber);
    } 

    public function getClientOrderLogs($userID):array
    {
         $response = [];
      
        $items = $this->orderLogManager->getOrderNumberUserID($userID);
 
        foreach ($items as $item) {
            $firstDate = $this->getFirstDate($item['orderNumber']); 

            $lastDate = $this->getLastDate($item['orderNumber']);
           
            $item['currentStage'] =  $lastDate[0]['state'] ;

            if($firstDate[0]['createdAt'] && $lastDate[0]['createdAt']) {
                $item['completionTime'] = $this->dateFactoryService->subtractTwoDates($firstDate[0]['createdAt'], $lastDate[0]['createdAt']);
            }

            $response[] = $this->autoMapping->map('array', OrderLogResponse::class, $item);
        }

       return $response;
    }

    public function getCaptainOrderLogs($userID)
    {
        $response = [];
      
        $items = $this->orderLogManager->getCaptainOrderLogs($userID);
 
        foreach ($items as $item) {
            $firstDate = $this->getFirstDate($item['orderNumber']); 

            $lastDate = $this->getLastDate($item['orderNumber']);
            
            $item['currentStage'] = $lastDate[0]['state'] ;
          
            if($firstDate[0]['createdAt'] && $lastDate[0]['createdAt']) {
                $item['completionTime'] = $this->dateFactoryService->subtractTwoDates($firstDate[0]['createdAt'], $lastDate[0]['createdAt']);
                }
          
            $response[] = $this->autoMapping->map("array", OrderLogCaptainResponse::class, $item);
        }

       return  $response;
    }

    public function getOwnerOrderLogs($userID): array
    {

        $response = [];
        $items = $this->orderLogManager->getOwnerOrderLogs($userID);

        foreach ($items as $item) {
            $firstDate = $this->getFirstDate($item['orderNumber']);

            $lastDate = $this->getLastDate($item['orderNumber']);

            $item['currentStage'] = $lastDate[0]['state'] ;

            if($firstDate[0]['createdAt'] && $lastDate[0]['createdAt']) {
                $item['completionTime'] = $this->dateFactoryService->subtractTwoDates($firstDate[0]['createdAt'], $lastDate[0]['createdAt']);
                }

            $response[] = $this->autoMapping->map("array", OrderLogOwnerResponse::class, $item);
        }

       return  $response;
    }

    public function getLogsByUserIdForAdmin($userID, $userType)
    {
        if($userType == "store"){
           return $this->getOwnerOrderLogs($userID);
        }

        if($userType == "client"){
            return $this->getClientOrderLogs($userID);
        }

        if($userType == "captain"){
            return $this->getCaptainOrderLogs($userID);
        }

        return "not found";
    }
}
