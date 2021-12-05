<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\DeleteRequest;
use App\Request\StoreProductCategoryCreateRequest;
use App\Request\StoreProductCategoryLevelOneUpdateRequest;
use App\Request\StoreProductCategoryLevelTwoCreateRequest;
use App\Request\StoreProductCategoryLevelTwoUpdateRequest;
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
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="productCategoryName"),
     *          @OA\Property(type="string", property="productCategoryImage"),
     *          @OA\Property(type="integer", property="storeCategoryID"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
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
     *          @OA\Property(type="string", property="productCategoryName"),
     *          @OA\Property(type="string", property="productCategoryImage"),
     *          @OA\Property(type="integer", property="storeProductCategoryID"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
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
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="productCategoryName"),
     *          @OA\Property(type="string", property="productCategoryImage"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
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
        $request = $this->autoMapping->map(stdClass::class, StoreProductCategoryLevelOneUpdateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
         if (\count($violations) > 0) {
             $violationsString = (string) $violations;

             return new JsonResponse($violationsString, Response::HTTP_OK);
         }

        $result = $this->storeProductCategoryService->updateStoreProductCategoryLevelOne($request);

        return $this->response($result, self::UPDATE);
     }

    /**
     * * admin: Update store product category second level.
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
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="productCategoryName"),
     *          @OA\Property(type="string", property="productCategoryImage")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
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
        $request = $this->autoMapping->map(stdClass::class, StoreProductCategoryLevelTwoUpdateRequest::class, (object)$data);

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
     * *
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
     * admin: Get store products category of first level
     * @Route("/storeproductscategorylevelonefroadmin/{storeCategoryID}", name="getStoreProductsCategoryLevelOneByStoreCategoryIDForAdmin", methods={"GET"})
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
      public function getStoreProductsCategoryLevelOneByStoreCategoryIDFroAdmin($storeCategoryID)
      {
        $result = $this->storeProductCategoryService->getStoreProductsCategoryLevelOneByStoreCategoryIDFroAdmin($storeCategoryID);

        return $this->response($result, self::FETCH);
      }

    /**
     *  Get store products category of second level.
     * @Route("/storeproductscategoryleveltwo/{storeProductCategoryID}", name="getStoreProductsCategoryLevelTwoByStoreProductCategoryID", methods={"GET"})
     * @return JsonResponse
     *  *
     * @OA\Tag(name="Store Product Category")
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
      public function getStoreProductsCategoryLevelTwoByStoreProductCategoryID($storeProductCategoryID)
      {
        $result = $this->storeProductCategoryService->getStoreProductsCategoryLevelTwoByStoreProductCategoryID($storeProductCategoryID);

        return $this->response($result, self::FETCH);
      }

    /**
     *  admin: Get store products category of second level.
     * @Route("/storeproductscategoryleveltwoforadmin/{storeProductCategoryID}", name="getStoreProductsCategoryLevelTwoByStoreProductCategoryIDForAdmin", methods={"GET"})
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
      public function getStoreProductsCategoryLevelTwoByStoreProductCategoryIDForAdmin($storeProductCategoryID)
      {
        $result = $this->storeProductCategoryService->getStoreProductsCategoryLevelTwoByStoreProductCategoryIDForAdmin($storeProductCategoryID);

        return $this->response($result, self::FETCH);
      }

     /**
      * Get subCategories by storeCategoryID.
     * @Route("/subcategoriesbystorecategoryid/{storeCategoryID}", name="getSubCategoriesByStoreCategoryID",methods={"GET"})
     * @return JsonResponse
      * *
      * @OA\Tag(name="Store Product Category")
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
      public function getSubCategoriesByStoreCategoryID($storeCategoryID)
      {
        $result = $this->storeProductCategoryService->getSubCategoriesByStoreCategoryID($storeCategoryID);

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
     * get active products by first subcategory.
     * @Route("storeproductscategoryleveltwowithproducts/{storeProductCategoryID}", name="getStoreProductsCategoryLevelTwoWithProductsByStoreProductCategoryID", methods={"GET"})
     * @return JsonResponse
     * *
     * @OA\Tag(name="Store Product Category")
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
    public function getStoreProductsCategoryLevelTwoWithProductsByStoreProductCategoryID($storeProductCategoryID)
    {
        $result = $this->storeProductCategoryService->getStoreProductsCategoryLevelTwoWithProductsByStoreProductCategoryID($storeProductCategoryID);

        return $this->response($result, self::FETCH);
    }

    /**
     * client: Get the products of the first subcategory
     * @Route("productsbystorecategroylevelone/{storeProductCategoryID}", name="getProductsByStoreCategroyLevelOne", methods={"GET"})
     * @return JsonResponse
     * @IsGranted("ROLE_OWNER")
     *
     * @OA\Tag(name="Store Product Category")
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
     *              )
     *          )
     *      )
     *  )
     *
     */
    public function getProductsByStoreCategroyLevelOne($storeProductCategoryID)
    {
        $result = $this->storeProductCategoryService->getProductsByStoreCategroyLevelOne($storeProductCategoryID, $this->getUserId());

        return $this->response($result, self::FETCH);
    }
    /**
     * Delete store product category.
     * @Route("storeproductcategory/{id}", name="deleteStoreProductCategoryByID", methods={"DELETE"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     **
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
     * or
     *
     * @OA\Response(
     *      response=275,
     *      description="Returns string",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="string", property="Data"),
     *      )
     * )
     *
     */
    public function deleteStoreProductCategoryByID(Request $request): JsonResponse
    {
        $request = new DeleteRequest($request->get('id'));

        $result = $this->storeProductCategoryService->deleteStoreProductCategoryByID($request);
        if ($result == "storeProductCategoryNotFound"){
            return $this->response($result, self::NOTFOUND);
        }

        return $this->response($result, self::DELETE);
    }
}
