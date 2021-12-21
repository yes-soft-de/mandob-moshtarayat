<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\VerifyCodeRequest;
use App\Service\VerificationService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use OpenApi\Annotations as OA;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class VerificationController extends BaseController
{
    private $autoMapping;
    private $verificationService;
    private $validator;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, VerificationService $verificationService, ValidatorInterface $validator)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->verificationService = $verificationService;
        $this->validator = $validator;
    }

    /**
     * store owner: verify code.
     * @Route("verifycode", name="createVerificationCodeRequest", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Verification")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Create new verification request",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="userID"),
     *          @OA\Property(type="string", property="code")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns incorrect entered data message",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9152"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="string", property="resultMessage", description="incorrectEnteredData")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns activated message",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="200"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="string", property="resultMessage", description="activated")
     *          )
     *      )
     * )
     *
     */
    public function checkVerificationCode(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, VerifyCodeRequest::class, (object)$data);

        $result = $this->verificationService->checkVerificationCode($request);

        if ($result->resultMessage == 'incorrectEnteredData')
        {
            return $this->response($result, self::INCORRECT_ENTERED_DATA);
        }
        elseif ($result->resultMessage == 'codeDateIsNotValid')
        {
            return $this->response($result, self::CODE_DATE_IS_NOT_VALID);
        }
        elseif ($result->resultMessage == 'activated')
        {
            return $this->response($result, self::FETCH);
        }
    }

}