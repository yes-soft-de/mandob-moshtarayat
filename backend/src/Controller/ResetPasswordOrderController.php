<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\ResetPasswordOrderCreateRequest;
use App\Request\UserPasswordUpdateRequest;
use App\Request\VerifyResetPasswordCodeRequest;
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
     * @Route("resetpasswordorder", name="createResetPasswordOrderByStoreOwner", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Reset Password Order")
     *
     * @OA\RequestBody(
     *      description="Create new reset password order",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="userID"),
     *          @OA\Property(type="string", property="role", example="ROLE_CAPTAIN")
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

    /**
     * @Route("verifyresetpasswordcode", name="verifyResetPasswordCode", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Reset Password Order")
     *
     * @OA\RequestBody(
     *      description="update old password request fields",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="code"),
     *      )
     * )
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns the status of the code",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example=""),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="string", property="status")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns the status of the code",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9153"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="string", property="status")
     *          )
     *      )
     * )
     */
    public function verifyResetPasswordCode(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, VerifyResetPasswordCodeRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0)
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->resetPasswordOrderService->verifyResetPasswordCode($request);

        if ($result->status == 'invalid')
        {
            return $this->response($result, self::CODE_DATE_IS_NOT_VALID);
        }
        elseif ($result->status == 'noCodeExist')
        {
            return $this->response($result, self::INCORRECT_ENTERED_DATA);
        }

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("updatepassword", name="updateUserPassword", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Reset Password Order")
     *
     * @OA\RequestBody(
     *      description="update old password request fields",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="userID"),
     *          @OA\Property(type="string", property="password")
     *      )
     * )
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns the info of the updated user",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example=""),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="array", property="roles",
     *                      @OA\Items()
     *                  ),
     *                  @OA\Property(type="string", property="status"),
     *                  @OA\Property(type="object", property="createDate")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns the info of the updated user",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9001"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="array", property="roles",
     *                      @OA\Items()
     *                  ),
     *                  @OA\Property(type="string", property="status"),
     *                  @OA\Property(type="object", property="createDate")
     *          )
     *      )
     * )
     */
    public function updateUserPassword(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, UserPasswordUpdateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0)
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->resetPasswordOrderService->updateUserPassword($request);

        if ($result->status == 'noUserFound')
        {
            return $this->response($result, self::ERROR_USER_FOUND);
        }

        return $this->response($result, self::UPDATE);
    }

    /**
     * @Route("resetpasswordorders", name="getALLResetPasswordOrders", methods={"GET"})
     * @return JsonResponse
     */
    public function getAllResetPasswordOrders()
    {
        $result = $this->resetPasswordOrderService->getAllResetPasswordOrders();

        return $this->response($result, self::FETCH);
    }

}