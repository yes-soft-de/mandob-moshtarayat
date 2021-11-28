<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\DeliveryCompanyPaymentsFromCaptainCreateRequest;
use App\Service\DeliveryCompanyPaymentsFromCaptainService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;

class DeliveryCompanyPaymentsFromCaptainController extends BaseController
{
    private $autoMapping;
    private $deliveryCompanyPaymentsFromCaptainService;
    private $validator;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, DeliveryCompanyPaymentsFromCaptainService $deliveryCompanyPaymentsFromCaptainService, ValidatorInterface $validator)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->deliveryCompanyPaymentsFromCaptainService = $deliveryCompanyPaymentsFromCaptainService;
        $this->validator = $validator;
    }
    
    /**
     * @Route("/deliveryCompanyPaymentsFromCaptain", name="createDeliveryCompanyPaymentsFromCaptain", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Delivery Company Payment From Captain")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Create payment from captain to the company",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="captainId"),
     *          @OA\Property(type="integer", property="amount"),
     *          @OA\Property(type="string", property="note"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Return Object of payment",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="integer", property="captainId"),
     *                  @OA\Property(type="integer", property="amount"),
     *                  @OA\Property(type="object", property="date"),
     *                  @OA\Property(type="string", property="note"),
     *          )
     *      )
     * )
     * @Security(name="Bearer")
     */
    public function createDeliveryCompanyPaymentsFromCaptain(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, DeliveryCompanyPaymentsFromCaptainCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->deliveryCompanyPaymentsFromCaptainService->createDeliveryCompanyPaymentsFromCaptain($request);

        return $this->response($result, self::CREATE);
    }

     /**
      * @Route("/deliveryCompanyPaymentsFromCaptain", name="getDeliveryCompanyPaymentsFromCaptain", methods={"GET"})
      * @IsGranted("ROLE_CAPTAIN")
      * @param Request $request
      * @return JsonResponse
      * *
      * @OA\Tag(name="Delivery Company Payment From Captain")
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
      *      description="Return Array of payments",
      *      @OA\JsonContent(
      *          @OA\Property(type="string", property="status_code"),
      *          @OA\Property(type="string", property="msg"),
      *          @OA\Property(type="array", property="Data",
      *             @OA\Items(
      *                  @OA\Property(type="integer", property="id"),
      *                  @OA\Property(type="string", property="captainId"),
      *                  @OA\Property(type="integer", property="amount"),
      *                  @OA\Property(type="object", property="date"),
      *                  @OA\Property(type="string", property="note"),
      *              )
      *         )
      *      )
      * )
      * @Security(name="Bearer")
      */
      public function deliveryCompanyPaymentsFromCaptain()
      {
          $result = $this->deliveryCompanyPaymentsFromCaptainService->deliveryCompanyPaymentsFromCaptain($this->getUserId());
  
          return $this->response($result, self::FETCH);
      }
}
