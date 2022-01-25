<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\DeleteRequest;
use App\Request\storeOwnerProfileStatusUpdateByAdminRequest;
use App\Request\StoreOwnerProfileCreateByAdminRequest;
use App\Request\StoreOwnerProfileUpdateRequest;
use App\Request\StoreOwnerUpdateByAdminRequest;
use App\Request\UserRegisterRequest;
use App\Service\StoreOwnerProfileService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;

class StoreOwnerProfileController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $storeOwnerProfileService;
   
    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, StoreOwnerProfileService $storeOwnerProfileService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->storeOwnerProfileService = $storeOwnerProfileService;
        
    }

    /**
     * Create new store .
     * @Route("storeownerregister", name="storeOwnerRegister", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Store Owner Profile")
     *
     * @OA\RequestBody(
     *      description="Create new store owner",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="userName"),
     *          @OA\Property(type="string", property="userID"),
     *          @OA\Property(type="string", property="password"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the new store owner's role and the creation date",
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
    public function storeOwnerRegister(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        
        $request = $this->autoMapping->map(stdClass::class, UserRegisterRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if(\count($violations) > 0)
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->storeOwnerProfileService->storeOwnerRegister($request);
        if($response->found == 1)
        {
            return $this->response($response, self::ERROR_USER_FOUND);
        }

        return $this->response($response, self::CREATE);
    }

    /**
     * @Route("createstoreownerbydeveloper", name="createStoreOwner", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="user_register")
     *
     * @OA\RequestBody(
     *      description="Create new store owner",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="userName"),
     *          @OA\Property(type="string", property="userID"),
     *          @OA\Property(type="string", property="password"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the new store owner's role and the creation date",
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
    public function storeOwnerRegisterByTester(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, UserRegisterRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if(\count($violations) > 0)
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->storeOwnerProfileService->storeOwnerRegisterByDeveloper($request);

        return new JsonResponse('correct_response', 200);
    }

    /**
     * store: Update store profile.
     * @Route("/storeowner", name="storeOwnerProfileUpdate", methods={"PUT"})
     * @IsGranted("ROLE_OWNER")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Owner Profile")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update Store Owner Profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="storeOwnerName"),
     *          @OA\Property(type="string", property="image"),
     *          @OA\Property(type="string", property="phone"),
     *          @OA\Property(type="boolean", property="privateOrders"),
     *          @OA\Property(type="boolean", property="hasProducts"),
     *          @OA\Property(type="string", property="branchName"),
     *          @OA\Property(type="string", property="openingTime"),
     *          @OA\Property(type="string", property="closingTime"),
     *          @OA\Property(type="string", property="bankName"),
     *          @OA\Property(type="string", property="bankAccountNumber"),
     *          @OA\Property(type="string", property="stcPay"),
     *          @OA\Property(type="object", property="location",
     *              @OA\Property(type="string", property="lat"),
     *              @OA\Property(type="string", property="lon")
     *
     *          )
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns the store owner's profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="string", property="storeOwnerName"),
     *              @OA\Property(type="string", property="image"),
     *              @OA\Property(type="string", property="phone"),
     *              @OA\Property(type="integer", property="storeCategoryId"),
     *              @OA\Property(type="boolean", property="privateOrders"),
     *              @OA\Property(type="boolean", property="hasProducts"),
     *              @OA\Property(type="string", property="branchName"),
     *              @OA\Property(type="string", property="openingTime"),
     *              @OA\Property(type="string", property="closingTime"),
     *              @OA\Property(type="object", property="location",
     *                   @OA\Property(type="string", property="lat"),
     *                   @OA\Property(type="string", property="lon")
     *
     *          )
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function storeOwnerProfileUpdate(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StoreOwnerProfileUpdateRequest::class, (object)$data);
        $request->setUserID($this->getUserId());

        $violations = $this->validator->validate($request);
        if(\count($violations) > 0)
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->storeOwnerProfileService->storeOwnerProfileUpdate($request);
        return $this->response($response, self::UPDATE);
    }

    /**
     * admin: update store owner profile
     * @Route("/storeownerprofileupdatebyadmin", name="storeOwnerProfileUpdateByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     * @OA\Tag(name="Store Owner Profile")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update Store Owner Profile Info",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="storeOwnerName"),
     *          @OA\Property(type="string", property="image"),
     *          @OA\Property(type="string", property="is_best"),
     *          @OA\Property(type="boolean", property="privateOrders"),
     *          @OA\Property(type="boolean", property="hasProducts"),
     *          @OA\Property(type="string", property="openingTime"),
     *          @OA\Property(type="string", property="closingTime"),
     *          @OA\Property(type="string", property="bankName"),
     *          @OA\Property(type="string", property="bankAccountNumber"),
     *          @OA\Property(type="string", property="stcPay"),
     *          @OA\Property(type="string", property="status"),
     *          @OA\Property(type="float", property="commission")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns the store owner's profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="string", property="id"),
     *              @OA\Property(type="string", property="storeOwnerName"),
     *              @OA\Property(type="string", property="image"),
     *              @OA\Property(type="string", property="imageURL"),
     *              @OA\Property(type="string", property="baseURL"),
     *              @OA\Property(type="string", property="city"),
     *              @OA\Property(type="string", property="branch"),
     *              @OA\Property(type="string", property="free"),
     *              @OA\Property(type="string", property="status"),
     *              @OA\Property(type="string", property="phone"),
     *              @OA\Property(type="number", property="commission")
     *      )
     *   )
     * )
     * @Security(name="Bearer")
     */
    public function updateStoreOwnerByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StoreOwnerUpdateByAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if(\count($violations) > 0)
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->storeOwnerProfileService->updateStoreOwnerByAdmin($request);

        return $this->response($response, self::UPDATE);
    }
    /**
     * admin: Update store owner status.
     * @Route("/storeownerprofilestatusupdatebyadmin", name="storeOwnerProfileStatusUpdateByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Store Owner Profile")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update Store Owner Status",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="status"),
     *          @OA\Property(type="float", property="commission")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns the store owner's profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="string", property="id"),
     *              @OA\Property(type="string", property="storeOwnerName"),
     *              @OA\Property(type="string", property="image"),
     *              @OA\Property(type="integer", property="status"),
     *              @OA\Property(type="integer", property="phone"),
     *              @OA\Property(type="number", property="commission")
     *      )
     *   )
     * )
     * @Security(name="Bearer")
     */
    public function storeOwnerProfileStatusUpdateByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, storeOwnerProfileStatusUpdateByAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if(\count($violations) > 0)
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->storeOwnerProfileService->storeOwnerProfileStatusUpdateByAdmin($request);

        return $this->response($response, self::UPDATE);
    }

    /**
     * @Route("/storeownerprofilebyid/{id}", name="getStoreOwnerProfileByID",methods={"GET"})
     * @param $id
     * @return JsonResponse
     *  *
     * @OA\Response(
     *      response=200,
     *      description="Returns the signed-in store owner's profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="storeOwnerName"),
     *              @OA\Property(type="object", property="image"),
     *              @OA\Property(type="string", property="phone"),
     *              @OA\Property(type="string", property="branch"),
     *              @OA\Property(type="string", property="free"),
     *              @OA\Property(type="array", property="branches",
     *                  @OA\Items(
     *                      @OA\Property(type="integer", property="id"),
     *                      @OA\Property(type="integer", property="storeOwnerProfileID"),
     *                      @OA\Property(type="object", property="geoLocation",
     *                          @OA\Property(type="string", property="lat"),
     *                          @OA\Property(type="string", property="lon")
     *
     *                      ),
     *                      @OA\Property(type="string", property="city"),
     *                      @OA\Property(type="string", property="branchName"),
     *                      @OA\Property(type="string", property="storeOwnerName"),
     *                      @OA\Property(type="string", property="free"),
     *                      @OA\Property(type="boolean", property="isActive")
     *                  )
     *              ),
     *              @OA\Property(type="string", property="city"),
     *              @OA\Property(type="number", property="deliveryCost"),
     *              @OA\Property(type="number", property="rating"),
     *              @OA\Property(type="integer", property="storeCategoryId"),
     *              @OA\Property(type="string", property="storeCategoryName"),
     *              @OA\Property(type="boolean", property="privateOrders"),
     *              @OA\Property(type="boolean", property="hasProducts"),
     *              @OA\Property(type="string", property="branchName"),
     *              @OA\Property(type="object", property="openingTime"),
     *              @OA\Property(type="object", property="closingTime"),
     *              @OA\Property(type="string", property="status"),
     *              @OA\Property(type="string", property="commission"),
     *              @OA\Property(type="string", property="bankName"),
     *              @OA\Property(type="string", property="bankAccountNumber"),
     *              @OA\Property(type="string", property="stcPay"),
     *      )
     *   )
     * )
     *
     */
    public function getStoreOwnerProfileByID($id): JsonResponse
    {
        $response = $this->storeOwnerProfileService->getStoreOwnerProfileByID($id);

        return $this->response($response, self::FETCH);
    }

    /**
     * store: Get store owner profile.
     * @Route("storeownerprofilebyid", name="getStoreOwnerProfile", methods={"GET"})
     * @IsGranted("ROLE_OWNER")
     * @return JsonResponse
     * *
     * @OA\Tag(name="Store Owner Profile")
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
     *      description="Returns the signed-in store owner's profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="storeOwnerName"),
     *              @OA\Property(type="string", property="image"),
     *              @OA\Property(type="string", property="phone"),
     *              @OA\Property(type="string", property="branch"),
     *              @OA\Property(type="string", property="free"),
     *              @OA\Property(type="array", property="branches",
     *                  @OA\Items(
     *                      @OA\Property(type="integer", property="id"),
     *                      @OA\Property(type="integer", property="storeOwnerProfileID"),
     *                      @OA\Property(type="object", property="geoLocation",
     *                          @OA\Property(type="string", property="lat"),
     *                          @OA\Property(type="string", property="lon")
     *
     *                      ),
     *                      @OA\Property(type="string", property="city"),
     *                      @OA\Property(type="string", property="branchName"),
     *                      @OA\Property(type="string", property="storeOwnerName"),
     *                      @OA\Property(type="string", property="free"),
     *                      @OA\Property(type="boolean", property="isActive")
     *                  )
     *              ),
     *              @OA\Property(type="string", property="city"),
     *              @OA\Property(type="string", property="imageURL"),
     *              @OA\Property(type="string", property="baseURL"),
     *              @OA\Property(type="number", property="deliveryCost"),
     *              @OA\Property(type="number", property="rating"),
     *              @OA\Property(type="integer", property="storeCategoryId"),
     *              @OA\Property(type="string", property="storeCategoryName"),
     *              @OA\Property(type="boolean", property="privateOrders"),
     *              @OA\Property(type="boolean", property="hasProducts"),
     *              @OA\Property(type="string", property="branchName"),
     *              @OA\Property(type="object", property="openingTime"),
     *              @OA\Property(type="object", property="closingTime"),
     *              @OA\Property(type="string", property="status"),
     *              @OA\Property(type="string", property="commission"),
     *              @OA\Property(type="string", property="bankName"),
     *              @OA\Property(type="string", property="bankAccountNumber"),
     *              @OA\Property(type="string", property="stcPay"),
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getStoreOwnerProfile()
    {
        $response = $this->storeOwnerProfileService->getStoreOwnerProfile($this->getUserId());

        return $this->response($response, self::FETCH);
    }

    /**
     * Get all store owners.
     * @Route("/storeowners", name="getAllStoreOwners",methods={"GET"})
     * @return JsonResponse
     * *
     * @OA\Tag(name="Store Owner Profile")
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns array of Stores",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *          @OA\Items(
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="storeOwnerName"),
     *              @OA\Property(type="object", property="image"),
     *             @OA\Property(type="string", property="phone"),
     *             @OA\Property(type="object", property="location"),
     *             @OA\Property(type="number", property="deliveryCost"),
     *             @OA\Property(type="boolean", property="privateOrders"),
     *             @OA\Property(type="boolean", property="hasProducts"),
     *             @OA\Property(type="integer", property="storeCategoryId"),
     *             @OA\Property(type="string", property="rating"),
     *             @OA\Property(type="object", property="closingTime"),
     *             @OA\Property(type="object", property="openingTime"),
     *             @OA\Property(type="string", property="status"),
     *             @OA\Property(type="number", property="commission"),
     *             @OA\Property(type="string", property="bankName"),
     *             @OA\Property(type="string", property="bankAccountNumber"),
     *             @OA\Property(type="string", property="stcPay"),
     *              )
     *           )
     *        )
     *    )
     */
    public function getAllStoreOwners(): JsonResponse
    {
        $response = $this->storeOwnerProfileService->getAllStoreOwners();

        return $this->response($response, self::FETCH);
    }

    /**
     * @Route("/storeownerbycategoryid/{storeCategoryId}", name="getStoreOwnerByCategoryId",methods={"GET"})
     * @param $storeCategoryId
     * @return JsonResponse
     */
    public function getStoreOwnerByCategoryId($storeCategoryId): JsonResponse
    {
        $response = $this->storeOwnerProfileService->getStoreOwnerByCategoryId($storeCategoryId);

        return $this->response($response, self::FETCH);
    }

    /**
     * admin: Get store Owner by storeCategoryId.
     * @Route("/storeownerbycategoryidforadmin/{storeCategoryId}", name="getStoreOwnerByCategoryIdForAdmin",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param $storeCategoryId
     * @return JsonResponse
     * *
     * @OA\Tag(name="Store Owner Profile")
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
     *      description="Returns Store By Category Id For Admin",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *          @OA\Items(
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="storeOwnerName"),
     *              @OA\Property(type="object", property="image",
     *                  @OA\Property(type="string", property="imageURL"),
     *                  @OA\Property(type="string", property="image"),
     *                  @OA\Property(type="string", property="baseURL"),
     *                  ),
     *             @OA\Property(type="string", property="phone"),
     *             @OA\Property(type="object", property="location"),
     *             @OA\Property(type="number", property="deliveryCost"),
     *             @OA\Property(type="boolean", property="privateOrders"),
     *             @OA\Property(type="boolean", property="hasProducts"),
     *             @OA\Property(type="integer", property="storeCategoryId"),
     *             @OA\Property(type="string", property="rating"),
     *             @OA\Property(type="object", property="closingTime"),
     *             @OA\Property(type="object", property="openingTime"),
     *             @OA\Property(type="string", property="status"),
     *              )
     *           )
     *        )
     *    )
     *
     * @Security(name="Bearer")
     */
    public function getStoreOwnerByCategoryIdForAdmin($storeCategoryId): JsonResponse
    {
        $response = $this->storeOwnerProfileService->getStoreOwnerByCategoryIdForAdmin($storeCategoryId);

        return $this->response($response, self::FETCH);
    }

    /**
     * Get store owner best.
     * @Route("/storeOwnerBest", name="GetStoreOwnerBest",methods={"GET"})
     * @return JsonResponse
     * *
     * @OA\Tag(name="Store Owner Profile")
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
     *      description="Returns Store Best",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *          @OA\Items(
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="storeOwnerName"),
     *              @OA\Property(type="object", property="image",
     *                  @OA\Property(type="string", property="imageURL"),
     *                  @OA\Property(type="string", property="image"),
     *                  @OA\Property(type="string", property="baseURL"),
     *                  ),
     *             @OA\Property(type="string", property="phone"),
     *             @OA\Property(type="object", property="location"),
     *             @OA\Property(type="number", property="deliveryCost"),
     *             @OA\Property(type="boolean", property="privateOrders"),
     *             @OA\Property(type="boolean", property="hasProducts"),
     *             @OA\Property(type="integer", property="storeCategoryId"),
     *             @OA\Property(type="string", property="rating"),
     *             @OA\Property(type="object", property="closingTime"),
     *             @OA\Property(type="object", property="openingTime"),
     *             @OA\Property(type="string", property="status"),
     *              )
     *           )
     *        )
     *    )
     *
     * @Security(name="Bearer")
     */
    public function getStoreOwnerBest(): JsonResponse
    {
        $response = $this->storeOwnerProfileService->getStoreOwnerBest();

        return $this->response($response, self::FETCH);
    }

    /**
     * admin: Get stores inactive.
     * @Route("/storesinactive", name="GetStoresInactive", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     * *
     * @OA\Tag(name="Store Owner Profile")
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
     *      description="Returns Stores Inactive",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *          @OA\Items(
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="storeOwnerName"),
     *              @OA\Property(type="string", property="image"),
     *              @OA\Property(type="string", property="imageURL"),
     *              @OA\Property(type="string", property="baseURL"),
     *             @OA\Property(type="string", property="phone"),
     *             @OA\Property(type="object", property="location"),
     *             @OA\Property(type="number", property="deliveryCost"),
     *             @OA\Property(type="boolean", property="privateOrders"),
     *             @OA\Property(type="boolean", property="hasProducts"),
     *             @OA\Property(type="integer", property="storeCategoryId"),
     *             @OA\Property(type="object", property="closingTime"),
     *             @OA\Property(type="object", property="openingTime"),
     *             @OA\Property(type="string", property="status"),
     *             @OA\Property(type="string", property="bankName"),
     *             @OA\Property(type="string", property="bankAccountNumber"),
     *             @OA\Property(type="string", property="stcPay"),
     *              ),
     *           )
     *        )
     *    )
     *
     * @Security(name="Bearer")
     */
    public function getStoreOwnerInactive(): JsonResponse
    {
        $response = $this->storeOwnerProfileService->getStoreOwnerInactive();

        return $this->response($response, self::FETCH);
    }

    /**
     * @Route("/storesinactivefilter/{name}", name="GetStoresInactiveFilterByName", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     */
    public function getStoreOwnerInactiveFilterByName($name): JsonResponse
    {
        $response = $this->storeOwnerProfileService->getStoreOwnerInactiveFilterByName($name);

        return $this->response($response, self::FETCH);
    }

     /**
     * admin: Create Store Owner Profile By Admin.
     * @Route("/storeownercreatbyadmin", name="CreateStoreOwnerProfileByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
      * *
      * @OA\Tag(name="Store Owner Profile")
      *
      * @OA\Parameter(
      *      name="token",
      *      in="header",
      *      description="token to be passed as a header",
      *      required=true
      * )
      *
      * @OA\RequestBody(
      *      description="Update Store Owner Profile",
      *      @OA\JsonContent(
      *          @OA\Property(type="string", property="storeOwnerName"),
      *          @OA\Property(type="string", property="image"),
      *          @OA\Property(type="string", property="phone"),
      *          @OA\Property(type="integer", property="storeCategoryId"),
      *          @OA\Property(type="boolean", property="privateOrders"),
      *          @OA\Property(type="boolean", property="hasProducts"),
      *          @OA\Property(type="string", property="branchName"),
      *          @OA\Property(type="string", property="openingTime"),
      *          @OA\Property(type="string", property="closingTime"),
      *          @OA\Property(type="string", property="bankName"),
      *          @OA\Property(type="string", property="bankAccountNumber"),
      *          @OA\Property(type="string", property="stcPay"),
      *          @OA\Property(type="object", property="location",
      *              @OA\Property(type="string", property="lat"),
      *              @OA\Property(type="string", property="lon")
      *
      *          )
      *      )
      * )
      *
      * @OA\Response(
      *      response=204,
      *      description="Returns the store owner's profile",
      *      @OA\JsonContent(
      *          @OA\Property(type="string", property="status_code"),
      *          @OA\Property(type="string", property="msg"),
      *          @OA\Property(type="object", property="Data",
      *              @OA\Property(type="string", property="storeOwnerName"),
      *              @OA\Property(type="string", property="image"),
      *              @OA\Property(type="string", property="phone"),
      *              @OA\Property(type="integer", property="storeCategoryId"),
      *              @OA\Property(type="boolean", property="privateOrders"),
      *              @OA\Property(type="boolean", property="hasProducts"),
      *              @OA\Property(type="string", property="branchName"),
      *              @OA\Property(type="string", property="openingTime"),
      *              @OA\Property(type="string", property="closingTime"),
      *              @OA\Property(type="object", property="location",
      *                   @OA\Property(type="string", property="lat"),
      *                   @OA\Property(type="string", property="lon")
      *
      *          )
      *      )
      *   )
      * )
      *
      * @Security(name="Bearer")
      */
    public function createStoreOwnerProfileByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StoreOwnerProfileCreateByAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->storeOwnerProfileService->createStoreOwnerProfileByAdmin($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * admin: filter stores by name.
     * @Route("/storeFilter/{name}", name="getStoresByName", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     * *
     * @OA\Tag(name="Store Owner Profile")
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
     *      description="Returns Store By Name",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *          @OA\Items(
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="storeOwnerName"),
     *              @OA\Property(type="string", property="storeOwnerID"),
     *              @OA\Property(type="object", property="image",
     *                  @OA\Property(type="string", property="imageURL"),
     *                  @OA\Property(type="string", property="image"),
     *                  @OA\Property(type="string", property="baseURL"),
     *                  ),
     *             @OA\Property(type="string", property="status"),
     *             @OA\Property(type="string", property="storeCategoryId"),
     *             @OA\Property(type="string", property="phone"),
     *             @OA\Property(type="boolean", property="is_best"),
     *             @OA\Property(type="boolean", property="privateOrders"),
     *             @OA\Property(type="boolean", property="hasProducts"),
     *              )
     *           )
     *        )
     *    )
     *
     * @Security(name="Bearer")
     */
    public function getStoresFilterByName($name): JsonResponse
    {
        $result = $this->storeOwnerProfileService->getStoresFilterByName($name);

        return $this->response($result, self::FETCH);
    }

    /**
     * store: my financial account.
     * @Route("/storefinancialaccountforstore", name="storeFinancialAccountForStore",methods={"GET"})
     * @IsGranted("ROLE_OWNER")
     * @return JsonResponse
     * @OA\Tag(name="Store Owner Profile")
     * *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns Store Financial Account For Store",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="number", property="amountOwedToStore"),
     *              @OA\Property(type="number", property="sumPaymentsToStore"),
     *              @OA\Property(type="number", property="total"),
     *              @OA\Property(type="array", property="paymentsToStore",
     *                  @OA\items(
     *                   @OA\Property(type="integer", property="id"),
     *                   @OA\Property(type="integer", property="storeOwnerProfileID"),
     *                   @OA\Property(type="integer", property="amount"),
     *                   @OA\Property(type="object", property="date"),
     *                   @OA\Property(type="string", property="note")
     *              )
     *          )
     *      )
     *   )
     * )
     * @Security(name="Bearer")
     */
    public function storeFinancialAccountForStore(): JsonResponse
    {
        $response = $this->storeOwnerProfileService->storeFinancialAccountForStore($this->getUserId());

        return $this->response($response, self::FETCH);
    }

    /**
     * store: my financial account in specific date .
     * @Route("/storefinancialaccountforstoreinspecificdate/{fromDate}/{toDate}", name="storeFinancialAccountForStoreInSpecificDate",methods={"GET"})
     * @IsGranted("ROLE_OWNER")
     * @return JsonResponse
     * *
     * @OA\Tag(name="Store Owner Profile")
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
     *      description="Returns Store Financial Account For Store",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="number", property="amountOwedToStore"),
     *              @OA\Property(type="number", property="sumPaymentsToStore"),
     *              @OA\Property(type="number", property="total"),
     *              @OA\Property(type="array", property="paymentsToStore",
     *                  @OA\items(
     *                   @OA\Property(type="integer", property="id"),
     *                   @OA\Property(type="integer", property="storeOwnerProfileID"),
     *                   @OA\Property(type="integer", property="amount"),
     *                   @OA\Property(type="object", property="date"),
     *                   @OA\Property(type="string", property="note")
     *              )
     *          )
     *      )
     *   )
     * )
     * @Security(name="Bearer")
     */
    public function storeFinancialAccountForStoreInSpecificDate($fromDate, $toDate): JsonResponse
    {
        $response = $this->storeOwnerProfileService->storeFinancialAccountForStoreInSpecificDate($this->getUserId(), $fromDate, $toDate);

        return $this->response($response, self::FETCH);
    }

    /**
     * admin: store's financial account.
     * @Route("/storefinancialaccountforadmin/{storeOwnerProfileID}", name="storeFinancialAccountForAdmin",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     * *
     * @OA\Tag(name="Store Owner Profile")
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
     *      description="Returns Store Financial Account For Store",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="number", property="amountOwedToStore"),
     *              @OA\Property(type="number", property="sumPaymentsToStore"),
     *              @OA\Property(type="number", property="total"),
     *              @OA\Property(type="array", property="paymentsToStore",
     *                  @OA\items(
     *                   @OA\Property(type="integer", property="id"),
     *                   @OA\Property(type="integer", property="storeOwnerProfileID"),
     *                   @OA\Property(type="number", property="amount"),
     *                   @OA\Property(type="object", property="date"),
     *                   @OA\Property(type="string", property="note")
     *              )
     *          )
     *      )
     *   )
     * )
     * @Security(name="Bearer")
     */
    public function storeFinancialAccountForAdmin($storeOwnerProfileID): JsonResponse
    {
        $response = $this->storeOwnerProfileService->storeFinancialAccountForAdmin($storeOwnerProfileID);

        return $this->response($response, self::FETCH);
    }

    /**
     * representative: get all linked stores profiles
     * @Route("linkedstoresprofiles", name="getLinkedStoresProfilesBySignedInRepresentative", methods={"GET"})
     * @IsGranted("ROLE_MANDOB")
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Owner Profile")
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
     *      description="Returns all stores profiles which linked with signed-in representative",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="storeOwnerName"),
     *                  @OA\Property(type="object", property="image",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL"),
     *                  ),
     *                  @OA\Property(type="string", property="status"),
     *                  @OA\Property(type="string", property="phone"),
     *                  @OA\Property(type="string", property="free"),
     *                  @OA\Property(type="boolean", property="is_best"),
     *                  @OA\Property(type="string", property="commission"),
     *              )
     *          )
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getStoreOwnersByRepresentativeID(): JsonResponse
    {
        $response = $this->storeOwnerProfileService->getStoreOwnersByRepresentativeID($this->getUserId());

        return $this->response($response, self::FETCH);
    }

    /**
     * admin: get all linked stores profiles with representative by representative user id
     * @Route("linkedstoresprofilesforadmin/{mandobID}", name="getLinkedStoresProfilesByRepresentativeIdForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Owner Profile")
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
     *      description="Returns all stores profiles which linked with representative",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="storeOwnerName"),
     *                  @OA\Property(type="object", property="image",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL"),
     *                  ),
     *                  @OA\Property(type="string", property="status"),
     *                  @OA\Property(type="string", property="phone"),
     *                  @OA\Property(type="string", property="free"),
     *                  @OA\Property(type="boolean", property="is_best"),
     *                  @OA\Property(type="string", property="commission"),
     *              )
     *          )
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getStoreOwnersByRepresentativeIdForAdmin($mandobID): JsonResponse
    {
        $response = $this->storeOwnerProfileService->getStoreOwnersByRepresentativeIdForAdmin($mandobID);

        return $this->response($response, self::FETCH);
    }

    /**
     * admin: Delete store owner profile.
     * @Route("storeownerprofile/{id}", name="deleteStoreOwnerProfile", methods={"DELETE"})
     * @param Request $request
     * @return JsonResponse
     * @IsGranted("ROLE_ADMIN")
     * *
     * @OA\Tag(name="Store Owner Profile")
     *
     * @OA\Response(
     *      response=401,
     *      description="return store owner profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="string", property="storeOwnerName"),
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response=404,
     *      description="Returns Not found Successfully.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="string", property="Data"),
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns the store related to products.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9251"),
     *          @OA\Property(type="string", property="msg", description="error related Successfully."),
     *          @OA\Property(type="string", property="Data", description="related"),
     *      )
     * )
     */
    public function deleteStoreOwnerProfile(Request $request): JsonResponse
    {
        $request = new DeleteRequest($request->get('id'));

        $result = $this->storeOwnerProfileService->deleteStoreOwnerProfile($request);
        if ($result == "storeOwnerProfileNotFound"){
            return $this->response($result, self::NOTFOUND);
        }

        if ($result == "related"){
            return $this->response($result, self::ERROR_RELATED);
        }

        return $this->response($result, self::DELETE);
    }


    /**
     * store: store owner profile Is Completed.
     * @Route("storeownerprofileiscomplated", name="storeOwnerProfileIsCompleted", methods={"GET"})
     * @IsGranted("ROLE_OWNER")
     * @return JsonResponse
     * *
     * @OA\Tag(name="Store Owner Profile")
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
     *      description="store owner profile Is Completed",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="string", property="storeOwnerProfile"),
     *      )
     *   )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="store owner profile Is Not Completed",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9220"),
     *          @OA\Property(type="string", property="msg", description="profile is not completed! Successfully."),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="string", property="storeOwnerProfile", description="profile is not completed"),
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function storeOwnerProfileIsCompleted()
    {
        $response = $this->storeOwnerProfileService->storeOwnerProfileIsCompleted($this->getUserId());

        if ($response['storeOwnerProfile'] == "profile is not completed"){
            return $this->response($response, self::PROFILE_NOT_COMPLETED);

        }

        return $this->response($response, self::FETCH);
    }

}
