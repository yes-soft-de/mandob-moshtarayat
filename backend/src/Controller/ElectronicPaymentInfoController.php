<?php

namespace App\Controller;

use App\Service\ElectronicPaymentInfoService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;


class ElectronicPaymentInfoController extends BaseController
{

    private $electronicPaymentInfoService;

    public function __construct(SerializerInterface $serializer, ElectronicPaymentInfoService $electronicPaymentInfoService)
    {
        parent::__construct($serializer);
        $this->electronicPaymentInfoService = $electronicPaymentInfoService;

    }
    /**
     * admin: Get Electronic Payment Info.
     * @Route("/electronicpaymentinfo", name="GetElectronicPaymentInfo",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     * *
     * @OA\Tag(name="Electronic Payment")
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
     *      description="Get Electronic Payment ,for admin",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *             @OA\Items(
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="transactionID"),
     *              @OA\Property(type="string", property="token"),
     *              @OA\Property(type="number", property="amount"),
     *              @OA\Property(type="string", property="payStatus"),
     *              @OA\Property(type="object", property="createdAt"),
     *              @OA\Property(type="object", property="updatedAt"),
     *              @OA\Property(type="integer", property="orderNumber"),
     *              @OA\Property(type="string", property="clientName"),
     *                    )
     *              )
     *          )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getElectronicPaymentInfo(): JsonResponse
    {
        $response = $this->electronicPaymentInfoService->getElectronicPaymentInfo();

        return $this->response($response, self::FETCH);
    }

}