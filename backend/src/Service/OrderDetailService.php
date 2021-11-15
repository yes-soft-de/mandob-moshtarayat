<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\OrderDetailEntity;
use App\Manager\OrderDetailManager;
use App\Response\OrderCreateDetailResponse;
use App\Response\OrderDetailResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;


class OrderDetailService
{
    private $autoMapping;
    private $orderDetailManager;
    private $params;

    public function __construct(AutoMapping $autoMapping, OrderDetailManager $orderDetailManager, ParameterBagInterface $params)
    {
        $this->autoMapping = $autoMapping;
        $this->orderDetailManager = $orderDetailManager;
        $this->params = $params->get('upload_base_url') . '/';
    }

    public function createOrderDetail($orderID, $productID, $countProduct, $orderNumber)
    {
       
        $item['orderID'] = $orderID;
        $item['orderNumber'] = $orderNumber;
        $item['productID'] = $productID;
        $item['countProduct'] = $countProduct;
        
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

    public function getOrderIdWithOutStoreProductByOrderNumber($orderNumber)
    {
        $response = [];
        $items = $this->orderDetailManager->getOrderIdWithOutStoreProductByOrderNumber($orderNumber);
        foreach ($items as $item) {
            $response[] = $this->autoMapping->map('array', OrderDetailResponse::class, $item);
        }
       return $response;
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

    public function getImageParams($imageURL, $image, $baseURL): array
    {
        $item['imageURL'] = $imageURL;
        $item['image'] = $image;
        $item['baseURL'] = $baseURL;

        return $item;
    }
}
