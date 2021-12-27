<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\ResetPasswordOrderCreateRequest;
use App\Service\ResetPasswordOrderService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use OpenApi\Annotations as OA;

class ResetPasswordOrderController extends BaseController
{
    private $autoMapping;
    private $resetPasswordOrderService;
    private $validator;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ResetPasswordOrderService $resetPasswordOrderService, ValidatorInterface $validator)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->resetPasswordOrderService = $resetPasswordOrderService;
        $this->validator = $validator;
    }

    /**
     * store owner: create new reset password order.
     * @Route("resetpasswordorder", name="createResetPasswordOrderByStoreOwner", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Reset Password Order")
     *
     * @OA\RequestBody(
     *      description="Create new reset password order",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="userID")
     *      )
     * )
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns the new store owner's role and the creation date",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example=""),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="object", property="createdAt"),
     *                  @OA\Property(type="string", property="status")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns the new store owner's role and the creation date",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9155"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="object", property="createdAt"),
     *                  @OA\Property(type="string", property="status", example="noUserFound")
     *          )
     *      )
     * )
     */
    public function createResetPasswordOrder(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, ResetPasswordOrderCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0)
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->resetPasswordOrderService->createResetPasswordOrder($request);

        if ($result->status == 'noUserFound')
        {
            return $this->response($result, self::STORE_OWNER_IS_NOT_REGISTERED);
        }

        return $this->response($result, self::CREATE);
    }

}