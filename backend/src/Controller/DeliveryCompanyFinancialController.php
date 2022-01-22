<?php

namespace App\Controller;
use App\AutoMapping;
use App\Request\DeliveryCompanyFinancialRequest;
use App\Request\DeliveryCompanyFinancialUpdateRequest;
use App\Request\RepresentativeCommissionUpdateRequest;
use App\Service\DeliveryCompanyFinancialService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use OpenApi\Annotations as OA;


class DeliveryCompanyFinancialController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $deliveryCompanyFinancialService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, DeliveryCompanyFinancialService $deliveryCompanyFinancialService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->deliveryCompanyFinancialService = $deliveryCompanyFinancialService;
    }

    /**
     * @Route("deliveryCompanyFinancial", name="createDeliveryCompanyFinancial", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
    * 
    * @OA\Tag(name="Delivery Company Financial")
    *
    * @OA\Parameter(
    *      name="token",
    *      in="header",
    *      description="token to be passed as a header",
    *      required=true
    * )
    *
    *
    * @OA\RequestBody(
    *      description="create delivery cost and representative commission",
    *      @OA\JsonContent(
    *          @OA\Property(type="number", property="deliveryCost"),
    *          @OA\Property(type="number", property="representativeCommission")
    *      )
    * )
    *
    * @OA\Response(
    *      response=204,
    *      description="Returns the delivery cost and the representative commission",
    *      @OA\JsonContent(
    *          @OA\Property(type="string", property="status_code"),
    *          @OA\Property(type="string", property="msg"),
    *          @OA\Property(type="object", property="Data",
    *                  @OA\Property(type="integer", property="id"),
    *                  @OA\Property(type="number", property="deliveryCost"),
    *                  @OA\Property(type="number", property="representativeCommission")
    *          )
    *      )
    * )
    *
    */
    public function createDeliveryCompanyFinancial(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, DeliveryCompanyFinancialRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->deliveryCompanyFinancialService->createDeliveryCompanyFinancial($request);            

        return $this->response($result, self::CREATE);
    }

     /**
     * @Route("deliveryCompanyFinancial", name="updateDeliveryCompanyFinancial", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse
     */
    public function updateDeliveryCompanyFinancial(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, DeliveryCompanyFinancialUpdateRequest::class, (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->deliveryCompanyFinancialService->updateDeliveryCompanyFinancial($request);

        return $this->response($result, self::UPDATE);
    }

    /**
    * @Route("representativecommission", name="updateDeliveryCompanyRepresentativeCommission", methods={"PUT"})
    * @param Request $request
    * @return JsonResponse
    * 
    * @OA\Tag(name="Delivery Company Financial")
    *
    * @OA\RequestBody(
    *      description="update representative commission",
    *      @OA\JsonContent(
    *          @OA\Property(type="integer", property="id"),
    *          @OA\Property(type="number", property="representativeCommission")
    *      )
    * )
    *
    * @OA\Response(
    *      response=204,
    *      description="Returns the delivery cost and the representative commission",
    *      @OA\JsonContent(
    *          @OA\Property(type="string", property="status_code"),
    *          @OA\Property(type="string", property="msg"),
    *          @OA\Property(type="object", property="Data",
    *                  @OA\Property(type="integer", property="id"),
    *                  @OA\Property(type="number", property="deliveryCost"),
    *                  @OA\Property(type="number", property="representativeCommission")
    *          )
    *      )
    * )
    *
    */
    public function updateRepresentativeCommission(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, RepresentativeCommissionUpdateRequest::class, (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->deliveryCompanyFinancialService->updateDeliveryCompanyRepresentativeCommission($request);

        return $this->response($result, self::UPDATE);
    }

     /**
     * @Route("getDeliveryCompanyFinancialById/{id}", name="getDeliveryCompanyFinancialById", methods={"GET"})
     * @return JsonResponse
     */
    public function getDeliveryCompanyFinancialById($id)
    {
        $result = $this->deliveryCompanyFinancialService->getDeliveryCompanyFinancialById($id);

        return $this->response($result, self::FETCH);
    }

     /**
     * @Route("getDeliveryCompanyFinancialAll", name="getDeliveryCompanyFinancialAll", methods={"GET"})
     * @return JsonResponse
     */
    public function getDeliveryCompanyFinancialAll()
    {
        $result = $this->deliveryCompanyFinancialService->getDeliveryCompanyFinancialAll();

        return $this->response($result, self::FETCH);
    }
}
