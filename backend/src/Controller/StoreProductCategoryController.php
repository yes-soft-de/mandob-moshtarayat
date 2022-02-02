<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\StoreProductCategoryCreateRequest;
use App\Request\StoreProductCategoryUpdateRequest;
use App\Service\StoreProductCategoryService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;

class StoreProductCategoryController extends BaseController
{
    private $autoMapping;
    private $storeProductCategoryService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, StoreProductCategoryService $storeProductCategoryService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->storeProductCategoryService = $storeProductCategoryService;
    }
    
    /**
     * @Route("/StoreProductCategory", name="createStoreProductCategory", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function createStoreProductCategory(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StoreProductCategoryCreateRequest::class, (object)$data);
        $result = $this->storeProductCategoryService->createStoreProductCategory($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("/storeProductCategory", name="updateStoreProductCategory", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
     public function updateStoreProductCategory(Request $request)
     {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StoreProductCategoryUpdateRequest::class, (object)$data);
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
}
