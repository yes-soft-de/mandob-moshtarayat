<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\orderUpdateBillCalculatedByCaptainRequest;
use App\Service\OrderService;
use App\Request\OrderClientCreateRequest ;
use App\Request\OrderClientSendCreateRequest ;
use App\Request\OrderClientSpecialCreateRequest ;
use App\Request\OrderUpdateStateByCaptainRequest;
use App\Request\OrderUpdateByClientRequest;
use App\Request\OrderUpdateSpecialByClientRequest;
use App\Request\OrderUpdateSendByClientRequest;
use App\Request\OrderUpdateInvoiceByCaptainRequest;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use stdClass;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;


class OrderController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $orderService;
   
    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, OrderService $orderService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->orderService = $orderService;
    }

    /**
     * @Route("/closestOrders",   name="GetPendingOrdersForCaptain", methods={"GET"})
     * @IsGranted("ROLE_CAPTAIN") 
     * @return JsonResponse
     */
    public function closestOrders()
    {
        $response = $this->orderService->closestOrders($this->getUserId());

        if(is_string($response)){
          return $this->response($response, self::ERROR_CAPTAIN_INACTIVE);  
        }
        
        return $this->response($response, self::FETCH);
    }

    /**
     * @Route("/getPendingOrders", name="GetPendingOrders", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     */
    public function getPendingOrders()
    {    
         $result = $this->orderService->getPendingOrders();

        return $this->response($result, self::FETCH);
    }
    
    //To accept the order AND change state
    //state:on way to pick order or in store or picked or ongoing or delivered
    /**
     * @Route("/orderUpdateState", name="orderUpdateState", methods={"PUT"})
     * @IsGranted("ROLE_CAPTAIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function orderUpdateStateByCaptain(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderUpdateStateByCaptainRequest::class, (object) $data);
        $request->setCaptainID($this->getUserId());
        $response = $this->orderService->orderUpdateStateByCaptain($request);
        if(is_string($response)){
            return $this->response($response, self::ERROR);  
          }
        return $this->response($response, self::UPDATE);
    }

    /**
      * @Route("/getOrdersWithOutPending", name="getOrdersWithOutPendingForAdmin", methods={"GET"})
      * @IsGranted("ROLE_ADMIN")
      * @return JsonResponse
      */
      public function getOrdersWithOutPending()
      {
          $result = $this->orderService->getOrdersWithOutPending();
  
          return $this->response($result, self::FETCH);
      }

    /**
      * @Route("/getOrdersOngoing", name="getOrdersOngoingForAdmin", methods={"GET"})
      * @IsGranted("ROLE_ADMIN")
      * @return JsonResponse
      */
      public function getOrdersOngoing()
      {
          $result = $this->orderService->getOrdersOngoing();
  
          return $this->response($result, self::FETCH);
      }

    /**
     * @Route("/getOrdersInSpecificDate/{fromDate}/{toDate}", name="getOrdersInSpecificDate",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param $fromDate
     * @param $toDate
     * @return JsonResponse
     */
    public function getOrdersInSpecificDate($fromDate, $toDate): JsonResponse
    {
        $result = $this->orderService->getOrdersInSpecificDate($fromDate, $toDate);

        return $this->response($result, self::FETCH);
    }

   /**
     * @Route("/countOrdersEveryStoreInLastMonth", name="getCountOrdersEveryStoreInLastMonth",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function getCountOrdersEveryStoreInLastMonth()
    {
        $result = $this->orderService->getCountOrdersEveryStoreInLastMonth();

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/countOrdersEveryCaptainInLastMonth", name="getCountOrdersEveryCaptainInLastMonth",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     */
    public function getCountOrdersEveryCaptainInLastMonth(): JsonResponse
    {
        $result = $this->orderService->getCountOrdersEveryCaptainInLastMonth();

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/countOrdersEveryClientInLastMonth", name="getCountOrdersEveryClientInLastMonth",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     */
    public function getCountOrdersEveryClientInLastMonth(): JsonResponse
    {
        $result = $this->orderService->getCountOrdersEveryClientInLastMonth();

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/countOrdersEveryProductInLastMonth", name="getCountOrdersEveryProductInLastMonth",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     */
    public function getCountOrdersEveryProductInLastMonth(): JsonResponse
    {
        $result = $this->orderService->getCountOrdersEveryProductInLastMonth();

        return $this->response($result, self::FETCH);
    }

    /**
      * @Route("/getAcceptedOrder", name="getAcceptedOrderByCaptainId", methods={"GET"})
      * @IsGranted("ROLE_CAPTAIN")
      * @return JsonResponse
      */
      public function getAcceptedOrderByCaptainId(): JsonResponse
      {
          $result = $this->orderService->getAcceptedOrderByCaptainId($this->getUserId());
          return $this->response($result, self::FETCH);
      }

     /**
     * @Route("clientorder", name="createClientOrder", methods={"POST"})
     * @IsGranted("ROLE_CLIENT")
     */
    public function createClientOrder(Request $request): JsonResponse
    {  
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(stdClass::class, OrderClientCreateRequest::class, (object)$data);
        $request->setClientID($this->getUserId());
        $request->setProducts($data['products']);
        $response = $this->orderService->createClientOrder($request);
        if(is_string($response)){
            return $this->response($response, self::ERROR);  
          }
        return $this->response($response, self::CREATE);
    }

     /**
     * @Route("clientsendorder", name="createClientSendOrder", methods={"POST"})
     * @IsGranted("ROLE_CLIENT")
     */
    public function createClientSendOrder(Request $request): JsonResponse
    {  
        $data = json_decode($request->getContent(), true);
      
        $request = $this->autoMapping->map(stdClass::class, OrderClientSendCreateRequest::class, (object)$data);
        $request->setClientID($this->getUserId());
        $response = $this->orderService->createClientSendOrder($request);
        if(is_string($response)){
            return $this->response($response, self::ERROR);  
          }
        return $this->response($response, self::CREATE);
    }

     /**
     * @Route("clientSpecialOrder", name="createClientSpecialOrder", methods={"POST"})
     * @IsGranted("ROLE_CLIENT")
     */
    public function createClientSpecialOrder(Request $request): JsonResponse
    {  
        $data = json_decode($request->getContent(), true);
      
        $request = $this->autoMapping->map(stdClass::class, OrderClientSpecialCreateRequest::class, (object)$data);
        $request->setClientID($this->getUserId());
        $response = $this->orderService->createClientSpecialOrder($request);
        if(is_string($response)){
            return $this->response($response, self::ERROR);  
          }
        return $this->response($response, self::CREATE);
    }

    /**
      * @Route("orderstatusbyordernumber/{orderNumber}", name="getOrderStatusByOrderNumber", methods={"GET"})
      * @return JsonResponse
      */
    public function getOrderStatusByOrderNumber($orderNumber): JsonResponse
    {
        $result = $this->orderService->getOrderStatusByOrderNumber($orderNumber);
  
        return $this->response($result, self::FETCH);
      }

    /**
     * @Route("orderDetails/{orderNumber}", name="getOrderDetailsByOrderNumber", methods={"GET"})
     * @IsGranted("ROLE_CAPTAIN")
     * @param $orderNumber
     * @return JsonResponse
     */
    public function getOrderDetailsByOrderNumber($orderNumber): JsonResponse
    {
        $result = $this->orderService->getOrderDetailsByOrderNumber($orderNumber);
  
        return $this->response($result, self::FETCH);
      }

    /**
      * @Route("orderDetailsForAdmin/{orderNumber}", name="getOrderDetailsByOrderNumberForAdmin", methods={"GET"})
      * @IsGranted("ROLE_ADMIN")
      * @return JsonResponse
      */
    public function getOrderDetailsByOrderNumberForAdmin($orderNumber)
      {
        $result = $this->orderService->getOrderDetailsByOrderNumber($orderNumber);
  
        return $this->response($result, self::FETCH);
      }

    /**
     * @Route("/orderUpdatebyclient", name="orderUpdateByClient", methods={"PUT"})
     * @IsGranted("ROLE_CLIENT")
     * @param Request $request
     * @return JsonResponse
     */
    public function orderUpdateByClient(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderUpdateByClientRequest::class, (object) $data);
        $request->setProducts($data['products']);
        $response = $this->orderService->orderUpdateByClient($request, $this->getUserId());
        if(is_string($response)){
            return $this->response($response, self::ERROR);  
          }
        return $this->response($response, self::UPDATE);
    }
    
    /**
     * @Route("/orderSpecialUpdateByClient", name="orderSpecialUpdateByClient", methods={"PUT"})
     * @IsGranted("ROLE_CLIENT")
     * @param Request $request
     * @return JsonResponse
     */
    public function orderSpecialUpdateByClient(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderUpdateSpecialByClientRequest::class, (object) $data);
        $response = $this->orderService->orderSpecialUpdateByClient($request, $this->getUserId());
        if(is_string($response)){
            return $this->response($response, self::ERROR);  
          }
        return $this->response($response, self::UPDATE);
    }
    
    /**
     * @Route("/orderSendUpdateByClient", name="orderSendUpdateByClient", methods={"PUT"})
     * @IsGranted("ROLE_CLIENT")
     * @param Request $request
     * @return JsonResponse
     */
    public function orderSendUpdateByClient(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderUpdateSendByClientRequest::class, (object) $data);
        $response = $this->orderService->orderSendUpdateByClient($request, $this->getUserId());
        if(is_string($response)){
            return $this->response($response, self::ERROR);  
          }
        return $this->response($response, self::UPDATE);
    }

    /**
     * @Route("/ordercancel/{orderNumber}", name="orderCancel", methods={"PUT"})
     * @IsGranted("ROLE_CLIENT")
     * @return JsonResponse
     */
    public function orderCancel($orderNumber)
    {
        $response = $this->orderService->orderCancel($orderNumber, $this->getUserId());
        if(is_string($response)){
            return $this->response($response, self::ERROR);  
        }
        return $this->response($response, self::UPDATE);
    }   
    
    /**
      * @Route("ordersbyclientid", name="GetOrdersByClientID", methods={"GET"})
      * @IsGranted("ROLE_CLIENT")
      * @return JsonResponse
      */
      public function getOrdersByClientID()
      {
          $result = $this->orderService->getOrdersByClientID($this->getUserId());
  
          return $this->response($result, self::FETCH);
      }

    /**
      * @Route("ordersDeliveredAndCancelledByClientId", name="ordersDeliveredAndCancelledByClientId", methods={"GET"})
      * @IsGranted("ROLE_CLIENT")
      * @return JsonResponse
      */
      public function getOrdersDeliveredAndCancelledByClientId()
      {
          $result = $this->orderService->getOrdersDeliveredAndCancelledByClientId($this->getUserId());
  
          return $this->response($result, self::FETCH);
      }

    /**
     * @Route("/orderUpdateInvoiceByCaptain", name="orderUpdateInvoiceByCaptain", methods={"PUT"})
     * @IsGranted("ROLE_CAPTAIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function orderUpdateInvoiceByCaptain(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderUpdateInvoiceByCaptainRequest::class, (object) $data);
        $request->setCaptainID($this->getUserId());
        $response = $this->orderService->orderUpdateInvoiceByCaptain($request);
        if(is_string($response)){
            return $this->response($response, self::ERROR);  
          }
        return $this->response($response, self::UPDATE);
    }

     /**
     * @Route("/orderupdatebillcalculatedbycaptain", name="orderUpdateBillCalculatedByCaptain", methods={"PUT"})
     * @IsGranted("ROLE_CAPTAIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function orderUpdateBillCalculatedByCaptain(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, orderUpdateBillCalculatedByCaptainRequest::class, (object) $data);
        $request->setCaptainID($this->getUserId());
        $response = $this->orderService->orderUpdateBillCalculatedByCaptain($request);
        if(is_string($response)){
            return $this->response($response, self::ERROR);
          }
        return $this->response($response, self::UPDATE);
    }

    /**
     * @Route("/countReport", name="countReport",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     */
    public function countReport()
    {
        $result = $this->orderService->countReport();

        return $this->response($result, self::FETCH);
    }

    /**
      * @Route("ordersAndCountByStoreProfileId/{storeProfileId}", name="getOrdersAndCountByStoreProfileIdForAdmin", methods={"GET"})
      * @IsGranted("ROLE_ADMIN")
      * @return JsonResponse
      */
      public function getOrdersAndCountByStoreProfileId($storeProfileId)
      {
          $result = $this->orderService->getOrdersAndCountByStoreProfileId($storeProfileId);
  
          return $this->response($result, self::FETCH);
      }

    /**
      * @Route("ordersAndCountByCaptainId/{captainId}", name="getOrdersAndCountByCaptainIdForAdmin", methods={"GET"})
      * @IsGranted("ROLE_ADMIN")
      * @return JsonResponse
      */
      public function getOrdersAndCountByCaptainId($captainId)
      {
          $result = $this->orderService->getOrdersAndCountByCaptainId($captainId);
  
          return $this->response($result, self::FETCH);
      }
}
