<?php

namespace App\Controller;

use App\AutoMapping;
use App\Constant\ResponseConstant;
use App\Request\ElectronicPaymentInfoCreateRequest;
use App\Service\ElectronicPaymentInfoService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class ElectronicPaymentInfoController extends BaseController
{
    private $autoMapping;
    private $electronicPaymentInfoService;
    private $validator;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, ElectronicPaymentInfoService $electronicPaymentInfoService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->electronicPaymentInfoService = $electronicPaymentInfoService;
    }

//
//    /**
//     * client: add payment info online or update it.
//     * @Route("/addinfopay", name="addInfoPay", methods={"POST"})
//     * @IsGranted("ROLE_CLIENT")
//     * @param Request $request
//     * @return JsonResponse
//     * *
//     * @OA\Tag(name="Order")
//     *
//     * @OA\Parameter(
//     *      name="token",
//     *      in="header",
//     *      description="token to be passed as a header",
//     *      required=true
//     * )
//     *
//     * @OA\RequestBody (
//     *        description="add payment info online",
//     *        @OA\JsonContent(
//     *              @OA\Property(type="integer", property="orderNumber"),
//     *              @OA\Property(type="integer", property="transactionID"),
//     *              @OA\Property(type="string", property="payStatus", description="not paid or paid"),
//     *              @OA\Property(type="string", property="token"),
//     *              @OA\Property(type="number", property="amount"),
//     *         ),
//     *      ),
//     *
//     * @OA\Response(
//     *      response=201,
//     *      description="Return object.",
//     *      @OA\JsonContent(
//     *          @OA\Property(type="string", property="status_code"),
//     *          @OA\Property(type="string", property="msg"),
//     *          @OA\Property(type="object", property="Data",
//     *              @OA\Property(type="integer", property="id"),
//     *              @OA\Property(type="integer", property="orderNumber"),
//     *              @OA\Property(type="string", property="payStatus"),
//     *              @OA\Property(type="string", property="token"),
//     *              @OA\Property(type="integer", property="transactionID"),
//     *              @OA\Property(type="number", property="amount"),
//     *              )
//     *          )
//     *     )
//     *
//     * or
//     *
//     * @OA\Response(
//     *      response=204,
//     *      description="Return object.",
//     *      @OA\JsonContent(
//     *          @OA\Property(type="string", property="status_code"),
//     *          @OA\Property(type="string", property="msg"),
//     *          @OA\Property(type="object", property="Data",
//     *              @OA\Property(type="integer", property="id"),
//     *              @OA\Property(type="integer", property="orderNumber"),
//     *              @OA\Property(type="string", property="payStatus"),
//     *              @OA\Property(type="string", property="token"),
//     *              @OA\Property(type="integer", property="transactionID"),
//     *              @OA\Property(type="number", property="amount"),
//     *              )
//     *          )
//     *     )
//     *
//     * @Security(name="Bearer")
//     */
//    public function addInfoPay(Request $request): JsonResponse
//    {
//        $data = json_decode($request->getContent(), true);
//
//        $request = $this->autoMapping->map(stdClass::class, ElectronicPaymentInfoCreateRequest::class, (object) $data);
//
//        $violations = $this->validator->validate($request);
//        if (\count($violations) > 0) {
//            $violationsString = (string) $violations;
//
//            return new JsonResponse($violationsString, Response::HTTP_OK);
//        }
//
//        $response = $this->electronicPaymentInfoService->addInfoPay($request);
//        if($response->methods == "update"){
//            return $this->response($response, self::UPDATE);
//        }
//
//        return $this->response($response, self::CREATE);
//    }
}