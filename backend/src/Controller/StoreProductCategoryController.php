<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\StoreProductCategoryCreateRequest;
use App\Request\StoreProductCategoryUpdateRequest;
use App\Service\StoreProductCategoryService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class StoreProductCategoryController extends BaseController
{
    private $autoMapping;
    private $storeProductCategoryService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, StoreProductCategoryService $storeProductCategoryService, ValidatorInterface $validator)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->storeProductCategoryService = $storeProductCategoryService;
    }
    
//    /**
//     * @Route("/StoreProductCategory", name="createStoreProductCategory", methods={"POST"})
//     * @IsGranted("ROLE_ADMIN")
//     * @param Request $request
//     * @return JsonResponse
//     */
//    public function createStoreProductCategory(Request $request)
//    {
//        $data = json_decode($request->getContent(), true);
//
//        $request = $this->autoMapping->map(stdClass::class, StoreProductCategoryCreateRequest::class, (object)$data);
//        $result = $this->storeProductCategoryService->createStoreProductCategory($request);
//
//        return $this->response($result, self::CREATE);
//    }
//
    /**
     * @Route("/StoreProductCategory", name="createStoreProductCategory", methods={"POST"})
     * @IsGranted("ROLE_OWNER")
     * @param Request $request
     * @return JsonResponse
     */
    public function createStoreProductCategory(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StoreProductCategoryCreateRequest::class, (object)$data);
        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }
        $request->setUserID($this->getUserId());
        $result = $this->storeProductCategoryService->createStoreProductCategory($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("/StoreProductCategory", name="updateStoreProductCategory", methods={"PUT"})
     * @IsGranted("ROLE_OWNER")
     * @param Request $request
     * @return JsonResponse
     */
     public function updateStoreProductCategory(Request $request)
     {
        $data = json_decode($request->getContent(), true);
        $violations = $this->validator->validate($request);
         if (\count($violations) > 0) {
             $violationsString = (string) $violations;

             return new JsonResponse($violationsString, Response::HTTP_OK);
         }
        $request = $this->autoMapping->map(stdClass::class, StoreProductCategoryUpdateRequest::class, (object)$data);
        $result = $this->storeProductCategoryService->updateStoreProductCategory($request);

        return $this->response($result, self::UPDATE);
     }
//
//    /**
//     * @Route("/storeProductCategory", name="updateStoreProductCategory", methods={"PUT"})
//     * @IsGranted("ROLE_ADMIN")
//     * @param Request $request
//     * @return JsonResponse
//     */
//     public function updateStoreProductCategory(Request $request)
//     {
//        $data = json_decode($request->getContent(), true);
//
//        $request = $this->autoMapping->map(stdClass::class, StoreProductCategoryUpdateRequest::class, (object)$data);
//        $result = $this->storeProductCategoryService->updateStoreProductCategory($request);
//
//        return $this->response($result, self::CREATE);
//     }

    /**
     * @Route("/storeProductsCategory/{storeOwnerProfileId}", name="getStoreProductsCategoryForStoreSpecific",methods={"GET"})
     * @return JsonResponse
     */
      public function getStoreProductsCategoryForStoreSpecific($storeOwnerProfileId)
      {
        $result = $this->storeProductCategoryService->getStoreProductsCategoryForStoreSpecific($storeOwnerProfileId);
  
        return $this->response($result, self::FETCH);
      }
}
