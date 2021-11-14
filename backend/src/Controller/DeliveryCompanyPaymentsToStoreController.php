<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\DeliveryCompanyPaymentsToStoreCreateRequest;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use App\Service\DeliveryCompanyPaymentsToStoreService;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;

class DeliveryCompanyPaymentsToStoreController extends BaseController
{
    private $autoMapping;
    private $deliveryCompanyPaymentsToStoreService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, DeliveryCompanyPaymentsToStoreService $deliveryCompanyPaymentsToStoreService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->deliveryCompanyPaymentsToStoreService = $deliveryCompanyPaymentsToStoreService;
    }
    
    /**
     * @Route("/deliverycompanypaymentstostore", name="createDeliveryCompanyPaymentsTostore", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     * @OA\Tag(name="Delivery Company Payments To Store")
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     * @OA\RequestBody(
     *      description="Create Delivery Company Payments To store",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="storeOwnerProfileID"),
     *          @OA\Property(type="integer", property="amount"),
     *          @OA\Property(type="integer", property="note"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns the new Payment to store owner",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="integer", property="storeOwnerProfileID"),
     *                  @OA\Property(type="integer", property="amount"),
     *                  @OA\Property(type="object", property="date"),
     *                  @OA\Property(type="string", property="note")
     *          )
     *      )
     * )
     * @Security(name="Bearer")
     */
    public function createDeliveryCompanyPaymentsTostore(Request $request)
    {
            $data = json_decode($request->getContent(), true);

            $request = $this->autoMapping->map(stdClass::class, DeliveryCompanyPaymentsToStoreCreateRequest::class, (object)$data);

            $result = $this->deliveryCompanyPaymentsToStoreService->createDeliveryCompanyPaymentsTostore($request);

        return $this->response($result, self::CREATE);
    }

     /**
      * @Route("/deliverycompanypaymentstostore", name="getDeliveryCompanyPaymentsToStore", methods={"GET"})
      * @IsGranted("ROLE_OWNER")
      * @param Request $request
      * @return JsonResponse
      * @OA\Tag(name="Delivery Company Payments To Store")
      * @OA\Parameter(
      *      name="token",
      *      in="header",
      *      description="token to be passed as a header",
      *      required=true
      * )
      *
      * @OA\Response(
      *      response=200,
      *      description="Returns Payments to store owner",
      *      @OA\JsonContent(
      *          @OA\Property(type="string", property="status_code"),
      *          @OA\Property(type="string", property="msg"),
      *          @OA\Property(type="array", property="Data",
      *                  @OA\Items(
      *                  @OA\Property(type="integer", property="id"),
      *                  @OA\Property(type="integer", property="storeOwnerProfileID"),
      *                  @OA\Property(type="integer", property="amount"),
      *                  @OA\Property(type="object", property="date"),
      *                  @OA\Property(type="string", property="note")
      *          )
      *      )
      * )
      * )
      * @Security(name="Bearer")
      */
      public function getDeliveryCompanyPaymentsToStore()
      {
          $result = $this->deliveryCompanyPaymentsToStoreService->deliveryCompanyPaymentsToStoreByUserID($this->getUserId());
  
          return $this->response($result, self::FETCH);
      }
}
