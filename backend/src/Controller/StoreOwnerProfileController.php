<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\StoreOwnerProfileCreateRequest;
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
     * @Route("/storeownerregister", name="storeOwnerRegister", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function storeOwnerRegister(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);
        
        $request = $this->autoMapping->map(stdClass::class, UserRegisterRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->storeOwnerProfileService->storeOwnerRegister($request);
        $isArray = is_array($response);
        if($isArray){
            $found = isset($response['found']);
        
            if( $found == "yes"){
                return $this->response($response, self::ERROR); 
          }
        }
        return $this->response($response, self::CREATE);
    }

    /**
     * @Route("/storeowner", name="CreateStoreOwnerProfile", methods={"POST"})
     * @IsGranted("ROLE_OWNER")
     * @param Request $request
     * @return JsonResponse
     */
    public function createStoreOwnerProfile(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StoreOwnerProfileCreateRequest::class, (object)$data);

        $request->setStoreOwnerID($this->getUserId());

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->storeOwnerProfileService->createStoreOwnerProfile($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * @Route("/storeowner", name="UpdateStoreOwnerProfile", methods={"PUT"})
     * @IsGranted("ROLE_OWNER")
     * @param Request $request
     * @return JsonResponse
     */
    public function updateStoreOwnerProfile(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StoreOwnerProfileUpdateRequest::class, (object)$data);
        $request->setUserID($this->getUserId());

        $response = $this->storeOwnerProfileService->updateStoreOwnerProfile($request);

        return $this->response($response, self::UPDATE);
    }

    /**
     * @Route("/storeownerprofileupdatebyadmin", name="storeOwnerProfileUpdateByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function updateStoreOwnerByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StoreOwnerUpdateByAdminRequest::class, (object)$data);

        $response = $this->storeOwnerProfileService->updateStoreOwnerByAdmin($request);

        return $this->response($response, self::UPDATE);
    }

    /**
     * @Route("/storeownerprofilebyid/{id}", name="getStoreOwnerProfileByID",methods={"GET"})
     * @param $id
     * @return JsonResponse
     */
    public function getStoreOwnerProfileByID($id): JsonResponse
    {
        $response = $this->storeOwnerProfileService->getStoreOwnerProfileByID($id);

        return $this->response($response, self::FETCH);
    }

    /**
     * @Route("/storeOwners", name="getAllStoreOwners",methods={"GET"})
     * @return JsonResponse
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
     * @Route("/storeownerbycategoryidforadmin/{storeCategoryId}", name="getStoreOwnerByCategoryIdForAdmin",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param $storeCategoryId
     * @return JsonResponse
     */
    public function getStoreOwnerByCategoryIdForAdmin($storeCategoryId): JsonResponse
    {
        $response = $this->storeOwnerProfileService->getStoreOwnerByCategoryIdForAdmin($storeCategoryId);

        return $this->response($response, self::FETCH);
    }

    /**
     * @Route("/storeOwnerBest", name="GetStoreOwnerBest",methods={"GET"})
     * @return JsonResponse
     */
    public function getStoreOwnerBest(): JsonResponse
    {
        $response = $this->storeOwnerProfileService->getStoreOwnerBest();

        return $this->response($response, self::FETCH);
    }

    /**
     * @Route("/storesinactive", name="GetStoresInactive", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
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
     * @Route("/storeownercreatbyadmin", name="CreateStoreOwnerProfileByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
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
     * @Route("/storeFilter/{name}", name="getStoresByName", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     */
    public function getStoresByName($name): JsonResponse
    {
        $result = $this->storeOwnerProfileService->getStoresByName($name);

        return $this->response($result, self::FETCH);
    }
}
