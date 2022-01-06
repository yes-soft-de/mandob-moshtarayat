<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\DeleteRequest;
use App\Request\FilterStoreProductCategoryLevelOne;
use App\Request\FilterStoreProductCategoryLevelTwo;
use App\Request\StoreProductCategoriesLevelOneAllGetRequest;
use App\Request\StoreProductCategoriesLevelTwoAllGetRequest;
use App\Request\StoreProductCategoryWithTranslationCreateRequest;
use App\Request\StoreProductCategoryWithTranslationUpdateRequest;
use App\Request\SubCategoriesWithLinkedMarkRequest;
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
    private $validator;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, StoreProductCategoryService $storeProductCategoryService, ValidatorInterface $validator)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->storeProductCategoryService = $storeProductCategoryService;
    }
    
    /**
     * admin: Create store product category first level.
     * @Route("/storeproductcategorylevelone", name="createStoreProductCategoryLevelOne", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Store Product Category")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Create Store Product Category Level One",
     *      @OA\JsonContent(
     *          @OA\Property(type="object", property="data",
     *              @OA\Property(type="string", property="productCategoryName"),
     *              @OA\Property(type="string", property="productCategoryImage"),
     *              @OA\Property(type="string", property="language"),
     *          ),
     *          @OA\Property(type="array", property="translate",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="productCategoryID"),
     *                  @OA\Property(type="string", property="productCategoryName"),
     *                  @OA\Property(type="string", property="language")
     *              )
     *          )
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns store ",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="productCategoryName"),
     *                  @OA\Property(type="string", property="productCategoryImage"),
     *                  @OA\Property(type="number", property="isLevel1"),
     *                  @OA\Property(type="string", property="storeCategoryID")
     *          )
     *      )
     * )
     * @Security(name="Bearer")
     */
    public function createStoreProductCategoryLevelOne(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(stdClass::class, StoreProductCategoryWithTranslationCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->storeProductCategoryService->createStoreProductCategoryLevelOne($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * admin: Create store product category second level.
     * @Route("/storeproductcategoryleveltwo", name="createStoreProductCategoryLevelTwo", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Store Product Category")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Create Store Product Category Level Two",
     *      @OA\JsonContent(
     *          @OA\Property(type="object", property="data",
     *              @OA\Property(type="string", property="productCategoryName"),
     *              @OA\Property(type="string", property="productCategoryImage"),
     *              @OA\Property(type="string", property="language"),
     *              @OA\Property(type="integer", property="storeProductCategoryID"),
     *          ),
     *          @OA\Property(type="array", property="translate",
     *              @OA\Items(
     *                  @OA\Property(type="string", property="productCategoryName"),
     *                  @OA\Property(type="string", property="language")
     *              )
     *          )
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns store ",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="productCategoryName"),
     *                  @OA\Property(type="string", property="productCategoryImage"),
     *                  @OA\Property(type="number", property="isLevel2"),
     *                  @OA\Property(type="integer", property="storeProductCategoryID"),
     *          )
     *      )
     * )
     * @Security(name="Bearer")
     */
    public function createStoreProductCategoryLevelTwo(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(stdClass::class, StoreProductCategoryWithTranslationCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->storeProductCategoryService->createStoreProductCategoryLevelTwo($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * admin: Update store product category first level.
     * @Route("/storeproductcategorylevelone", name="updateStoreProductCategoryLevelOne", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Store Product Category")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update Store Product Category Level One",
     *      @OA\JsonContent(
     *          @OA\Property(type="object", property="data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="productCategoryName"),
     *              @OA\Property(type="string", property="productCategoryImage"),
     *          ),
     *          @OA\Property(type="array", property="translate",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="productCategoryID"),
     *                  @OA\Property(type="string", property="productCategoryName"),
     *                  @OA\Property(type="string", property="language")
     *              )
     *          )
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns store ",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="productCategoryName"),
     *                  @OA\Property(type="string", property="productCategoryImage"),
     *                  @OA\Property(type="number", property="isLevel1"),
     *                  @OA\Property(type="string", property="storeCategoryID")
     *          )
     *      )
     * )
     * @Security(name="Bearer")
     */
     public function updateStoreProductCategoryLevelOne(Request $request)
     {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(stdClass::class, StoreProductCategoryWithTranslationUpdateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
         if (\count($violations) > 0) {
             $violationsString = (string) $violations;

             return new JsonResponse($violationsString, Response::HTTP_OK);
         }

        $result = $this->storeProductCategoryService->updateStoreProductCategoryLevelOne($request);

        return $this->response($result, self::UPDATE);
     }

    /**
     * admin: Update store product category second level.
     * @Route("/storeproductcategoryleveltwo", name="updateStoreProductCategoryLevelTwo", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Store Product Category")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update Store Product Category Level Two",
     *      @OA\JsonContent(
     *          @OA\Property(type="object", property="data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="productCategoryName"),
     *              @OA\Property(type="string", property="productCategoryImage"),
     *          ),
     *          @OA\Property(type="array", property="translate",
     *              @OA\Items(
     *                  @OA\Property(type="string", property="productCategoryName"),
     *                  @OA\Property(type="string", property="language"),
     *                  @OA\Property(type="integer", property="storeProductCategoryID")
     *              )
     *          )
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns store ",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="productCategoryName"),
     *                  @OA\Property(type="string", property="productCategoryImage"),
     *                  @OA\Property(type="number", property="isLevel2"),
     *                  @OA\Property(type="string", property="storeProductCategoryID")
     *          )
     *      )
     * )
     * @Security(name="Bearer")
     */
     public function updateStoreProductCategoryLevelTwo(Request $request)
     {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(stdClass::class, StoreProductCategoryWithTranslationUpdateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
         if (\count($violations) > 0) {
             $violationsString = (string) $violations;

             return new JsonResponse($violationsString, Response::HTTP_OK);
         }

        $result = $this->storeProductCategoryService->updateStoreProductCategoryLevelTwo($request);

        return $this->response($result, self::UPDATE);
     }

    /**
     * @Route("/storeProductsCategory/{storeOwnerProfileId}", name="getStoreProductsCategoryForStoreSpecific", methods={"GET"})
     * @return JsonResponse
     */
      public function getStoreProductsCategoryForStoreSpecific($storeOwnerProfileId)
      {
        $result = $this->storeProductCategoryService->getStoreProductsCategoryForStoreSpecific($storeOwnerProfileId);
  
        return $this->response($result, self::FETCH);
      }

      /**
     * @Route("storeproductforstorespecific/{storeOwnerProfileId}", name="getStoreProductsCategoryStoreSpecific", methods={"GET"})
     * @return JsonResponse
     */
      public function getStoreProductCategoryStoreSpecific($storeOwnerProfileId)
      {
        $result = $this->storeProductCategoryService->getStoreProductCategoryStoreSpecific($storeOwnerProfileId);

        return $this->response($result, self::FETCH);
      }

    /**
     * Get store products category of first level.
     * @Route("/storeproductscategorylevelone/{storeCategoryID}", name="getStoreProductsCategoryLevelOneByStoreCategoryID", methods={"GET"})
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Product Category")
     *
     * @OA\Parameter(
     *      name="Accept-Language",
     *      in="header",
     *      description="language to be passed as a header",
     *      required=false
     * )
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
      public function getStoreProductsCategoryLevelOneByStoreCategoryID(Request $request, $storeCategoryID)
      {
        $result = $this->storeProductCategoryService->getStoreProductsCategoryLevelOneByStoreCategoryID($request->getPreferredLanguage(), $storeCategoryID);

        return $this->response($result, self::FETCH);
      }

    /**
     * admin: Get store products category of first level
     * @Route("/storeproductscategorylevelonefroadmin", name="getStoreProductsCategoryLevelOneByStoreCategoryIDForAdmin", methods={"POST"})
     * @return JsonResponse
     * @IsGranted("ROLE_ADMIN")
     *
     * @OA\Tag(name="Store Product Category")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="filtering options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="language"),
     *          @OA\Property(type="integer", property="storeCategoryID")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns array of categories level one for admin ",
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
     * @Security(name="Bearer")
     */
      public function getStoreProductsCategoryLevelOneByStoreCategoryIDFroAdmin(Request $request)
      {
          $data = json_decode($request->getContent(), true);

          $request = $this->autoMapping->map(stdClass::class, FilterStoreProductCategoryLevelOne::class, (object)$data);

          $violations = $this->validator->validate($request);
          if (\count($violations) > 0) {
              $violationsString = (string) $violations;

              return new JsonResponse($violationsString, Response::HTTP_OK);
          }

          $result = $this->storeProductCategoryService->getStoreProductsCategoryLevelOneByStoreCategoryIDFroAdmin($request);

          return $this->response($result, self::FETCH);
      }

    /**
     *  Get store products category of second level.
     * @Route("/storeproductscategoryleveltwo/{storeProductCategoryID}", name="getStoreProductsCategoryLevelTwoByStoreProductCategoryID", methods={"GET"})
     * @return JsonResponse
     *  *
     * @OA\Tag(name="Store Product Category")
     *
     * @OA\Parameter(
     *      name="Accept-Language",
     *      in="header",
     *      description="language to be passed as a header",
     *      required=false
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns array of categories level two ",
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
      public function getStoreProductsCategoryLevelTwoByStoreProductCategoryID(Request $request, $storeProductCategoryID)
      {
          $result = $this->storeProductCategoryService->getStoreProductsCategoryLevelTwoByStoreProductCategoryID($request->getPreferredLanguage(), $storeProductCategoryID);

          return $this->response($result, self::FETCH);
      }

    /**
     *  admin: Get store products category of second level.
     * @Route("/storeproductscategoryleveltwoforadmin", name="getStoreProductsCategoryLevelTwoByStoreProductCategoryIDForAdmin", methods={"POST"})
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Product Category")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="filtering options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="language", description="optional"),
     *          @OA\Property(type="integer", property="storeProductCategoryID", description="required")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns array of categories level two for admin ",
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
     * @Security(name="Bearer")
     */
      public function getStoreProductsCategoryLevelTwoByStoreProductCategoryIDForAdmin(Request $request)
      {
          $data = json_decode($request->getContent(), true);

          $request = $this->autoMapping->map(stdClass::class, FilterStoreProductCategoryLevelTwo::class, (object)$data);

          $violations = $this->validator->validate($request);
          if (\count($violations) > 0) {
              $violationsString = (string) $violations;

              return new JsonResponse($violationsString, Response::HTTP_OK);
          }

          $result = $this->storeProductCategoryService->getStoreProductsCategoryLevelTwoByStoreProductCategoryIDForAdmin($request);

          return $this->response($result, self::FETCH);
      }

     /**
      * Get subCategories by storeCategoryID.
     * @Route("/subcategoriesbystorecategoryid/{storeCategoryID}", name="getSubCategoriesByStoreCategoryID",methods={"GET"})
     * @return JsonResponse
      * *
      * @OA\Tag(name="Store Product Category")
      *
      * @OA\Parameter(
      *      name="Accept-Language",
      *      in="header",
      *      description="language to be passed as a header",
      *      required=false
      * )
      *
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
      *                     )
      *                 )
      *             )
      *          )
      *      )
      * )
      */
      public function getSubCategoriesByStoreCategoryID(Request $request, $storeCategoryID)
      {
        $result = $this->storeProductCategoryService->getSubCategoriesByStoreCategoryID($request->getPreferredLanguage(), $storeCategoryID);

        return $this->response($result, self::FETCH);
      }

     /**
     * store: Get store products Category second level And store products by store owner profile.
     * @Route("/storeproductscategoryleveltwoandstoreproduct", name="getStoreProductsCategoryLevelTwoAndStoreProductsByStoreOWnerProfile", methods={"GET"})
     * @return JsonResponse
     * @IsGranted("ROLE_OWNER")
      * *
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
      *                  @OA\Property(type="string", property="description"),
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

     /**
     * @Route("/storeproductscategoriesandstoreproducts", name="getStoreProductsCategoriesAndStoreProductsByStoreOwnerProfile", methods={"GET"})
     * @return JsonResponse
     * @IsGranted("ROLE_OWNER")
      * @OA\Tag(name="Store Product Category")
      * *
      * @OA\Response(
      *      response=200,
      *      description="Returns categories level one and two and products of store owner ",
      *      @OA\JsonContent(
      *          @OA\Property(type="string", property="status_code"),
      *          @OA\Property(type="string", property="msg"),
      *          @OA\Property(type="array", property="Data",
      *              @OA\Items(
      *                @OA\Property(type="integer", property="id"),
      *                @OA\Property(type="string", property="productCategoryName"),
      *                @OA\Property(type="object", property="productCategoryImage",
      *                      @OA\Property(type="string", property="imageURL"),
      *                      @OA\Property(type="string", property="image"),
      *                      @OA\Property(type="string", property="baseURL"),
      *                  ),
      *                @OA\Property(type="string", property="isLevel1"),
      *                @OA\Property(type="array", property="productCategoriesLevel2",
      *                @OA\Items(
      *                  @OA\Property(type="integer", property="id"),
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
      *                  @OA\Property(type="string", property="description"),
      *                  @OA\Property(type="object", property="image",
      *                      @OA\Property(type="string", property="imageURL"),
      *                      @OA\Property(type="string", property="image"),
      *                      @OA\Property(type="string", property="baseURL"),
      *                     )
      *                  )
      *               )
      *             )
      *           )
      *         )
      *      )
      *    )
      * )
      *
      */
      public function getStoreProductsCategoriesAndProductsByStoreOwnerProfileID()
      {
        $result = $this->storeProductCategoryService->getStoreProductsCategoriesAndProductsByStoreOwnerProfileID($this->getUserId());

        return $this->response($result, self::FETCH);
      }

    /**
     * get active products by (first or second) subcategory.
     * @Route("storeproductscategoryleveltwowithproducts/{storeProductCategoryID}", name="getStoreProductsCategoryLevelTwoOrOneWithProductsByStoreProductCategoryID", methods={"GET"})
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Product Category")
     *
     * @OA\Parameter(
     *      name="Accept-Language",
     *      in="header",
     *      description="language to be passed as a header",
     *      required=false
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns products by store product category ID",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="productName"),
     *                  @OA\Property(type="number", property="productPrice"),
     *                  @OA\Property(type="integer", property="storeOwnerProfileID"),
     *                  @OA\Property(type="integer", property="storeProductCategoryID"),
     *                  @OA\Property(type="object", property="image",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL"),
     *                  ),
     *                  @OA\Property(type="string", property="discount"),
     *                  @OA\Property(type="string", property="description"),
     *                  @OA\Property(type="number", property="rate"),
     *                  @OA\Property(type="number", property="soldCount"),
     *                  @OA\Property(type="string", property="status"),
     *                  @OA\Property(type="object", property="store",
     *                      @OA\Property(type="integer", property="id"),
     *                      @OA\Property(type="string", property="storeOwnerName"),
     *                  ),
     *              )
     *          )
     *      )
     *  )
     *
     */
    public function getStoreProductsCategoryLevelTwoWithProductsByStoreProductCategoryID(Request $request, $storeProductCategoryID)
    {
        $result = $this->storeProductCategoryService->getStoreProductsCategoryLevelTwoWithProductsByStoreProductCategoryID($request->getPreferredLanguage(), $storeProductCategoryID);

        return $this->response($result, self::FETCH);
    }

    /**
     * Store: Get the products of the first subcategory
     * @Route("productsbystorecategroylevelone/{storeProductCategoryID}", name="getProductsByStoreCategroyLevelOne", methods={"GET"})
     * @return JsonResponse
     * @IsGranted("ROLE_OWNER")
     *
     * @OA\Tag(name="Store Product Category")
     *
     * @OA\Parameter(
     *      name="Accept-Language",
     *      in="header",
     *      description="language to be passed as a header",
     *      required=false
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Get the products of the first subcategory ",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="productName"),
     *                  @OA\Property(type="number", property="productPrice"),
     *                  @OA\Property(type="integer", property="productQuantity"),
     *                  @OA\Property(type="integer", property="storeProductCategoryID"),
     *                  @OA\Property(type="object", property="image",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL"),
     *                  ),
     *                  @OA\Property(type="integer", property="discount"),
     *                  @OA\Property(type="string", property="description"),
     *                  @OA\Property(type="string", property="rate"),
     *                  @OA\Property(type="string", property="soldCount"),
     *                  @OA\Property(type="string", property="status"),
     *                  @OA\Property(type="boolean", property="isLevel1"),
     *                  @OA\Property(type="boolean", property="isLevel2"),
     *              )
     *          )
     *      )
     *  )
     *
     */
    public function getProductsByStoreCategroyLevelOne(Request $request, $storeProductCategoryID)
    {
        $result = $this->storeProductCategoryService->getProductsByStoreCategroyLevelOne($request->getPreferredLanguage(), $storeProductCategoryID, $this->getUserId());

        return $this->response($result, self::FETCH);
    }

    /**
     * Dashboard: Get the products by the first-level subcategory ID and by store owner profile ID
     * @Route("productsbystorecategroylevelone/{storeProductCategoryID}/{storeOwnerProfileID}", name="getProductsByStoreCategroyLevelOneAndStoreOwnerProfileID", methods={"GET"})
     * @param Request $request
     * @param $storeProductCategoryID
     * @param $storeOwnerProfileID
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Product Category")
     *
     * @OA\Parameter(
     *      name="Accept-Language",
     *      in="header",
     *      description="language to be passed as a header",
     *      required=false
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Get the products of the first subcategory ",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="productName"),
     *                  @OA\Property(type="number", property="productPrice"),
     *                  @OA\Property(type="integer", property="productQuantity"),
     *                  @OA\Property(type="integer", property="storeProductCategoryID"),
     *                  @OA\Property(type="object", property="image",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL"),
     *                  ),
     *                  @OA\Property(type="integer", property="discount"),
     *                  @OA\Property(type="string", property="description"),
     *                  @OA\Property(type="string", property="rate"),
     *                  @OA\Property(type="string", property="soldCount"),
     *                  @OA\Property(type="string", property="status"),
     *                  @OA\Property(type="number", property="commission"),
     *                  @OA\Property(type="boolean", property="isCommission")
     *              )
     *          )
     *      )
     *  )
     */
    public function getProductsByStoreCategroyLevelOneAndStoreOwnerProfileID(Request $request, $storeProductCategoryID, $storeOwnerProfileID)
    {
        $result = $this->storeProductCategoryService->getProductsByStoreCategroyLevelOneIdAndStoreOwnerProfileID($request->getPreferredLanguage(), $storeProductCategoryID, $storeOwnerProfileID);

        return $this->response($result, self::FETCH);
    }

    /**
     * Admin: Get all product categories of level one for dashboard
     * @Route("allproductcategorieslevelone", name="getAllStoreProductCategoriesLevelOne", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Product Category")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Get subCategories of level one by specific language",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="language")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Get all Store Product Categories Level one",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *                  @OA\Items(
     *                     @OA\Property(type="integer", property="id"),
     *                     @OA\Property(type="string", property="productCategoryName"),
     *                     @OA\Property(type="object", property="productCategoryImage",
     *                          @OA\Property(type="object", property="image"),
     *                          @OA\Property(type="string", property="imageURL"),
     *                          @OA\Property(type="string", property="baseURL"),
     *                  )
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getAllStoreProductCategoriesLevelOne(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StoreProductCategoriesLevelOneAllGetRequest::class, (object)$data);

        $result = $this->storeProductCategoryService->getAllStoreProductCategoriesLevelOne($request);

        return $this->response($result, self::FETCH);
    }

    /**
     * Admin: Get all product categories of level two for dashboard
     * @Route("allproductcategoriesleveltwo", name="getAllStoreProductCategoriesLevelTwo", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Product Category")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Get subCategories of level two by specific language",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="language")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Get all Store Product Categories Level Two",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *                  @OA\Items(
     *                     @OA\Property(type="integer", property="id"),
     *                     @OA\Property(type="string", property="productCategoryName"),
     *                     @OA\Property(type="object", property="productCategoryImage",
     *                          @OA\Property(type="object", property="image"),
     *                          @OA\Property(type="string", property="imageURL"),
     *                          @OA\Property(type="string", property="baseURL"),
     *                  )
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getAllStoreProductCategoriesLevelTwo(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StoreProductCategoriesLevelTwoAllGetRequest::class, (object)$data);

        $result = $this->storeProductCategoryService->getAllStoreProductCategoriesLevelTwo($request);

        return $this->response($result, self::FETCH);
    }

    /**
     * Delete store product category.
     * @Route("storeproductcategory/{id}", name="deleteStoreProductCategoryByID", methods={"DELETE"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Product Category")
     *
     * @OA\Response(
     *      response=200,
     *      description="Delete store product category",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="productCategoryName"),
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response=401,
     *      description="Returns string",
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
     *      description="Returns the category related to category Or product",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9251"),
     *          @OA\Property(type="string", property="msg", description="error related Successfully."),
     *          @OA\Property(type="string", property="Data", description="related"),
     *      )
     * )
     */
    public function deleteStoreProductCategoryByID(Request $request): JsonResponse
    {
        $request = new DeleteRequest($request->get('id'));

        $result = $this->storeProductCategoryService->deleteStoreProductCategoryByID($request);
        if ($result == "storeProductCategoryNotFound"){
            return $this->response($result, self::NOTFOUND);
        }

        if ($result == "related"){
            return $this->response($result, self::ERROR_RELATED);
        }

        return $this->response($result, self::DELETE);
    }

    /**
     * Get subCategories of level one with mark (linked or not) with specific store product category level two
     * @Route("allsubcategorieslevelone", name="getStoreProductCategoryLevelOne", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Product Category")
     *
     * @OA\RequestBody(
     *      description="Get subCategories of level one with mark (linked or not) with specific store product category level two",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="language"),
     *          @OA\Property(type="integer", property="storeProductCategoryLevelTwoID")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Get Store Categories",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *                  @OA\Items(
     *                     @OA\Property(type="integer", property="id"),
     *                     @OA\Property(type="string", property="productCategoryName"),
     *                     @OA\Property(type="object", property="productCategoryImage",
     *                          @OA\Property(type="object", property="image"),
     *                          @OA\Property(type="string", property="imageURL"),
     *                          @OA\Property(type="string", property="baseURL"),
     *                  ),
     *                  @OA\Property(type="boolean", property="linked"),
     *              )
     *          )
     *      )
     * )
     */
    public function getStoreProductCategoryLevelOne(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, SubCategoriesWithLinkedMarkRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if(\count($violations) > 0)
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->storeProductCategoryService->getStoreProductCategoryLevelOne($request);

        return $this->response($result, self::FETCH);
    }

}
