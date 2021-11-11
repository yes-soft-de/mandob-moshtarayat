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
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;
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
     * *  * *
     * @OA\Tag(name="Store Product Category")
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns array of categories level one ",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="productCategoryName"),
     *                  @OA\Property(type="object", property="productCategoryImage",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL"),
     *                  ),
     *              )
     *          )
     *      )
     * )
     *
     */
      public function getStoreProductsCategoryLevelOneByStoreCategoryID($storeCategoryID)
      {
        $result = $this->storeProductCategoryService->getStoreProductsCategoryLevelOneByStoreCategoryID($storeCategoryID);

        return $this->response($result, self::FETCH);
      }

    /**
     * @Route("/storeproductscategoryleveltwo/{storeProductCategoryID}", name="getStoreProductsCategoryLevelTwoByStoreProductCategoryID",methods={"GET"})
     * @return JsonResponse
     *  * *
     * @OA\Tag(name="Store Product Category")
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns array of categories level one ",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="productCategoryName"),
     *                  @OA\Property(type="object", property="image",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL"),
     *                  ),
     *              )
     *          )
     *      )
     * )
     *
     */
      public function getStoreProductsCategoryLevelTwoByStoreProductCategoryID($storeProductCategoryID)
      {
        $result = $this->storeProductCategoryService->getStoreProductsCategoryLevelTwoByStoreProductCategoryID($storeProductCategoryID);

        return $this->response($result, self::FETCH);
      }

     /**
     * @Route("/subcategoriesbystorecategoryid/{storeCategoryID}", name="getSubCategoriesByStoreCategoryID",methods={"GET"})
     * @return JsonResponse
      * @OA\Tag(name="Store Product Category")
      * @OA\Response(
      *      response=200,
      *      description="Returns SubCategories",
      *      @OA\JsonContent(
      *          @OA\Property(type="string", property="status_code"),
      *          @OA\Property(type="string", property="msg"),
      *          @OA\Property(type="array", property="Data",
      *              @OA\Items(
      *                  @OA\Property(type="string", property="productCategoryName"),
      *                  @OA\Property(type="object", property="productCategoryImage",
      *                      @OA\Property(type="string", property="imageURL"),
      *                      @OA\Property(type="string", property="image"),
      *                      @OA\Property(type="string", property="baseURL"),
      *                  ),
      *
      *              @OA\Property(type="array", property="productCategoriesLevel2",
      *              @OA\Items(
      *                 @OA\Property(type="integer", property="id"),
      *                 @OA\Property(type="string", property="productCategoryName"),
      *                 @OA\Property(type="boolean", property="isLevel2"),
      *                 @OA\Property(type="string", property="productCategoryImage"),
      *             ))
      * )
      *          )
      *      )
      * )
      */
      public function getSubCategoriesByStoreCategoryID($storeCategoryID)
      {
        $result = $this->storeProductCategoryService->getSubCategoriesByStoreCategoryID($storeCategoryID);

        return $this->response($result, self::FETCH);
      }

     /**
     * @Route("/storeproductscategoryleveltwoandstoreproduct", name="getStoreProductsCategoryLevelTwoAndStoreProductsByStoreOWnerProfile",methods={"GET"})
     * @return JsonResponse
      *@IsGranted("ROLE_OWNER")
      * @OA\Tag(name="Store Product Category")
      *
      * @OA\Response(
      *      response=200,
      *      description="Returns categories level two and products of store owner ",
      *      @OA\JsonContent(
      *          @OA\Property(type="string", property="status_code"),
      *          @OA\Property(type="string", property="msg"),
      *          @OA\Property(type="array", property="Data",
      *              @OA\Items(
      *                  @OA\Property(type="integer", property="id"),
      *                  @OA\Property(type="boolean", property="isLevel2"),
      *                  @OA\Property(type="string", property="productCategoryName"),
      *                  @OA\Property(type="object", property="productCategoryImage",
      *                      @OA\Property(type="string", property="imageURL"),
      *                      @OA\Property(type="string", property="image"),
      *                      @OA\Property(type="string", property="baseURL"),
      *                  ),
      *          @OA\Property(type="array", property="products",
      *              @OA\Items(
      *                  @OA\Property(type="integer", property="id"),
      *                  @OA\Property(type="string", property="productName"),
      *                  @OA\Property(type="number", property="productPrice"),
      *                  @OA\Property(type="integer", property="storeOwnerProfileID"),
      *                  @OA\Property(type="integer", property="storeProductCategoryID"),
      *                  @OA\Property(type="integer", property="discount"),
      *                  @OA\Property(type="object", property="image",
      *                      @OA\Property(type="string", property="imageURL"),
      *                      @OA\Property(type="string", property="image"),
      *                      @OA\Property(type="string", property="baseURL"),
      *                  )
      *               )
      *             )
      *           )
      *         )
      *      )
      * )
      *
      */
      public function getStoreProductsCategoryLevelTwoAndStoreProductsByStoreOWnerProfile()
      {
        $result = $this->storeProductCategoryService->getStoreProductsCategoryLevelTwoAndStoreProductsByStoreOwnerProfile($this->getUserId());

        return $this->response($result, self::FETCH);
      }
}
