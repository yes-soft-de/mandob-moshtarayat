<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\StoreCategoryCreateRequest;
use App\Request\StoreCategoryUpdateRequest;
use App\Service\StoreCategoryService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;

class StoreCategoryController extends BaseController
{
    private $autoMapping;
    private $storeCategoryService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, StoreCategoryService $storeCategoryService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->storeCategoryService = $storeCategoryService;
    }
    
    /**
     * @Route("/createstorecategory", name="createStoreCategory", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function createStoreCategory(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StoreCategoryCreateRequest::class, (object)$data);
        $result = $this->storeCategoryService->createStoreCategory($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("/updateStorecategory", name="updateStoreCategory", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function updateStoreCategory(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StoreCategoryUpdateRequest::class, (object)$data);
        $result = $this->storeCategoryService->updateStoreCategory($request);

        if(is_string($result)){
            return $this->response($result, self::ERROR);  
          }
          
        return $this->response($result, self::CREATE);
    }

    /**
      * @Route("/storecategories", name="getStoreCategories", methods={"GET"})
      * @return JsonResponse
      */
      public function getStoreCategories(): JsonResponse
      {
          $result = $this->storeCategoryService->getStoreCategories();
  
          return $this->response($result, self::FETCH);
      }

    /**
      * @Route("/storecategory/{id}", name="getStoreCategory", methods={"GET"})
      * @param Request $request
      * @return JsonResponse
      */
      public function getStoreCategory($id)
      {
          $result = $this->storeCategoryService->getStoreCategory($id);
  
          return $this->response($result, self::FETCH);
      }
}
