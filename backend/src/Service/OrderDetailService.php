<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\OrderDetailEntity;
use App\Manager\OrderDetailManager;
use App\Request\OrderUpdateByClientRequest;
use App\Request\OrderUpdateInvoiceByCaptainRequest;
use App\Request\OrderUpdateProductCountByClientRequest;
use App\Request\OrderUpdateStateByOrderStateRequest;
use App\Request\OrderUpdateStateForEachStoreByCaptainRequest;
use App\Response\OrderCreateDetailResponse;
use App\Response\OrderDetailForStoreResponse;
use App\Response\OrderDetailProductsForAdminResponse;
use App\Response\OrderDetailProductsResponse;
use App\Response\OrderDetailResponse;
use App\Response\OrderUpdateInvoiceByCaptainResponse;
use App\Response\OrderUpdateProductCountByClientResponse;
use App\Response\OrderUpdateStateForEachStoreResponse;
use App\Response\OrderUpdateStateResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class OrderDetailService
{
    private $autoMapping;
    private $orderDetailManager;
    private $params;
    const PENDING="pending";

    public function __construct(AutoMapping $autoMapping, OrderDetailManager $orderDetailManager, ParameterBagInterface $params)
    {
        $this->autoMapping = $autoMapping;
        $this->orderDetailManager = $orderDetailManager;
        $this->params = $params->get('upload_base_url') . '/';
    }

    public function createOrderDetail($orderID, $productID, $countProduct, $orderNumber, $state, $storeOwnerProfileID = 0)
    {
        $item['orderID'] = $orderID;
        $item['orderNumber'] = $orderNumber;
        $item['productID'] = $productID;
        $item['countProduct'] = $countProduct;
        $item['storeOwnerProfileID'] = $storeOwnerProfileID;
        $item['state'] = $state;

        $result = $this->orderDetailManager->createOrderDetail($item);

        return $this->autoMapping->map(OrderDetailEntity::class, OrderCreateDetailResponse::class, $result);
    }
    
    public function getLastOrderNumber()
    {
       return $this->orderDetailManager->getLastOrderNumber();
    }

    public function getOrderIdByOrderNumber($orderNumber)
    {
        $response = [];

        $items = $this->orderDetailManager->getOrderIdByOrderNumber($orderNumber);

        foreach ($items as $item) {
            $item['productImage'] = $this->getImageParams($item['productImage'], $this->params . $item['productImage'], $this->params);

            $response[] = $this->autoMapping->map('array', OrderDetailResponse::class, $item);
        }

       return $response;
    }

    public function getStoresWithProducts($orderNumber): array
    {
        $response = [];

        $stores = $this->orderDetailManager->getStoreOwnerProfileByOrderNumber($orderNumber);
        foreach ($stores as $store) {
            $store['image'] = $this->getImageParams($store['image'], $this->params . $store['image'], $this->params);
            $store['invoiceImage'] = $this->getImageParams($store['invoiceImage'], $this->params . $store['invoiceImage'], $this->params);

            $store['products'] = $this->getProductsByOrderNumberAndStoreID($orderNumber, $store['storeOwnerProfileID']);

            $response[] = $this->autoMapping->map('array', OrderDetailResponse::class, $store);
        }

        return $response;
    }

    public function getOrderDetailsByOrderNumberForAdmin($orderNumber): array
    {
        $response = [];

        $stores = $this->orderDetailManager->getStoreOwnerProfileByOrderNumber($orderNumber);
        foreach ($stores as $store) {
            $store['image'] = $this->getImageParams($store['image'], $this->params . $store['image'], $this->params);
            $store['invoiceImage'] = $this->getImageParams($store['invoiceImage'], $this->params . $store['invoiceImage'], $this->params);

            $store['products'] = $this->getProductsByOrderNumberAndStoreIDForAdmin($orderNumber, $store['storeOwnerProfileID']);

            $response[] = $this->autoMapping->map('array', OrderDetailResponse::class, $store);
        }

        return $response;
    }

    public function getOrderDetailsByOrderNumberForCaptain($orderNumber): array
    {
        $response = [];

        $stores = $this->orderDetailManager->getStoreOwnerProfileByOrderNumber($orderNumber);
        foreach ($stores as $store) {

            $store['image'] = $this->getImageParams($store['image'], $this->params . $store['image'], $this->params);
            $store['invoiceImage'] = $this->getImageParams($store['invoiceImage'], $this->params . $store['invoiceImage'], $this->params);

            $store['products'] = $this->getProductsByOrderNumberAndStoreIDForCaptain($orderNumber, $store['storeOwnerProfileID']);

            $response[] = $this->autoMapping->map('array', OrderDetailResponse::class, $store);
        }

        return $response;
    }

    public function getProductsByOrderNumberAndStoreID($orderNumber, $storeOwnerProfileID): array
    {
        $response = [];

        $items = $this->orderDetailManager->getProductsByOrderNumberAndStoreID($orderNumber, $storeOwnerProfileID);
        foreach ($items as $item) {
            $item['productImage'] = $this->getImageParams($item['productImage'], $this->params . $item['productImage'], $this->params);

            $response[] = $this->autoMapping->map('array', OrderDetailProductsResponse::class, $item);
        }

        return $response;
    }

    public function getProductsByOrderNumberAndStoreIDForStore($orderNumber, $storeOwnerProfileID): array
    {
        $response = [];

        $items = $this->orderDetailManager->getProductsByOrderNumberAndStoreID($orderNumber, $storeOwnerProfileID);
        foreach ($items as $item) {
            $item['productImage'] = $this->getImageParams($item['productImage'], $this->params . $item['productImage'], $this->params);
            $item['productPrice'] = $this->priceForStore($item['productPrice'], $item['discount']);

            $response[] = $this->autoMapping->map('array', OrderDetailProductsResponse::class, $item);
        }

        return $response;
    }

    //Total Products Price with discount, invoice for store
    public function getTotalProductsPriceByOrderNumberAndStoreIDForStore($orderNumber, $storeOwnerProfileID)
    {
        $productsPrices = [];

        $items = $this->orderDetailManager->getProductsByOrderNumberAndStoreID($orderNumber, $storeOwnerProfileID);

        foreach ($items as $item) {

            $item['productPrice'] = $this->priceForStore($item['productPrice'], $item['discount']);

            $productsPrices[] = $item['productPrice'] * $item['countProduct'];
        }

        $invoice = array_sum($productsPrices);

        return  round($invoice, 2);
    }

    public function getTotalProductsPriceByOrderNumberAndStoreIDForStoreOrders($orderNumber, $storeOwnerProfileID)
    {
        $productsPrices = [];

        $items = $this->orderDetailManager->getTotalProductsPriceByOrderNumberAndStoreIDForStoreOrders($orderNumber, $storeOwnerProfileID);

        foreach ($items as $item) {

            $item['productPrice'] = $this->priceForStore($item['productPrice'], $item['discount']);

            $productsPrices[] = $item['productPrice'] * $item['countProduct'];
        }

        return array_sum($productsPrices);

    }

    public function getProductsByOrderNumberAndStoreIDForClient($orderNumber, $storeOwnerProfileID): array
    {
        $response = [];

        $items = $this->orderDetailManager->getProductsByOrderNumberAndStoreID($orderNumber, $storeOwnerProfileID);
        foreach ($items as $item) {

            $item['productPrice'] = $this->priceForClient($item['isCommission'], $item['productPrice'], $item['commission'], $item['storeCommission'], $item['discount']);

            $item['productImage'] = $this->getImageParams($item['productImage'], $this->params . $item['productImage'], $this->params);

            $response[] = $this->autoMapping->map('array', OrderDetailProductsResponse::class, $item);
        }

        return $response;
    }

    public function getProductsByOrderNumberAndStoreIDForAdmin($orderNumber, $storeOwnerProfileID): array
    {
        $response = [];

        $items = $this->orderDetailManager->getProductsByOrderNumberAndStoreID($orderNumber, $storeOwnerProfileID);
        foreach ($items as $item) {

            $item['productPrice'] = $this->priceForAdmin($item['productPrice'], $item['discount']);
            $item['productPriceAndCommission'] =$this->priceForAdminWithCommission($item['isCommission'],  $item['productPrice'], $item['commission'], $item['storeCommission']);

            $item['productImage'] = $this->getImageParams($item['productImage'], $this->params . $item['productImage'], $this->params);

            $response[] = $this->autoMapping->map('array', OrderDetailProductsForAdminResponse::class, $item);
        }

        return $response;
    }

    public function getProductsByOrderNumberAndStoreIDForCaptain($orderNumber, $storeOwnerProfileID): array
    {
        $response = [];

        $items = $this->orderDetailManager->getProductsByOrderNumberAndStoreID($orderNumber, $storeOwnerProfileID);
        foreach ($items as $item) {

            $item['productPrice'] = $this->priceForCaptain($item['productPrice'], $item['discount']);

            $item['productImage'] = $this->getImageParams($item['productImage'], $this->params . $item['productImage'], $this->params);

            $response[] = $this->autoMapping->map('array', OrderDetailProductsResponse::class, $item);
        }

        return $response;
    }

    public function orderDetailsForClient($orderNumber): array
    {
        $response = [];

        $stores = $this->orderDetailManager->getStoreOwnerProfileByOrderNumber($orderNumber);
        foreach ($stores as $store) {
            $store['image'] = $this->getImageParams($store['image'], $this->params . $store['image'], $this->params);
            $store['invoiceImage'] = $this->getImageParams($store['invoiceImage'], $this->params . $store['invoiceImage'], $this->params);

            $store['products'] = $this->getProductsByOrderNumberAndStoreIDForClient($orderNumber, $store['storeOwnerProfileID']);

            $response[] = $this->autoMapping->map('array', OrderDetailResponse::class, $store);
        }

        return $response;
    }

    public function priceForClient($isCommission, $productPrice, $commission, $storeCommission, $discount)
    {
        $priceWithDiscount = $productPrice - ($productPrice * $discount / 100);;

        if($isCommission == true){
//            return ( $priceWithDiscount * $commission  / 100) + $priceWithDiscount;
            $productPrice = ( $priceWithDiscount * $commission  / 100) + $priceWithDiscount;
            return round($productPrice, 2);
        }

//        return ( $priceWithDiscount * $storeCommission  / 100) + $priceWithDiscount;
        $productPrice = ( $priceWithDiscount * $storeCommission  / 100) + $priceWithDiscount;
        return round($productPrice, 2);

    }

    public function priceForCaptain( $productPrice, $discount)
    {
        $productPrice = $productPrice - ($productPrice * $discount / 100);
        return round($productPrice, 2);
    }

    public function priceForStore( $productPrice, $discount)
    {
        return $productPrice - ($productPrice * $discount / 100);
    }

    public function priceForAdmin( $productPrice, $discount)
    {
        $productPrice = $productPrice - ($productPrice * $discount / 100);
        return round($productPrice, 2);
    }

    public function priceForAdminWithCommission($isCommission, $priceWithDiscount, $commission, $storeCommission)
    {
        if($isCommission == true){
            $productPrice = ( $priceWithDiscount * $commission  / 100) + $priceWithDiscount;
            return round($productPrice, 2);
        }

        $productPrice = ( $priceWithDiscount * $storeCommission  / 100) + $priceWithDiscount;
        return round($productPrice, 2);
    }

    public function orderDetails($orderNumber): array
    {
       return $this->getStoresWithProducts($orderNumber);
    }

    public function getStoreOwnerProfileIdAndOrderIDByOrderNumber($orderNumber)
    {
        //return StoreOwnerProfileId and orderID.
        return $this->orderDetailManager->getStoreOwnerProfileIdAndOrderIDByOrderNumber($orderNumber);
    }

    public function getOrderIdWithOutStoreProductByOrderNumber($orderNumber)
    {
        $response = [];
        $items = $this->orderDetailManager->getOrderIdWithOutStoreProductByOrderNumber($orderNumber);

        foreach ($items as $item) {
            $response[] = $this->autoMapping->map('array', OrderDetailResponse::class, $item);
        }

       return $response;
    }

    public function getOrderId($orderNumber)
    {
        return $this->orderDetailManager->getOrderId($orderNumber);
    }

    public function getStoreOrderInSpecificDate($fromDate, $toDate)
    {
        return $this->orderDetailManager->getStoreOrderInSpecificDate($fromDate, $toDate);
    }

    public function getOrderNumberByOrderId($orderID)
    {
        $response = [];
        $items = $this->orderDetailManager->getOrderNumberByOrderId($orderID);

        foreach ($items as $item) {
            $response[] = $this->autoMapping->map('array', OrderDetailResponse::class, $item);
        }

       return $response;
    }

    public function orderDetailDelete($id)
    {
        return $this->orderDetailManager->orderDetailDelete($id);
    }
    
    public function getCountOrdersEveryProductInLastMonth($fromDate, $toDate):?array
    {
       return $this->orderDetailManager->getCountOrdersEveryProductInLastMonth($fromDate, $toDate);
   }

    public function orderUpdateInvoiceByCaptain(OrderUpdateInvoiceByCaptainRequest $request)
    {
        $orderDetailIds = $this->orderDetailManager->getOrderDetailsByOrderNumberAndStoreProfileID($request->getOrderNumber(), $request->getStoreOwnerProfileID());

        foreach ($orderDetailIds as $orderDetailId){

            $request->setOrderDetailID($orderDetailId['id']);

            $item = $this->orderDetailManager->orderUpdateInvoiceByCaptain($request);
        }

        return $this->autoMapping->map(OrderDetailEntity::class, OrderUpdateInvoiceByCaptainResponse::class, $item);
    }

    public function UpdateProductCount(OrderUpdateProductCountByClientRequest $request)
    {
        $item = $this->orderDetailManager->UpdateProductCount($request);

        return $this->autoMapping->map(OrderDetailEntity::class, OrderUpdateProductCountByClientResponse::class, $item);
    }

    public function orderUpdateStateForEachStore(OrderUpdateStateForEachStoreByCaptainRequest $request)
    {
        $item=(object)[];
        $orderDetailIds = $this->orderDetailManager->getOrderDetailsByOrderNumberAndStoreProfileID($request->getOrderNumber(), $request->getStoreOwnerProfileID());
        foreach ($orderDetailIds as $orderDetailId){

            $request->setId($orderDetailId);
            $item = $this->orderDetailManager->orderUpdateStateForEachStore($request);
        }

        return $this->autoMapping->map(OrderDetailEntity::class, OrderUpdateStateForEachStoreResponse::class, $item);
    }

    public function orderUpdateStateByOrderState($state, $orderNumber, $captainID)
    {
        $item=(object)[];
        $storeIds = [];
        $orderDetailIds = $this->getOrderId($orderNumber);

        $request = new OrderUpdateStateByOrderStateRequest;
        $request->setState($state);
        $request->setCaptainID($captainID);

        foreach ($orderDetailIds as $orderDetailId){
            $request->setId($orderDetailId['id']);

            $item = $this->orderDetailManager->orderUpdateStateByOrderState($request);

            $storeIds[] = $item->getStoreOwnerProfileID();
        }

        $response[] = $this->autoMapping->map(OrderDetailEntity::class, OrderUpdateStateForEachStoreResponse::class, $item);
        $response['storeIds']= $storeIds;

        return $response;
    }

    public function getOrderDetailStates($orderNumber)
    {
        return $this->orderDetailManager->getOrderDetailStates($orderNumber);
    }

    public function getOrderIds($storeOwnerProfileId)
    {
        return $this->orderDetailManager->getOrderIds($storeOwnerProfileId);
    }

    public function getOrderIdsForCompletedOrders($storeOwnerProfileId)
    {
        return $this->orderDetailManager->getOrderIdsForCompletedOrders($storeOwnerProfileId);
    }

    public function getOrderIdsForOngoingOrders($storeOwnerProfileId)
    {
        return $this->orderDetailManager->getOrderIdsForOngoingOrders($storeOwnerProfileId);
    }

    public function getStorePendingOrders($storeOwnerProfileId)
    {
        return $this->orderDetailManager->getStorePendingOrders($storeOwnerProfileId);
    }

    public function getStoreOrders($storeOwnerProfileId)
    {
        return $this->orderDetailManager->getStoreOrders($storeOwnerProfileId);
    }

    public function getStoreOrdersInSpecificDate($fromDate, $toDate, $storeOwnerProfileID)
    {
        return $this->orderDetailManager->getStoreOrdersInSpecificDate($fromDate, $toDate, $storeOwnerProfileID);
    }

    public function getOrderDetailsByOrderNumberForStore($orderNumber, $storeOwnerProfileID)
    {
        $response = [];

        $items = $this->orderDetailManager->getOrderDetailsByOrderNumberForStore($orderNumber, $storeOwnerProfileID);
        foreach ($items as $item) {
            $item['image'] = $this->getImageParams($item['image'], $this->params . $item['image'], $this->params);
            $item['invoiceImage'] = $this->getImageParams($item['invoiceImage'], $this->params . $item['invoiceImage'], $this->params);
            $item['products'] = $this->getProductsByOrderNumberAndStoreIDForStore($orderNumber, $item['storeOwnerProfileID']);

            $response[] = $this->autoMapping->map('array', OrderDetailForStoreResponse::class, $item);
        }

        return $response;
    }

    public function getStoreOrdersOngoingForStoreOwner($storeOwnerProfileId)
    {
        return $this->orderDetailManager->getStoreOrdersOngoingForStoreOwner($storeOwnerProfileId);
    }

    public function getImageParams($imageURL, $image, $baseURL): array
    {
        if($imageURL) {
            $item['image'] = $image;
        }
        else {
            $item['image'] = $imageURL;
        }

        $item['imageURL'] = $imageURL;
        $item['baseURL'] = $baseURL;

        return $item;
    }

}
