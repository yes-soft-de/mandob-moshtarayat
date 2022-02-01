<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\PreferredLanguageUpdateRequest;
use App\Request\UserProfilePreferredLanguageUpdateRequest;
use App\Service\MainService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use OpenApi\Annotations as OA;

class MainController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $mainService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, MainService $mainService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->mainService = $mainService;

    }

    /**
     * update the preferred language of either client, captain, or store owner profile
     * @Route("preferredlanguage", name="updatePreferredLanguageOfUser", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Main")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update user preferred language request",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="preferredLanguage"),
     *          @OA\Property(type="string", property="userType", example="captain, client, or owner")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the new captain's role and the creation date",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="array", property="roles",
     *                      @OA\Items(example="user")),
     *                  @OA\Property(type="object", property="createdAt")
     *          )
     *      )
     * )
     *
     */
    public function updatePreferredLanguage(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, UserProfilePreferredLanguageUpdateRequest::class, (object)$data);

        $request->setUserID($this->getUserId());

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->mainService->updatePreferredLanguage($request);

        if ($response->status == 'noCaptainProfileWasFound')
        {
            return $this->response($response, self::CAPTAIN_PROFILE_NOT_EXIST);
        }
        elseif ($response->status == 'noClientProfileWasFound')
        {
            return $this->response($response, self::CLIENT_PROFILE_NOT_EXIST);
        }
        elseif ($response->status == 'noStoreOwnerProfileWasFound')
        {
            return $this->response($response, self::STORE_OWNER_PROFILE_NOT_EXIST);
        }

        return $this->response($response, self::UPDATE);
    }

}