<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\AddInfoPayByClientRequest;
use App\Request\orderUpdateBillCalculatedByCaptainRequest;
use App\Request\OrderUpdateStateForEachStoreByCaptainRequest;
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
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;
use App\Constant\ResponseConstant;

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
     * captain: Get pending orders for captain.
     * @Route("/closestorders",   name="GetPendingOrdersForCaptain", methods={"GET"})
     * @IsGranted("ROLE_CAPTAIN") 
     * @return JsonResponse
     * *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Return pending orders.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="object", property="deliveryDate"),
     *                  @OA\Property(type="string", property="payment"),
     *                  @OA\Property(type="string", property="orderNumber"),
     *                  @OA\Property(type="number", property="deliveryCost"),
     *                  @OA\Property(type="number", property="orderCost"),
     *                  @OA\Property(type="integer", property="orderType"),
     *                  @OA\Property(type="string", property="note"),
     *                  ),
     *            )
     *       )
     *  )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Return captain inactive.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9100"),
     *          @OA\Property(type="string", property="msg", description="error captain inactive Successfully."),
     *          @OA\Property(type="string", property="Data", description="captain inactive"),
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function closestOrders(): JsonResponse
    {
        $response = $this->orderService->closestOrders($this->getUserId());

        if($response == ResponseConstant::$CAPTAIN_INACTIVE){
           return $this->response($response, self::ERROR_CAPTAIN_INACTIVE);
        }
        
        return $this->response($response, self::FETCH);
    }

    /**
     * admin: Get pending orders for admin.
     * @Route("/getpendingorders", name="GetPendingOrders", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     * *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Return pending orders.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="object", property="deliveryDate"),
     *                  @OA\Property(type="string", property="payment"),
     *                  @OA\Property(type="string", property="orderNumber"),
     *                  @OA\Property(type="number", property="deliveryCost"),
     *                  @OA\Property(type="number", property="orderCost"),
     *                  @OA\Property(type="integer", property="orderType"),
     *                  @OA\Property(type="string", property="note"),
     *                  ),
     *            )
     *       )
     *  )
     * @Security(name="Bearer")
     */
    public function getPendingOrders()
    {    
        $result = $this->orderService->getPendingOrders();

        return $this->response($result, self::FETCH);
    }

    //state:on way to pick order or in store or picked or ongoing or delivered
    /**
     * captain: To accept the order AND change order state.
     * @Route("/orderupdatestate", name="orderUpdateState", methods={"PUT"})
     * @IsGranted("ROLE_CAPTAIN")
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody (
     *        description="To accept the order AND change state",
     *        @OA\JsonContent(
     *              @OA\Property(type="integer", property="orderNumber"),
     *              @OA\Property(type="string", property="state", description="on way to pick order or ongoing or delivered"),
     *              @OA\Property(type="number", property="deliveryCost"),
     *         ),
     *      ),
     *
     * @OA\Response(
     *      response=204,
     *      description="Return order.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="orderNumber"),
     *              @OA\Property(type="object", property="source"),
     *              @OA\Property(type="object", property="destination"),
     *              @OA\Property(type="object", property="deliveryDate"),
     *              @OA\Property(type="object", property="updatedAt"),
     *              @OA\Property(type="object", property="note"),
     *              @OA\Property(type="string", property="recipientName"),
     *              @OA\Property(type="string", property="recipientPhone"),
     *              @OA\Property(type="string", property="state"),
     *              @OA\Property(type="string", property="roomID"),
     *              @OA\Property(type="string", property="detail"),
     *              @OA\Property(type="string", property="deliveryCost"),
     *              @OA\Property(type="object", property="createdAt"),
     *              )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Return Not updated.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9201"),
     *          @OA\Property(type="string", property="msg", description="error Successfully."),
     *          @OA\Property(type="string", property="Data", description="error"),
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function orderUpdateStateByCaptain(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderUpdateStateByCaptainRequest::class, (object) $data);
        $request->setCaptainID($this->getUserId());

        $response = $this->orderService->orderUpdateStateByCaptain($request);
        if($response == ResponseConstant::$ERROR){
            return $this->response($response, self::ERROR);  
          }

        return $this->response($response, self::UPDATE);
    }

    /**
     * captain: Change order state for each store.(state is : in store or picked).
     * @Route("/orderupdatestateforeachstore", name="orderUpdateStateForEa chStore", methods={"PUT"})
     * @IsGranted("ROLE_CAPTAIN")
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody (
     *        description="To change state for store.",
     *        @OA\JsonContent(
     *              @OA\Property(type="integer", property="orderNumber"),
     *              @OA\Property(type="string", property="state", description="in store or picked"),
     *              @OA\Property(type="integer", property="storeOwnerProfileID"),
     *         ),
     *      ),
     *
     * @OA\Response(
     *      response=204,
     *      description="Return some order info.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="orderID"),
     *              @OA\Property(type="integer", property="orderNumber"),
     *              @OA\Property(type="integer", property="storeOwnerProfileID"),
     *              )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Return error.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9201"),
     *          @OA\Property(type="string", property="msg", description="error Successfully."),
     *          @OA\Property(type="string", property="Data", description="error"),
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function orderUpdateStateForEachStore(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderUpdateStateForEachStoreByCaptainRequest::class, (object) $data);
        $request->setCaptainID($this->getUserId());

        $response = $this->orderService->orderUpdateStateForEachStore($request);
        if($response == ResponseConstant::$ERROR){
            return $this->response($response, self::ERROR);
          }

        return $this->response($response, self::UPDATE);
    }

    /**
     * admin: Get orders without pending for admin.
     * @Route("/getorderswithoutpending", name="getOrdersWithOutPendingForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     * *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Get orders without pending.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="object", property="deliveryDate"),
     *                  @OA\Property(type="string", property="payment"),
     *                  @OA\Property(type="string", property="orderNumber"),
     *                  @OA\Property(type="number", property="deliveryCost"),
     *                  @OA\Property(type="number", property="orderCost"),
     *                  @OA\Property(type="integer", property="orderType"),
     *                  @OA\Property(type="string", property="note"),
     *                  ),
     *            )
     *       )
     *  )
     *
     *
     * @Security(name="Bearer")
     */
      public function getOrdersWithOutPending(): JsonResponse
      {
          $result = $this->orderService->getOrdersWithOutPending();
  
          return $this->response($result, self::FETCH);
      }

    /**
     * admin: Get orders ongoing for admin.
     * @Route("/getordersongoing", name="getOrdersOngoingForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     * *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Get orders without pending.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="object", property="deliveryDate"),
     *                  @OA\Property(type="string", property="payment"),
     *                  @OA\Property(type="string", property="orderNumber"),
     *                  @OA\Property(type="number", property="deliveryCost"),
     *                  @OA\Property(type="number", property="orderCost"),
     *                  @OA\Property(type="integer", property="orderType"),
     *                  @OA\Property(type="string", property="note"),
     *                  ),
     *            )
     *       )
     *  )
     *
     *
     * @Security(name="Bearer")
     */
      public function getOrdersOngoing(): JsonResponse
      {
          $result = $this->orderService->getOrdersOngoing();
  
          return $this->response($result, self::FETCH);
      }

    /**
     * admin: Get orders in specific date.
     * @Route("/getordersinspecificdate/{fromDate}/{toDate}", name="getOrdersInSpecificDate",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param $fromDate
     * @param $toDate
     * @return JsonResponse
     * *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Get orders in specific date.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="object", property="deliveryDate"),
     *                  @OA\Property(type="string", property="payment"),
     *                  @OA\Property(type="string", property="orderNumber"),
     *                  @OA\Property(type="number", property="deliveryCost"),
     *                  @OA\Property(type="number", property="orderCost"),
     *                  @OA\Property(type="integer", property="orderType"),
     *                  @OA\Property(type="string", property="note"),
     *                  ),
     *            )
     *       )
     *  )
     *
     *
     * @Security(name="Bearer")
     */
    public function getOrdersInSpecificDate($fromDate, $toDate): JsonResponse
    {
        $result = $this->orderService->getOrdersInSpecificDate($fromDate, $toDate);

        return $this->response($result, self::FETCH);
    }

   /**
    * admin: Get count orders every store in last month.
    * @Route("/countOrdersEveryStoreInLastMonth", name="getCountOrdersEveryStoreInLastMonth",methods={"GET"})
    * @IsGranted("ROLE_ADMIN")
    * @return JsonResponse
    * *
    * @OA\Tag(name="Order")
    *
    * @OA\Parameter(
    *      name="token",
    *      in="header",
    *      description="token to be passed as a header",
    *      required=true
    * )
    *
    * @OA\Response(
    *      response=200,
    *      description="Get count orders every store in last month.",
    *      @OA\JsonContent(
    *          @OA\Property(type="string", property="status_code"),
    *          @OA\Property(type="string", property="msg"),
    *          @OA\Property(type="array", property="Data",
    *              @OA\Items(
    *                  @OA\Property(type="integer", property="storeOwnerProfileID"),
    *                  @OA\Property(type="integer", property="countOrdersInMonth"),
    *                  @OA\Property(type="string", property="storeOwnerName"),
    *                  @OA\Property(type="object", property="image",
    *                       @OA\Property(type="string", property="imageURL"),
    *                       @OA\Property(type="string", property="image"),
    *                       @OA\Property(type="string", property="baseURL"),
    *
    *                       ),
    *            )
    *       )
    *  )
    *)
    * @Security(name="Bearer")
    */
    public function getCountOrdersEveryStoreInLastMonth()
    {
        $result = $this->orderService->getCountOrdersEveryStoreInLastMonth();

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: Get count orders every captain in last month.
     * @Route("/countorderseverycaptaininlastmonth", name="getCountOrdersEveryCaptainInLastMonth",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     * *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Get count orders every captain in last month.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="string", property="captainID"),
     *                  @OA\Property(type="integer", property="countOrdersInMonth"),
     *                  @OA\Property(type="string", property="captainName"),
     *                  @OA\Property(type="object", property="image",
     *                       @OA\Property(type="string", property="imageURL"),
     *                       @OA\Property(type="string", property="image"),
     *                       @OA\Property(type="string", property="baseURL"),
     *
     *                       ),
     *            )
     *       )
     *  )
     *)
     * @Security(name="Bearer")
     */
    public function getCountOrdersEveryCaptainInLastMonth(): JsonResponse
    {
        $result = $this->orderService->getCountOrdersEveryCaptainInLastMonth();

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: Get count orders every client in last month.
     * @Route("/countorderseveryclientinlastmonth", name="getCountOrdersEveryClientInLastMonth",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     * *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Get count orders every client in last month",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="string", property="clientID"),
     *                  @OA\Property(type="integer", property="countOrdersInMonth"),
     *                  @OA\Property(type="string", property="clientName"),
     *                  @OA\Property(type="object", property="image",
     *                       @OA\Property(type="string", property="imageURL"),
     *                       @OA\Property(type="string", property="image"),
     *                       @OA\Property(type="string", property="baseURL"),
     *
     *                       ),
     *                 )
     *           )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getCountOrdersEveryClientInLastMonth(): JsonResponse
    {
        $result = $this->orderService->getCountOrdersEveryClientInLastMonth();

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: Get count orders every product in last month.
     * @Route("/countorderseveryproductinlastmonth", name="getCountOrdersEveryProductInLastMonth",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     * *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Get count orders every product in last month.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="productID"),
     *                  @OA\Property(type="string", property="productName"),
     *                  @OA\Property(type="string", property="clientName"),
     *                  @OA\Property(type="object", property="productImage",
     *                       @OA\Property(type="string", property="imageURL"),
     *                       @OA\Property(type="string", property="image"),
     *                       @OA\Property(type="string", property="baseURL"),
     *
     *                       ),
     *                 )
     *           )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getCountOrdersEveryProductInLastMonth(): JsonResponse
    {
        $result = $this->orderService->getCountOrdersEveryProductInLastMonth();

        return $this->response($result, self::FETCH);
    }

    /**
     * captain: Get the orders received by the captain.
     * @Route("/getacceptedorder", name="getAcceptedOrderByCaptainId", methods={"GET"})
     * @IsGranted("ROLE_CAPTAIN")
     * @return JsonResponse
     * *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Return Accepted orders.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="object", property="deliveryDate"),
     *                  @OA\Property(type="string", property="payment"),
     *                  @OA\Property(type="string", property="orderNumber"),
     *                  @OA\Property(type="number", property="deliveryCost"),
     *                  @OA\Property(type="number", property="orderCost"),
     *                  @OA\Property(type="integer", property="orderType"),
     *                  @OA\Property(type="string", property="note"),
     *                  ),
     *            )
     *       )
     *  )
     * @Security(name="Bearer")
     */
      public function getAcceptedOrderByCaptainId(): JsonResponse
      {
          $result = $this->orderService->getAcceptedOrderByCaptainId($this->getUserId());

          return $this->response($result, self::FETCH);
      }

     /**
      * client: create multi-store order.
      * @Route("clientorder", name="createClientOrder", methods={"POST"})
      * @IsGranted("ROLE_CLIENT")
      * *
      * @OA\Tag(name="Order")
      *
      * @OA\Parameter(
      *      name="token",
      *      in="header",
      *      description="token to be passed as a header",
      *      required=true
      * )
      *
      * @OA\RequestBody (
      *        description="create multi-store order",
      *        @OA\JsonContent(
      *              @OA\Property(type="object", property="destination"),
      *              @OA\Property(type="string", property="note"),
      *              @OA\Property(type="string", property="payment", description="cash or card"),
      *              @OA\Property(type="string", property="token"),
      *              @OA\Property(type="string", property="transactionID"),
      *              @OA\Property(type="string", property="state", description="not required"),
      *              @OA\Property(type="array", property="orderDetails",
      *                 @OA\Items(
      *                     @OA\Property(type="integer", property="storeOwnerProfileID"),
      *                     @OA\Property(type="integer", property="productID"),
      *                     @OA\Property(type="integer", property="countProduct"),
      *                     ),
      *                 ),
      *              @OA\Property(type="object", property="deliveryDate"),
      *              @OA\Property(type="number", property="orderCost"),
      *              @OA\Property(type="number", property="deliveryCost"),
      *         ),
      *      ),
      *
      *
      * @OA\Response(
      *      response=201,
      *      description="Returns objetc of order details.",
      *      @OA\JsonContent(
      *          @OA\Property(type="string", property="status_code", description="201"),
      *          @OA\Property(type="string", property="msg"),
      *          @OA\Property(type="object", property="Data",
      *               @OA\Property(type="object", property="order",
      *                   @OA\Property(type="integer", property="id"),
      *                   @OA\Property(type="object", property="source"),
      *                   @OA\Property(type="object", property="destination"),
      *                   @OA\Property(type="object", property="deliveryDate"),
      *                   @OA\Property(type="object", property="updatedAt"),
      *                   @OA\Property(type="string", property="note"),
      *                   @OA\Property(type="string", property="payment"),
      *                   @OA\Property(type="string", property="token"),
      *                   @OA\Property(type="string", property="transactionID"),
      *                   @OA\Property(type="string", property="recipientName"),
      *                   @OA\Property(type="string", property="recipientPhone"),
      *                   @OA\Property(type="string", property="state"),
      *                   @OA\Property(type="string", property="roomID"),
      *                   @OA\Property(type="string", property="captainID"),
      *                   @OA\Property(type="object", property="createdAt"),
      *                   @OA\Property(type="string", property="detail"),
      *                   @OA\Property(type="number", property="deliveryCost"),
      *                   @OA\Property(type="number", property="orderCost"),
      *                   @OA\Property(type="integer", property="orderType"),
      *                           ),
      *                   @OA\Property(type="array", property="orderDetails",
      *                   @OA\Items(
      *                         @OA\Property(type="integer", property="orderID"),
      *                         @OA\Property(type="integer", property="storeOwnerProfileID"),
      *                         @OA\Property(type="string", property="storeOwnerName"),
      *                         @OA\Property(type="string", property="phone"),
      *                         @OA\Property(type="object", property="image",
      *                                 @OA\Property(type="object", property="imageURL"),
      *                                 @OA\Property(type="object", property="image"),
      *                                 @OA\Property(type="object", property="baseURL"),
      *                                          ),
      *                         @OA\Property(type="integer", property="storeCategoryId"),
      *                         @OA\Property(type="number", property="invoiceAmount"),
      *                         @OA\Property(type="object", property="invoiceImage",
      *                                 @OA\Property(type="object", property="imageURL"),
      *                                 @OA\Property(type="object", property="image"),
      *                                 @OA\Property(type="object", property="baseURL"),
      *                                          ),
      *                         @OA\Property(type="object", property="location"),
      *                         @OA\Property(type="string", property="state"),
      *                         @OA\Property(type="string", property="roomID"),
      *                         @OA\Property(type="array", property="products",
      *                              @OA\Items(
      *                                  @OA\Property(type="string", property="productName"),
      *                                  @OA\Property(type="object", property="productImage",
      *                                       @OA\Property(type="object", property="imageURL"),
      *                                       @OA\Property(type="object", property="image"),
      *                                       @OA\Property(type="object", property="baseURL"),
      *                                          ),
      *                         @OA\Property(type="number", property="productPrice"),
      *                         @OA\Property(type="integer", property="countProduct"),
      *                         @OA\Property(type="integer", property="ProductCategoryID"),
      *                         @OA\Property(type="integer", property="orderNumber"),
      *                         @OA\Property(type="integer", property="productID"),
      *                                           ),
      *                                       ),
      *
      *                               ),
      *               ),
      *          @OA\Property(type="number", property="deliveryCost"),
      *          @OA\Property(type="number", property="rate"),
      *      )
      *  )
      *)
      *
      * or
      *
      * @OA\Response(
      *      response="default",
      *      description="The order was not created",
      *      @OA\JsonContent(
      *          @OA\Property(type="string", property="status_code", description="9201"),
      *          @OA\Property(type="string", property="msg", description="Not created Successfully."),
      *          @OA\Property(type="string", property="Data", description="error"),
      *      )
      * )
      *
      * @Security(name="Bearer")
      */
    public function createClientOrder(Request $request): JsonResponse
    {  
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderClientCreateRequest::class, (object)$data);
        $request->setClientID($this->getUserId());

        if(!isset($data['orderDetails'])){
            return $this->response(ResponseConstant::$ERROR_VALIDATION_ORDER_DETAILS, self::ERROR);
        }

        $request->setOrderDetails($data['orderDetails']);

        $response = $this->orderService->createClientOrder($request);
        if($response == ResponseConstant::$ORDER_NOT_CREATED){
            return $this->response($response, self::ERROR);  
          }

        return $this->response($response, self::CREATE);
    }

     /**
      * client: create send order.
      * @Route("clientsendorder", name="createClientSendOrder", methods={"POST"})
      * @IsGranted("ROLE_CLIENT")
      * *
      * @OA\Tag(name="Order")
      *
      * @OA\Parameter(
      *      name="token",
      *      in="header",
      *      description="token to be passed as a header",
      *      required=true
      * )
      *
      * @OA\RequestBody (
      *        description="create client send order",
      *        @OA\JsonContent(
      *              @OA\Property(type="object", property="destination"),
      *              @OA\Property(type="string", property="note"),
      *              @OA\Property(type="string", property="payment"),
      *              @OA\Property(type="object", property="source"),
      *              @OA\Property(type="object", property="deliveryDate"),
      *              @OA\Property(type="string", property="recipientName"),
      *              @OA\Property(type="string", property="recipientPhone"),
      *              @OA\Property(type="string", property="detail"),
      *         ),
      *      ),
      *
      * @OA\Response(
      *      response=201,
      *      description="Return order.",
      *      @OA\JsonContent(
      *          @OA\Property(type="string", property="status_code"),
      *          @OA\Property(type="string", property="msg"),
      *          @OA\Property(type="object", property="Data",
      *              @OA\Property(type="integer", property="id"),
      *              @OA\Property(type="object", property="source"),
      *              @OA\Property(type="object", property="destination"),
      *              @OA\Property(type="object", property="deliveryDate"),
      *              @OA\Property(type="string", property="recipientName"),
      *              @OA\Property(type="string", property="recipientPhone"),
      *              @OA\Property(type="string", property="state"),
      *              @OA\Property(type="string", property="roomID"),
      *              @OA\Property(type="string", property="detail"),
      *              @OA\Property(type="object", property="orderDetail",
      *                 @OA\Property(type="integer", property="orderNumber"),
      *                 @OA\Property(type="integer", property="orderDetailId"),
      *              )
      *          )
      *     )
      *)
      *
      * or
      *
      * @OA\Response(
      *      response="default",
      *      description="The order was not created",
      *      @OA\JsonContent(
      *          @OA\Property(type="string", property="status_code", description="9201"),
      *          @OA\Property(type="string", property="msg", description="Not created Successfully."),
      *          @OA\Property(type="string", property="Data", description="error"),
      *      )
      * )
      * @Security(name="Bearer")
      */
    public function createClientSendOrder(Request $request): JsonResponse
    {  
        $data = json_decode($request->getContent(), true);
      
        $request = $this->autoMapping->map(stdClass::class, OrderClientSendCreateRequest::class, (object)$data);
        $request->setClientID($this->getUserId());

        $response = $this->orderService->createClientSendOrder($request);
        if($response == ResponseConstant::$ORDER_NOT_CREATED){
            return $this->response($response, self::ERROR);  
          }

        return $this->response($response, self::CREATE);
    }

    /**
     * client: create client special order.
     * @Route("clientspecialorder", name="createClientSpecialOrder", methods={"POST"})
     * @IsGranted("ROLE_CLIENT")
      * *
      * @OA\Tag(name="Order")
      *
      * @OA\Parameter(
      *      name="token",
      *      in="header",
      *      description="token to be passed as a header",
      *      required=true
      * )
      *
      * @OA\RequestBody (
      *        description="create client special order",
      *        @OA\JsonContent(
      *              @OA\Property(type="object", property="destination"),
      *              @OA\Property(type="string", property="note"),
      *              @OA\Property(type="string", property="payment", description="cash or card"),
      *              @OA\Property(type="string", property="transactionID"),
      *              @OA\Property(type="string", property="token"),
      *              @OA\Property(type="string", property="state", description="not required"),
      *              @OA\Property(type="string", property="detail"),
      *              @OA\Property(type="string", property="deliveryDate"),
      *              @OA\Property(type="integer", property="storeOwnerProfileID"),
      *         ),
      *      ),
      *
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns objetc of order details.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="201"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *               @OA\Property(type="object", property="order",
     *                   @OA\Property(type="integer", property="id"),
     *                   @OA\Property(type="object", property="source"),
     *                   @OA\Property(type="object", property="destination"),
     *                   @OA\Property(type="object", property="deliveryDate"),
     *                   @OA\Property(type="object", property="updatedAt"),
     *                   @OA\Property(type="string", property="note"),
     *                   @OA\Property(type="string", property="payment"),
     *                   @OA\Property(type="string", property="token"),
     *                   @OA\Property(type="string", property="transactionID"),
     *                   @OA\Property(type="string", property="recipientName"),
     *                   @OA\Property(type="string", property="recipientPhone"),
     *                   @OA\Property(type="string", property="state"),
     *                   @OA\Property(type="string", property="roomID"),
     *                   @OA\Property(type="string", property="captainID"),
     *                   @OA\Property(type="object", property="createdAt"),
     *                   @OA\Property(type="string", property="detail"),
     *                   @OA\Property(type="number", property="deliveryCost"),
     *                   @OA\Property(type="number", property="orderCost"),
     *                   @OA\Property(type="integer", property="orderType"),
     *                           ),
     *                   @OA\Property(type="array", property="orderDetails",
     *                   @OA\Items(
     *                         @OA\Property(type="integer", property="orderID"),
     *                         @OA\Property(type="integer", property="storeOwnerProfileID"),
     *                         @OA\Property(type="string", property="storeOwnerName"),
     *                         @OA\Property(type="string", property="phone"),
     *                         @OA\Property(type="object", property="image",
     *                                 @OA\Property(type="object", property="imageURL"),
     *                                 @OA\Property(type="object", property="image"),
     *                                 @OA\Property(type="object", property="baseURL"),
     *                                          ),
     *                         @OA\Property(type="integer", property="storeCategoryId"),
     *                         @OA\Property(type="number", property="invoiceAmount"),
     *                         @OA\Property(type="object", property="invoiceImage",
     *                                 @OA\Property(type="object", property="imageURL"),
     *                                 @OA\Property(type="object", property="image"),
     *                                 @OA\Property(type="object", property="baseURL"),
     *                                          ),
     *                         @OA\Property(type="object", property="location"),
     *                         @OA\Property(type="string", property="state"),
     *                         @OA\Property(type="string", property="roomID"),
     *                         @OA\Property(type="array", property="products",
     *                              @OA\Items(
     *                                  @OA\Property(type="string", property="productName"),
     *                                  @OA\Property(type="object", property="productImage",
     *                                       @OA\Property(type="object", property="imageURL"),
     *                                       @OA\Property(type="object", property="image"),
     *                                       @OA\Property(type="object", property="baseURL"),
     *                                          ),
     *                         @OA\Property(type="number", property="productPrice"),
     *                         @OA\Property(type="integer", property="countProduct"),
     *                         @OA\Property(type="integer", property="ProductCategoryID"),
     *                         @OA\Property(type="integer", property="orderNumber"),
     *                         @OA\Property(type="integer", property="productID"),
     *                                           ),
     *                                       ),
     *
     *                               ),
     *               ),
     *          @OA\Property(type="number", property="deliveryCost"),
     *          @OA\Property(type="number", property="rate"),
     *      )
     *  )
     *)
      *
      * or
      *
      * @OA\Response(
      *      response="default",
      *      description="The order was not created",
      *      @OA\JsonContent(
      *          @OA\Property(type="string", property="status_code", description="9201"),
      *          @OA\Property(type="string", property="msg", description="Not created Successfully."),
      *          @OA\Property(type="string", property="Data", description="error"),
      *      )
      * )
      *
      * @Security(name="Bearer")
      */
    public function createClientSpecialOrder(Request $request): JsonResponse
    {  
        $data = json_decode($request->getContent(), true);
      
        $request = $this->autoMapping->map(stdClass::class, OrderClientSpecialCreateRequest::class, (object)$data);
        $request->setClientID($this->getUserId());

        $response = $this->orderService->createClientSpecialOrder($request);
        if($response == ResponseConstant::$ORDER_NOT_CREATED){
            return $this->response($response, self::ERROR);  
          }

        return $this->response($response, self::CREATE);
    }

    /**
     * client: Get order details for client.
     * @Route("orderdetailsforclient/{orderNumber}", name="getOrderDetailsForClient", methods={"GET"})
     * @IsGranted("ROLE_CLIENT")
     * @param $orderNumber
     * @return JsonResponse
     * * *
     *
     * @OA\Tag(name="Order")
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns objetc of order details.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="201"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *               @OA\Property(type="object", property="order",
     *                   @OA\Property(type="integer", property="id"),
     *                   @OA\Property(type="object", property="source"),
     *                   @OA\Property(type="object", property="destination"),
     *                   @OA\Property(type="object", property="deliveryDate"),
     *                   @OA\Property(type="object", property="updatedAt"),
     *                   @OA\Property(type="string", property="note"),
     *                   @OA\Property(type="string", property="payment"),
     *                   @OA\Property(type="string", property="recipientName"),
     *                   @OA\Property(type="string", property="recipientPhone"),
     *                   @OA\Property(type="string", property="state"),
     *                   @OA\Property(type="string", property="roomID"),
     *                   @OA\Property(type="string", property="captainID"),
     *                   @OA\Property(type="object", property="createdAt"),
     *                   @OA\Property(type="string", property="detail"),
     *                   @OA\Property(type="number", property="deliveryCost"),
     *                   @OA\Property(type="number", property="orderCost"),
     *                   @OA\Property(type="integer", property="orderType"),
     *                   @OA\Property(type="integer", property="transactionID"),
     *                   @OA\Property(type="integer", property="token"),
     *                           ),
     *                   @OA\Property(type="array", property="orderDetails",
     *                   @OA\Items(
     *                         @OA\Property(type="integer", property="orderID"),
     *                         @OA\Property(type="integer", property="storeOwnerProfileID"),
     *                         @OA\Property(type="string", property="storeOwnerName"),
     *                         @OA\Property(type="string", property="phone"),
     *                         @OA\Property(type="object", property="image",
     *                                 @OA\Property(type="object", property="imageURL"),
     *                                 @OA\Property(type="object", property="image"),
     *                                 @OA\Property(type="object", property="baseURL"),
     *                                          ),
     *                         @OA\Property(type="integer", property="storeCategoryId"),
     *                         @OA\Property(type="number", property="invoiceAmount"),
     *                         @OA\Property(type="object", property="invoiceImage",
     *                                 @OA\Property(type="object", property="imageURL"),
     *                                 @OA\Property(type="object", property="image"),
     *                                 @OA\Property(type="object", property="baseURL"),
     *                                          ),
     *                         @OA\Property(type="object", property="location"),
     *                         @OA\Property(type="string", property="state"),
     *                         @OA\Property(type="string", property="roomID"),
     *                         @OA\Property(type="array", property="products",
     *                              @OA\Items(
     *                                  @OA\Property(type="string", property="productName"),
     *                                  @OA\Property(type="object", property="productImage",
     *                                       @OA\Property(type="object", property="imageURL"),
     *                                       @OA\Property(type="object", property="image"),
     *                                       @OA\Property(type="object", property="baseURL"),
     *                                          ),
     *                         @OA\Property(type="number", property="productPrice"),
     *                         @OA\Property(type="integer", property="countProduct"),
     *                         @OA\Property(type="integer", property="ProductCategoryID"),
     *                         @OA\Property(type="integer", property="orderNumber"),
     *                         @OA\Property(type="integer", property="productID"),
     *                                           ),
     *                                       ),
     *
     *                               ),
     *               ),
     *          @OA\Property(type="number", property="deliveryCost"),
     *          @OA\Property(type="number", property="rate"),
     *      )
     *  )
     *)
     */
    public function getOrderDetailsForClient($orderNumber): JsonResponse
    {
        $result = $this->orderService->getOrderDetailsForClient($orderNumber);
  
        return $this->response($result, self::FETCH);
      }

    /** captain: Get order details.
     * @Route("orderdetails/{orderNumber}", name="getOrderDetailsByOrderNumber", methods={"GET"})
     * @IsGranted("ROLE_CAPTAIN")
     * @param $orderNumber
     * @return JsonResponse
     *
     * @OA\Tag(name="Order")
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns objetc of order details.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="201"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *               @OA\Property(type="object", property="order",
     *                   @OA\Property(type="integer", property="id"),
     *                   @OA\Property(type="object", property="source"),
     *                   @OA\Property(type="object", property="destination"),
     *                   @OA\Property(type="object", property="deliveryDate"),
     *                   @OA\Property(type="object", property="updatedAt"),
     *                   @OA\Property(type="string", property="note"),
     *                   @OA\Property(type="string", property="payment"),
     *                   @OA\Property(type="string", property="recipientName"),
     *                   @OA\Property(type="string", property="recipientPhone"),
     *                   @OA\Property(type="string", property="state"),
     *                   @OA\Property(type="string", property="roomID"),
     *                   @OA\Property(type="string", property="captainID"),
     *                   @OA\Property(type="object", property="createdAt"),
     *                   @OA\Property(type="string", property="detail"),
     *                   @OA\Property(type="number", property="deliveryCost"),
     *                   @OA\Property(type="number", property="orderCost"),
     *                   @OA\Property(type="integer", property="orderType"),
     *                           ),
     *                   @OA\Property(type="array", property="orderDetails",
     *                   @OA\Items(
     *                         @OA\Property(type="integer", property="orderID"),
     *                         @OA\Property(type="integer", property="storeOwnerProfileID"),
     *                         @OA\Property(type="string", property="storeOwnerName"),
     *                         @OA\Property(type="string", property="phone"),
     *                         @OA\Property(type="object", property="image",
     *                                 @OA\Property(type="object", property="imageURL"),
     *                                 @OA\Property(type="object", property="image"),
     *                                 @OA\Property(type="object", property="baseURL"),
     *                                          ),
     *                         @OA\Property(type="integer", property="storeCategoryId"),
     *                         @OA\Property(type="number", property="invoiceAmount"),
     *                         @OA\Property(type="object", property="invoiceImage",
     *                                 @OA\Property(type="object", property="imageURL"),
     *                                 @OA\Property(type="object", property="image"),
     *                                 @OA\Property(type="object", property="baseURL"),
     *                                          ),
     *                         @OA\Property(type="object", property="location"),
     *                         @OA\Property(type="string", property="state"),
     *                         @OA\Property(type="string", property="roomID"),
     *                         @OA\Property(type="array", property="products",
     *                              @OA\Items(
     *                                  @OA\Property(type="string", property="productName"),
     *                                  @OA\Property(type="object", property="productImage",
     *                                       @OA\Property(type="object", property="imageURL"),
     *                                       @OA\Property(type="object", property="image"),
     *                                       @OA\Property(type="object", property="baseURL"),
     *                                          ),
     *                         @OA\Property(type="number", property="productPrice"),
     *                         @OA\Property(type="integer", property="countProduct"),
     *                         @OA\Property(type="integer", property="ProductCategoryID"),
     *                         @OA\Property(type="integer", property="orderNumber"),
     *                         @OA\Property(type="integer", property="productID"),
     *                                           ),
     *                                       ),
     *
     *                               ),
     *               ),
     *          @OA\Property(type="number", property="deliveryCost"),
     *          @OA\Property(type="number", property="rate"),
     *      )
     *  )
     *)
     */
    public function getOrderDetailsByOrderNumber($orderNumber): JsonResponse
    {
        $result = $this->orderService->getOrderDetailsByOrderNumberForCaptain($orderNumber);
  
        return $this->response($result, self::FETCH);
      }

    /**
     * admin: get Order Details.
      * @Route("orderdetailsforadmin/{orderNumber}", name="getOrderDetailsByOrderNumberForAdmin", methods={"GET"})
      * @IsGranted("ROLE_ADMIN")
      * @return JsonResponse
     *
     * @OA\Tag(name="Order")
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns objetc of order details.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="201"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *               @OA\Property(type="object", property="order",
     *                   @OA\Property(type="integer", property="id"),
     *                   @OA\Property(type="object", property="source"),
     *                   @OA\Property(type="object", property="destination"),
     *                   @OA\Property(type="object", property="deliveryDate"),
     *                   @OA\Property(type="object", property="updatedAt"),
     *                   @OA\Property(type="string", property="note"),
     *                   @OA\Property(type="string", property="payment"),
     *                   @OA\Property(type="string", property="recipientName"),
     *                   @OA\Property(type="string", property="recipientPhone"),
     *                   @OA\Property(type="string", property="state"),
     *                   @OA\Property(type="string", property="roomID"),
     *                   @OA\Property(type="string", property="captainID"),
     *                   @OA\Property(type="object", property="createdAt"),
     *                   @OA\Property(type="string", property="detail"),
     *                   @OA\Property(type="number", property="deliveryCost"),
     *                   @OA\Property(type="number", property="orderCost"),
     *                   @OA\Property(type="integer", property="orderType"),
     *                   @OA\Property(type="integer", property="transactionID"),
     *                   @OA\Property(type="integer", property="token"),
     *                           ),
     *                   @OA\Property(type="array", property="orderDetails",
     *                   @OA\Items(
     *                         @OA\Property(type="integer", property="orderID"),
     *                         @OA\Property(type="integer", property="storeOwnerProfileID"),
     *                         @OA\Property(type="string", property="storeOwnerName"),
     *                         @OA\Property(type="string", property="phone"),
     *                         @OA\Property(type="object", property="image",
     *                                 @OA\Property(type="object", property="imageURL"),
     *                                 @OA\Property(type="object", property="image"),
     *                                 @OA\Property(type="object", property="baseURL"),
     *                                          ),
     *                         @OA\Property(type="integer", property="storeCategoryId"),
     *                         @OA\Property(type="number", property="invoiceAmount"),
     *                         @OA\Property(type="object", property="invoiceImage",
     *                                 @OA\Property(type="object", property="imageURL"),
     *                                 @OA\Property(type="object", property="image"),
     *                                 @OA\Property(type="object", property="baseURL"),
     *                                          ),
     *                         @OA\Property(type="object", property="location"),
     *                         @OA\Property(type="string", property="state"),
     *                         @OA\Property(type="string", property="roomID"),
     *                         @OA\Property(type="array", property="products",
     *                              @OA\Items(
     *                                  @OA\Property(type="string", property="productName"),
     *                                  @OA\Property(type="object", property="productImage",
     *                                       @OA\Property(type="object", property="imageURL"),
     *                                       @OA\Property(type="object", property="image"),
     *                                       @OA\Property(type="object", property="baseURL"),
     *                                          ),
     *                         @OA\Property(type="number", property="productPrice"),
     *                         @OA\Property(type="integer", property="countProduct"),
     *                         @OA\Property(type="integer", property="ProductCategoryID"),
     *                         @OA\Property(type="integer", property="orderNumber"),
     *                         @OA\Property(type="integer", property="productID"),
     *                                           ),
     *                                       ),
     *
     *                               ),
     *               ),
     *          @OA\Property(type="number", property="deliveryCost"),
     *          @OA\Property(type="number", property="rate"),
     *      )
     *  )
     *)
     */
    public function getOrderDetailsByOrderNumberForAdmin($orderNumber): JsonResponse
    {
        $result = $this->orderService->getOrderDetailsByOrderNumberForAdmin($orderNumber);
  
        return $this->response($result, self::FETCH);
      }

    /**
     * client : Update count product order type 1.
     * @Route("/orderupdatebyclient", name="orderUpdateByClient", methods={"PUT"})
     * @IsGranted("ROLE_CLIENT")
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     *  @OA\RequestBody (
     *        description="Update the order of type one",
     *        @OA\JsonContent(
     *              @OA\Property(type="string", property="orderNumber"),
     *              @OA\Property(type="object", property="destination"),
     *              @OA\Property(type="string", property="payment"),
     *              @OA\Property(type="string", property="note"),
     *              @OA\Property(type="string", property="deliveryDate"),
     *              @OA\Property(type="string", property="orderCost"),
     *              @OA\Property(type="array",  property="products",
     *                  @OA\Items(
     *                       @OA\Property(type="integer", property="productID"),
     *                       @OA\Property(type="integer", property="countProduct"),
     *                  ),
     *               ),
     *         ),
     *      ),
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns object",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                @OA\Property(type="integer", property="orderNumber"),
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns string",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9203"),
     *          @OA\Property(type="string", property="msg", description="error Successfully."),
     *          @OA\Property(type="string", property="Data", description="you can't edit, The captain received the order"),
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function orderUpdateByClient(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderUpdateByClientRequest::class, (object) $data);
        $request->setProducts($data['products']);
        $request->setClientID($this->getUserId());

        $response = $this->orderService->orderUpdateByClient($request);
        if(($response == ResponseConstant::$ERROR)){
            return $this->response($response, self::NOTFOUND);
          }
        if(($response == ResponseConstant::$ORDER_NOT_UPDATE_STATE)){
            return $this->response($response, self::ERROR_ORDER_UPDATE);
          }

        return $this->response($response, self::UPDATE);
    }
    
    /**
     *  client: Update the order type Special.
     * @Route("/orderSpecialUpdateByClient", name="orderSpecialUpdateByClient", methods={"PUT"})
     * @IsGranted("ROLE_CLIENT")
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     *  @OA\RequestBody (
     *        description="Update the order type Special",
     *        @OA\JsonContent(
     *              @OA\Property(type="string", property="orderNumber"),
     *              @OA\Property(type="object", property="destination"),
     *              @OA\Property(type="string", property="note"),
     *              @OA\Property(type="string", property="payment"),
     *              @OA\Property(type="string", property="storeOwnerProfileID"),
     *         ),
     *      ),
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns object",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *            @OA\Property(type="object", property="order",
     *                @OA\Property(type="integer", property="id"),
     *                @OA\Property(type="integer", property="storeOwnerProfileID"),
     *                @OA\Property(type="object", property="destination"),
     *                @OA\Property(type="object", property="deliveryDate"),
     *                @OA\Property(type="string", property="note"),
     *                @OA\Property(type="string", property="payment"),
     *                @OA\Property(type="string", property="state"),
     *                @OA\Property(type="string", property="captainID"),
     *                @OA\Property(type="string", property="detail"),
     *                @OA\Property(type="integer", property="deliveryCost"),
     *                @OA\Property(type="integer", property="orderCost"),
     *                @OA\Property(type="integer", property="orderType"),
     *
     *              )
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response=425,
     *      description="Returns string",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="string", property="Data"),
     *      )
     * )
     *
     * @Security(name="Bearer")
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
     * client: Update the order type Send it about me.
     * @Route("/orderSendUpdateByClient", name="orderSendUpdateByClient", methods={"PUT"})
     * @IsGranted("ROLE_CLIENT")
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     *  @OA\RequestBody (
     *        description="Update the order invoice",
     *        @OA\JsonContent(
     *              @OA\Property(type="string", property="orderNumber"),
     *              @OA\Property(type="object", property="destination"),
     *              @OA\Property(type="string", property="note"),
     *              @OA\Property(type="string", property="payment"),
     *              @OA\Property(type="object", property="source"),
     *              @OA\Property(type="string", property="deliveryDate"),
     *              @OA\Property(type="string", property="recipientName"),
     *              @OA\Property(type="string", property="recipientPhone"),
     *              @OA\Property(type="string", property="detail"),
     *         ),
     *      ),
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns object",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *            @OA\Property(type="object", property="order",
     *                @OA\Property(type="integer", property="id"),
     *                @OA\Property(type="integer", property="storeOwnerProfileID"),
     *                @OA\Property(type="object", property="destination"),
     *                @OA\Property(type="object", property="deliveryDate"),
     *                @OA\Property(type="string", property="note"),
     *                @OA\Property(type="string", property="payment"),
     *                @OA\Property(type="string", property="state"),
     *                @OA\Property(type="string", property="captainID"),
     *                @OA\Property(type="string", property="detail"),
     *                @OA\Property(type="integer", property="deliveryCost"),
     *                @OA\Property(type="integer", property="orderCost"),
     *                @OA\Property(type="integer", property="orderType"),
     *
     *              )
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response=425,
     *      description="Returns string",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="string", property="Data"),
     *      )
     * )
     *
     * @Security(name="Bearer")
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
     * client: Cancelling order.
     * @Route("/ordercancel/{orderNumber}", name="orderCancel", methods={"PUT"})
     * @IsGranted("ROLE_CLIENT")
     * @return JsonResponse
     * *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns object",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns string",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9202"),
     *          @OA\Property(type="string", property="msg", description="error Successfully."),
     *          @OA\Property(type="string", property="Data", description="can not remove it"),
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function orderCancel($orderNumber): JsonResponse
    {
        $response = $this->orderService->orderCancel($orderNumber, $this->getUserId());
        if($response == ResponseConstant::$ORDER_NOT_REMOVE_TIME){
            return $this->response($response, self::ERROR_ORDER_REMOVE);
        }

        if($response == ResponseConstant::$ORDER_NOT_REMOVE_CAPTAIN_RECEIVED){
            return $this->response($response, self::ERROR_ORDER_REMOVE);
        }

        return $this->response($response, self::UPDATE);
    }   
    
    /**
     * client: Get client orders.
     * @Route("ordersbyclientid", name="GetOrdersByClientID", methods={"GET"})
     * @IsGranted("ROLE_CLIENT")
     * @return JsonResponse
     * *
     * @OA\Tag(name="Order")
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns array of client orders",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="object", property="deliveryDate"),
     *                  @OA\Property(type="string", property="state"),
     *                  @OA\Property(type="object", property="createdAt"),
     *                  @OA\Property(type="string", property="orderNumber"),
     *                  @OA\Property(type="number", property="amount"),
     *                  @OA\Property(type="number", property="deliveryCost"),
     *                  @OA\Property(type="number", property="orderCost"),
     *                  @OA\Property(type="integer", property="orderType"),
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
      public function getOrdersByClientID(): JsonResponse
      {
          $result = $this->orderService->getOrdersByClientID($this->getUserId());
  
          return $this->response($result, self::FETCH);
      }

    /**
     * client: orders delivered or cancelled.
     * @Route("ordersdeliveredandcancelledbyclientid", name="ordersDeliveredAndCancelledByClientId", methods={"GET"})
     * @IsGranted("ROLE_CLIENT")
     * @return JsonResponse
     * *
     * @OA\Tag(name="Order")
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns array of client orders",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="object", property="deliveryDate"),
     *                  @OA\Property(type="string", property="state"),
     *                  @OA\Property(type="object", property="createdAt"),
     *                  @OA\Property(type="string", property="orderNumber"),
     *                  @OA\Property(type="number", property="amount"),
     *                  @OA\Property(type="number", property="deliveryCost"),
     *                  @OA\Property(type="number", property="orderCost"),
     *                  @OA\Property(type="integer", property="orderType"),
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
      public function getOrdersDeliveredAndCancelledByClientId(): JsonResponse
      {
          $result = $this->orderService->getOrdersDeliveredAndCancelledByClientId($this->getUserId());
  
          return $this->response($result, self::FETCH);
      }

    /**
     * captain: Update the store invoice.
     * @Route("/orderupdateinvoicebycaptain", name="orderUpdateInvoiceByCaptain", methods={"PUT"})
     * @IsGranted("ROLE_CAPTAIN")
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody (
     *        description="Update the order invoice",
     *        @OA\JsonContent(
     *              @OA\Property(type="integer", property="storeOwnerProfileID"),
     *              @OA\Property(type="integer", property="orderNumber"),
     *              @OA\Property(type="number", property="invoiceAmount"),
     *              @OA\Property(type="string", property="invoiceImage"),
     *         ),
     *      ),
     *
     * @OA\Response(
     *      response=204,
     *      description="Return object.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="number", property="invoiceAmount"),
     *              @OA\Property(type="string", property="invoiceImage"),
     *              @OA\Property(type="integer", property="orderNumber"),
     *              )
     *          )
     *     )
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="The order was not updated",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9201"),
     *          @OA\Property(type="string", property="msg", description="error Successfully."),
     *          @OA\Property(type="string", property="Data", description="error"),
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function orderUpdateInvoiceByCaptain(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderUpdateInvoiceByCaptainRequest::class, (object) $data);
        $request->setCaptainID($this->getUserId());

        $response = $this->orderService->orderUpdateInvoiceByCaptain($request);
        if($response == ResponseConstant::$ERROR){
            return $this->response($response, self::ERROR);
        }
        return $this->response($response, self::UPDATE);
    }

    /**
     * captain:Will the invoice value be calculated in favor of the delivery company?
     * @Route("/orderupdatebillcalculatedbycaptain", name="orderUpdateBillCalculatedByCaptain", methods={"PUT"})
     * @IsGranted("ROLE_CAPTAIN")
     * @param Request $request
     * @return JsonResponse
      * *
      * @OA\Tag(name="Order")
      *
      * @OA\Parameter(
      *      name="token",
      *      in="header",
      *      description="token to be passed as a header",
      *      required=true
      * )
      *
      * @OA\RequestBody (
      *        description="isBillCalculated is boolean.",
      *        @OA\JsonContent(
      *              @OA\Property(type="string", property="orderNumber"),
      *              @OA\Property(type="boolean", property="isBillCalculated"),
      *         ),
      *      ),
      *
      * @OA\Response(
      *      response=204,
      *      description="Return object.",
      *      @OA\JsonContent(
      *          @OA\Property(type="string", property="status_code"),
      *          @OA\Property(type="string", property="msg"),
      *          @OA\Property(type="object", property="Data",
      *              @OA\Property(type="boolean", property="isBillCalculated"),
      *              )
      *          )
      *     )
      *
      * @Security(name="Bearer")
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
     * admin: Report.
     * @Route("/countreport", name="countReport",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     * *
     * @OA\Tag(name="Order")
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns Report",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="string", property="countCompletedOrders"),
     *              @OA\Property(type="string", property="countOngoingOrders"),
     *              @OA\Property(type="string", property="countCaptains"),
     *              @OA\Property(type="string", property="countClients"),
     *              @OA\Property(type="string", property="countStores"),
     *              @OA\Property(type="string", property="countProducts"),
     *              @OA\Property(type="string", property="countOrdersInToday"),
     *              )
     *          )
     *     )
     * )
     * @Security(name="Bearer")
     */
    public function countReport(): JsonResponse
    {
        $result = $this->orderService->countReport();

        return $this->response($result, self::FETCH);
    }

    /**
      * @Route("ordersandcountbystoreprofileid/{storeProfileId}", name="getOrdersAndCountByStoreProfileIdForAdmin", methods={"GET"})
      * @IsGranted("ROLE_ADMIN")
      * @return JsonResponse
      */
      public function getOrdersAndCountByStoreProfileId($storeProfileId): JsonResponse
      {
          $result = $this->orderService->getOrdersAndCountByStoreProfileId($storeProfileId);
  
          return $this->response($result, self::FETCH);
      }

    /**
     * admin: get captain's orders and count orders.
     * @Route("ordersandcountbycaptainid/{captainId}", name="getOrdersAndCountByCaptainIdForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     * *
     * @OA\Tag(name="Order")
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns array of captain orders",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="ordersCount"),
     *              @OA\Property(type="array", property="orders",
     *                @OA\Items(
     *                      @OA\Property(type="integer", property="id"),
     *                      @OA\Property(type="string", property="state"),
     *                      @OA\Property(type="object", property="deliveryDate"),
     *                      @OA\Property(type="object", property="createdAt"),
     *                      @OA\Property(type="integer", property="orderNumber"),
     *                      @OA\Property(type="number", property="amount"),
     *                      @OA\Property(type="integer", property="orderCost"),
     *                      @OA\Property(type="number", property="deliveryCost"),
     *                      @OA\Property(type="integer", property="orderType"),
     *                      ),
     *                  )
     *              )
     *          )
     *     )
     * )
     * @Security(name="Bearer")
     */
      public function getOrdersAndCountByCaptainId($captainId): JsonResponse
      {
          $result = $this->orderService->getOrdersAndCountByCaptainId($captainId);
  
          return $this->response($result, self::FETCH);
      }

    /**
     * store: Get store's ongoing orders.
     * @Route("/getstoreordersongoing", name="getStoreOrdersOngoingForStoreOwner", methods={"GET"})
     * @IsGranted("ROLE_OWNER")
     * @return JsonResponse
     * *
     * @OA\Tag(name="Order")
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns array of store orders",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="object", property="deliveryDate"),
     *                  @OA\Property(type="integer", property="storeOwnerProfileID"),
     *                  @OA\Property(type="integer", property="orderCost"),
     *                  @OA\Property(type="integer", property="orderType"),
     *                  @OA\Property(type="object", property="destination"),
     *                  @OA\Property(type="string", property="note"),
     *                  @OA\Property(type="string", property="state"),
     *                  @OA\Property(type="integer", property="orderNumber"),
     *                  @OA\Property(type="string", property="detail"),
     *              )
     *          )
     *      )
     * )
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Return store inactive.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9151"),
     *          @OA\Property(type="string", property="msg", description="error store inactive Successfully."),
     *          @OA\Property(type="string", property="Data", description="store inactive"),
     *      )
     * )
     * @Security(name="Bearer")
     */
    public function getStoreOrdersOngoingForStoreOwner(): JsonResponse
    {
        $result = $this->orderService->getStoreOrdersOngoingForStoreOwner($this->getUserId());
        if($result == ResponseConstant::$STORE_INACTIVE){
            return $this->response($result, self::ERROR_STORE_INACTIVE);
        }

        return $this->response($result, self::FETCH);
    }

    /**
     * store:get store's orders in specific date.
     * @Route("/getstoreordersinspecificdate/{fromDate}/{toDate}", name="getStoreOrdersInSpecificDate",methods={"GET"})
     * @IsGranted("ROLE_OWNER")
     * @param $fromDate
     * @param $toDate
     * @return JsonResponse
     * *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Get store's orders specific date .",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="object", property="deliveryDate"),
     *                  @OA\Property(type="string", property="orderNumber"),
     *                  @OA\Property(type="string", property="detail"),
     *                  @OA\Property(type="integer", property="orderType"),
     *                  @OA\Property(type="string", property="note"),
     *                  @OA\Property(type="integer", property="invoiceAmount"),
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getStoreOrdersInSpecificDate($fromDate, $toDate): JsonResponse
    {
        $result = $this->orderService->getStoreOrdersInSpecificDate($fromDate, $toDate, $this->getUserId());

        return $this->response($result, self::FETCH);
    }

    /**
     * store: Get store's orders.
     * @Route("/getstoreorders", name="getStoreOrders",methods={"GET"})
     * @IsGranted("ROLE_OWNER")
     * @return JsonResponse
     * *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Get store's orders",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="object", property="deliveryDate"),
     *                  @OA\Property(type="string", property="orderNumber"),
     *                  @OA\Property(type="string", property="detail"),
     *                  @OA\Property(type="integer", property="orderType"),
     *                  @OA\Property(type="string", property="note"),
     *                  @OA\Property(type="integer", property="invoiceAmount"),
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getStoreOrders(): JsonResponse
    {
        $result = $this->orderService->getStoreOrders($this->getUserId());

        return $this->response($result, self::FETCH);
    }

    /**
     * store: Report about count the orders (Completed - Ongoing - InToday).
     * @Route("countreportforstoreowner", name="countReportForStoreOwner", methods={"GET"})
     * @IsGranted("ROLE_OWNER")
     * @return JsonResponse
     * *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Report about count the orders (Completed - Ongoing - InToday) For Store Owner",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="countCompletedOrders"),
     *                  @OA\Property(type="integer", property="countOngoingOrders"),
     *                  @OA\Property(type="integer", property="countOrdersInToday")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function countReportForStoreOwner()
    {
        $result = $this->orderService->countReportForStoreOwner($this->getUserId());

        return $this->response($result, self::FETCH);
    }

    /**
     * store: Get order details.
     * @Route("orderdetailsforstore/{orderNumber}", name="getOrderDetailsByOrderNumberForStore", methods={"GET"})
     * @IsGranted("ROLE_OWNER")
     * @return JsonResponse
     * *
     * @OA\Tag(name="Order")
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns objetc of order details.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="201"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                   @OA\Property(type="array", property="orderDetails",
     *                   @OA\Items(
     *                         @OA\Property(type="integer", property="orderID"),
     *                         @OA\Property(type="string", property="phone"),
     *                         @OA\Property(type="object", property="image",
     *                                 @OA\Property(type="object", property="imageURL"),
     *                                 @OA\Property(type="object", property="image"),
     *                                 @OA\Property(type="object", property="baseURL"),
     *                                          ),
     *                         @OA\Property(type="integer", property="storeCategoryId"),
     *                         @OA\Property(type="string", property="roomID"),
     *                         @OA\Property(type="integer", property="createdAt"),
     *                         @OA\Property(type="integer", property="detail"),
     *                         @OA\Property(type="integer", property="orderType"),
     *                         @OA\Property(type="integer", property="note"),
     *                         @OA\Property(type="number", property="invoiceAmount"),
     *                         @OA\Property(type="object", property="invoiceImage",
     *                                 @OA\Property(type="object", property="imageURL"),
     *                                 @OA\Property(type="object", property="image"),
     *                                 @OA\Property(type="object", property="baseURL"),
     *                                          ),
     *                         @OA\Property(type="array", property="products",
     *                              @OA\Items(
     *                                  @OA\Property(type="string", property="productName"),
     *                                  @OA\Property(type="object", property="productImage",
     *                                       @OA\Property(type="object", property="imageURL"),
     *                                       @OA\Property(type="object", property="image"),
     *                                       @OA\Property(type="object", property="baseURL"),
     *                                          ),
     *                         @OA\Property(type="number", property="productPrice"),
     *                         @OA\Property(type="integer", property="countProduct"),
     *                         @OA\Property(type="integer", property="ProductCategoryID"),
     *                         @OA\Property(type="integer", property="orderNumber"),
     *                         @OA\Property(type="integer", property="productID"),
     *                                           ),
     *                                       ),
     *
     *                               ),
     *               ),
     *          @OA\Property(type="number", property="rate"),
     *      )
     *  )
     *)
     * @Security(name="Bearer")
     */
    public function getOrderDetailsByOrderNumberForStore($orderNumber): JsonResponse
    {
        $result = $this->orderService->getOrderDetailsByOrderNumberForStore($orderNumber, $this->getUserId());

        return $this->response($result, self::FETCH);
    }

    /**
     * store: Get store's pending orders.
     * @Route("storeorderspending",   name="GetStorePendingOrders", methods={"GET"})
     * @IsGranted("ROLE_OWNER")
     * @return JsonResponse
     * *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Get store's pending orders",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="object", property="deliveryDate"),
     *                  @OA\Property(type="string", property="orderNumber"),
     *                  @OA\Property(type="string", property="detail"),
     *                  @OA\Property(type="integer", property="orderType"),
     *                  @OA\Property(type="string", property="note"),
     *                  @OA\Property(type="integer", property="invoiceAmount"),
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getStorePendingOrders(): JsonResponse
    {
        $response = $this->orderService->getStorePendingOrders($this->getUserId());

        return $this->response($response, self::FETCH);
    }

    /**
     * client: add payment info online.
     * @Route("/addinfopay", name="addInfoPay", methods={"PUT"})
     * @IsGranted("ROLE_CLIENT")
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody (
     *        description="add payment info online",
     *        @OA\JsonContent(
     *              @OA\Property(type="integer", property="orderNumber"),
     *              @OA\Property(type="string", property="transactionID"),
     *              @OA\Property(type="string", property="state", description="not paid or pending"),
     *              @OA\Property(type="string", property="token"),
     *         ),
     *      ),
     *
     * @OA\Response(
     *      response=204,
     *      description="Return object.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="state"),
     *              @OA\Property(type="string", property="token"),
     *              @OA\Property(type="string", property="transactionID"),
     *              )
     *          )
     *     )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Return Not updated.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9201"),
     *          @OA\Property(type="string", property="msg", description="error Successfully."),
     *          @OA\Property(type="string", property="Data", description="error"),
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function addInfoPay(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AddInfoPayByClientRequest::class, (object) $data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->orderService->addInfoPay($request);
        if($response == ResponseConstant::$ERROR){
            return $this->response($response, self::ERROR);
        }

        return $this->response($response, self::UPDATE);
    }
}
