<?php


namespace App\Controller;

use App\AutoMapping;
use App\Request\ActivateMandobAccountByAdminRequest;
use App\Request\MandobProfileUpdateRequest;
use App\Request\UserRegisterRequest;
use App\Service\MandobProfileService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;

class MandobProfileController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $mandobProfileService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, MandobProfileService $mandobProfileService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->mandobProfileService = $mandobProfileService;

    }

    /**
     * Create new mandob.
     * @Route("mandobregister", name="mandobRegister", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Mandob Profile")
     *
     * @OA\RequestBody(
     *      description="Create new mandob",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="userName"),
     *          @OA\Property(type="string", property="userID"),
     *          @OA\Property(type="string", property="password"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the new mandob's role and the creation date",
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
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Return user found.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9001"),
     *          @OA\Property(type="string", property="msg", description="error user found Successfully."),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="array", property="roles",
     *                      @OA\Items(example="user")),
     *              @OA\Property(type="object", property="createdAt"),
     *              @OA\Property(type="string", property="found"),
     *      )
     *  )
     *)
     */
    public function mandobRegister(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, UserRegisterRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string)$violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->mandobProfileService->mandobRegister($request);
        if (isset($response->found)) {
            return $this->response($response, self::ERROR_USER_FOUND);
        }

        return $this->response($response, self::CREATE);
    }

    /**
     * mandob: get profile.
     * @Route("representativeprofile", name="getMandobProfile", methods={"GET"})
     * @IsGranted("ROLE_MANDOB")
     * @return JsonResponse
     *
     * @OA\Tag(name="Mandob Profile")
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
     *      description="Returns mandob profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="mandobID"),
     *              @OA\Property(type="string", property="mandobName"),
     *              @OA\Property(type="object", property="image",
     *                  @OA\Property(type="string", property="imageURL"),
     *                  @OA\Property(type="string", property="image"),
     *                  @OA\Property(type="string", property="baseURL")
     *              ),
     *              @OA\Property(type="integer", property="age"),
     *              @OA\Property(type="string", property="bankName"),
     *              @OA\Property(type="string", property="bankAccountNumber"),
     *              @OA\Property(type="string", property="stcPay"),
     *              @OA\Property(type="string", property="phone"),
     *              @OA\Property(type="string", property="roomID"),
     *              @OA\Property(type="object", property="location"),
     *              @OA\Property(type="string", property="status"),
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getProfileByMandobID(): JsonResponse
    {
        $response = $this->mandobProfileService->getProfileByMandobID($this->getUserId());

        return $this->response($response, self::FETCH);
    }

    /**
     * admin: get mandob profile by profile id.
     * @Route("representativeprofile/{id}", name="getMandobProfileByIdForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param $id
     * @return JsonResponse
     *
     * @OA\Tag(name="Mandob Profile")
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
     *      description="Returns mandob profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="mandobID"),
     *              @OA\Property(type="string", property="mandobName"),
     *              @OA\Property(type="object", property="image",
     *                  @OA\Property(type="string", property="imageURL"),
     *                  @OA\Property(type="string", property="image"),
     *                  @OA\Property(type="string", property="baseURL")
     *              ),
     *              @OA\Property(type="integer", property="age"),
     *              @OA\Property(type="string", property="bankName"),
     *              @OA\Property(type="string", property="bankAccountNumber"),
     *              @OA\Property(type="string", property="stcPay"),
     *              @OA\Property(type="string", property="phone"),
     *              @OA\Property(type="string", property="roomID"),
     *              @OA\Property(type="object", property="location"),
     *              @OA\Property(type="string", property="status"),
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getProfileByIdForAdmin($id): JsonResponse
    {
        $response = $this->mandobProfileService->getProfileIdForAdmin($id);

        return $this->response($response, self::FETCH);
    }

    /**
     * mandob: Update mandob profile.
     * @Route("/mandobprofile", name="mandobProfileUpdate", methods={"PUT"})
     * @IsGranted("ROLE_MANDOB")
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Mandob Profile")
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update mandob profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="mandobName"),
     *          @OA\Property(type="string", property="image"),
     *          @OA\Property(type="integer", property="age"),
     *          @OA\Property(type="string", property="bankName"),
     *          @OA\Property(type="string", property="bankAccountNumber"),
     *          @OA\Property(type="string", property="stcPay"),
     *          @OA\Property(type="string", property="phone"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns mandob profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="mandobName"),
     *              @OA\Property(type="string", property="image"),
     *              @OA\Property(type="integer", property="age"),
     *              @OA\Property(type="string", property="bankName"),
     *              @OA\Property(type="string", property="bankAccountNumber"),
     *              @OA\Property(type="string", property="stcPay"),
     *              @OA\Property(type="string", property="phone"),
     *
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateMandobProfile(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, MandobProfileUpdateRequest::class, (object)$data);
        $request->setUserID($this->getUserId());

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string)$violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->mandobProfileService->updateMandobProfile($request);

        return $this->response($response, self::UPDATE);
    }

    /**
     * admin: Filter that fetches mandob by status.
     * @Route("/mandobfilterbystatus/{status}", name="mandobFilterByStatus", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     * *
     * @OA\Tag(name="Mandob Profile")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Parameter(
     *      name="status",
     *      in="path",
     *      description="status to be passed in the route",
     *      required=false
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns mandobs",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                 @OA\Property(type="integer", property="id"),
     *                 @OA\Property(type="string", property="mandobID"),
     *                 @OA\Property(type="string", property="mandobName"),
     *                 @OA\Property(type="object", property="location"),
     *                 @OA\Property(type="object", property="image",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL"),
     *                      ),
     *                  @OA\Property(type="integer", property="age"),
     *                  @OA\Property(type="string", property="status"),
     *                  @OA\Property(type="string", property="roomID"),
     *                  @OA\Property(type="string", property="phone"),
     *                  @OA\Property(type="string", property="bankName"),
     *                  @OA\Property(type="string", property="bankAccountNumber"),
     *                  @OA\Property(type="string", property="stcPay"),
     *                   )
     *             )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function mandobFilterByStatus($status): JsonResponse
    {
        $response = $this->mandobProfileService->mandobFilterByStatus($status);

        return $this->response($response, self::FETCH);
    }


    /**
     * admin: Activate/ deactivate  a mandob account by the admin.
     * @Route("/mandobupdatebyadmin", name="ActivateMandobAccountByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Mandob Profile")
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="status is active or inactive",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="status"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns mandob's profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                 @OA\Property(type="integer", property="id"),
     *                 @OA\Property(type="string", property="mandobID"),
     *                 @OA\Property(type="string", property="mandobName"),
     *                 @OA\Property(type="object", property="location"),
     *                 @OA\Property(type="object", property="image"),
     *                  @OA\Property(type="integer", property="age"),
     *                  @OA\Property(type="string", property="status"),
     *                  @OA\Property(type="string", property="phone"),
     *                  @OA\Property(type="string", property="bankName"),
     *                  @OA\Property(type="string", property="bankAccountNumber"),
     *                  @OA\Property(type="string", property="stcPay"),
     *                   )
     *             )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function activateMandobAccountByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, ActivateMandobAccountByAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string)$violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->mandobProfileService->activateMandobAccountByAdmin($request);

        return $this->response($response, self::UPDATE);
    }

    /**
     * admin: Get representative's financial account.
     * @Route("representativefinancialaccountforadmin/{representativeID}", name="getRepresentativeFinancialAccountForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param $representativeID
     * @return JsonResponse
     *
     * @OA\Tag(name="Mandob Profile")
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
     *      description="Get representative's financial account ,for admin",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="array", property="paymentsToRepresentative",
     *                  @OA\Items(
     *                          @OA\Property(type="integer", property="id"),
     *                          @OA\Property(type="string", property="representativeID"),
     *                          @OA\Property(type="number", property="amount"),
     *                          @OA\Property(type="object", property="date"),
     *                          @OA\Property(type="text", property="note"),
     *                  )
     *              ),
     *              @OA\Property(type="number", property="sumPaymentsToRepresentative"),
     *              @OA\Property(type="number", property="countLinkedStores"),
     *              @OA\Property(type="number", property="sumRepresentativeDue"),
     *              @OA\Property(type="number", property="totalRemainingPaymentsToRepresentative")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getRepresentativeFinancialAccountForAdmin($representativeID): JsonResponse
    {
        $response = $this->mandobProfileService->getRepresentativeFinancialAccountForAdmin($representativeID);

        return $this->response($response, self::FETCH);
    }

    /**
     * admin: Get representative's financial account in last month.
     * @Route("representativefinancialaccountinlastmonthforadmin/{representativeID}", name="captainFinancialAccountInLastMonthForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param $representativeID
     * @return JsonResponse
     *
     * @OA\Tag(name="Mandob Profile")
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
     *      description="Get representative's financial account in last month ,for admin",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *             @OA\Property(type="array", property="paymentsToRepresentative",
     *                  @OA\Items(
     *                          @OA\Property(type="integer", property="id"),
     *                          @OA\Property(type="string", property="representativeID"),
     *                          @OA\Property(type="number", property="amount"),
     *                          @OA\Property(type="object", property="date"),
     *                          @OA\Property(type="text", property="note"),
     *                  )
     *              ),
     *              @OA\Property(type="number", property="sumPaymentsToRepresentative"),
     *              @OA\Property(type="number", property="countLinkedStores"),
     *              @OA\Property(type="number", property="sumRepresentativeDue"),
     *              @OA\Property(type="number", property="totalRemainingPaymentsToRepresentative")
     *              )
     *          )
     * )
     * 
     * @Security(name="Bearer")
     */
    public function getRepresentativeFinancialAccountInLastMonthForAdmin($representativeID): JsonResponse
    {
        $response = $this->mandobProfileService->getRepresentativeFinancialAccountInLastMonthForAdmin($representativeID);

        return $this->response($response, self::FETCH);
    }
}
