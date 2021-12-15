<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\OrderDetailEntity;
use App\Manager\OrderDetailManager;
use App\Request\OrderUpdateByClientRequest;
use App\Request\OrderUpdateInvoiceByCaptainRequest;
use App\Request\OrderUpdateProductCountByClientRequest;
use App\Request\OrderUpdateStateForEachStoreByCaptainRequest;
use App\Response\OrderCreateDetailResponse;
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

    public function createOrderDetail($orderID, $productID, $countProduct, $orderNumber, $storeOwnerProfileID = 0)
    {
        $item['orderID'] = $orderID;
        $item['orderNumber'] = $orderNumber;
        $item['productID'] = $productID;
        $item['countProduct'] = $countProduct;
        $item['storeOwnerProfileID'] = $storeOwnerProfileID;
        $item['state'] = self::PENDING;

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
        $item = $this->orderDetailManager->orderUpdateInvoiceByCaptain($request);

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

    public function getOrderDetailStates($orderNumber)
    {
        return $this->orderDetailManager->getOrderDetailStates($orderNumber);
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
