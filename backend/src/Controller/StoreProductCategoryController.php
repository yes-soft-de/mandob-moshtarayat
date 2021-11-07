<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\StoreProductCategoryCreateRequest;
use App\Request\StoreProductCategoryLevelTwoCreateRequest;
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
    
    /**
     * @Route("/storeproductcategorylevelone", name="createStoreProductCategoryLevelOne", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function createStoreProductCategoryLevelOne(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(stdClass::class, StoreProductCategoryCreateRequest::class, (object)$data);
        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }
        $result = $this->storeProductCategoryService->createStoreProductCategoryLevelOne($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("/storeproductcategoryleveltwo", name="createStoreProductCategoryLevelTwo", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function createStoreProductCategoryLevelTwo(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(stdClass::class, StoreProductCategoryLevelTwoCreateRequest::class, (object)$data);
        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }
        $result = $this->storeProductCategoryService->createStoreProductCategoryLevelTwo($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("/storeproductcategory", name="updateStoreProductCategory", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
     public function updateStoreProductCategory(Request $request)
     {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(stdClass::class, StoreProductCategoryUpdateRequest::class, (object)$data);
        $violations = $this->validator->validate($request);
         if (\count($violations) > 0) {
             $violationsString = (string) $violations;

             return new JsonResponse($violationsString, Response::HTTP_OK);
         }
        $result = $this->storeProductCategoryService->updateStoreProductCategory($request);

        return $this->response($result, self::CREATE);
     }

    /**
     * @Route("/storeProductsCategory/{storeOwnerProfileId}", name="getStoreProductsCategoryForStoreSpecific",methods={"GET"})
     * @return JsonResponse
     */
      public function getStoreProductsCategoryForStoreSpecific($storeOwnerProfileId)
      {
        $result = $this->storeProductCategoryService->getStoreProductsCategoryForStoreSpecific($storeOwnerProfileId);
  
        return $this->response($result, self::FETCH);
      }

    /**
     * @Route("/storeproductscategorylevelone/{storeCategoryID}", name="getStoreProductsCategoryLevelOneByStoreCategoryID",methods={"GET"})
     * @return JsonResponse
     */
      public function getStoreProductsCategoryLevelOneByStoreCategoryID($storeCategoryID)
      {
        $result = $this->storeProductCategoryService->getStoreProductsCategoryLevelOneByStoreCategoryID($storeCategoryID);

        return $this->response($result, self::FETCH);
      }

    /**
     * @Route("/storeproductscategoryleveltwo/{storeProductCategoryID}", name="getStoreProductsCategoryLevelTwoByStoreProductCategoryID",methods={"GET"})
     * @return JsonResponse
     */
      public function getStoreProductsCategoryLevelTwoByStoreProductCategoryID($storeProductCategoryID)
      {
        $result = $this->storeProductCategoryService->getStoreProductsCategoryLevelTwoByStoreProductCategoryID($storeProductCategoryID);

        return $this->response($result, self::FETCH);
      }
}
