<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\DeleteRequest;
use App\Request\FilterStoreCategory;
use App\Request\StoreCategoriesWithLinkedMarkRequest;
use App\Request\StoreCategoryUpdateRequest;
use App\Request\StoreCategoryWithTranslationCreateRequest;
use App\Request\StoreCategoryWithTranslationUpdateRequest;
use App\Service\StoreCategoryService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class StoreCategoryController extends BaseController
{
    private $autoMapping;
    private $storeCategoryService;
    private $validator;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, StoreCategoryService $storeCategoryService, ValidatorInterface $validator)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->storeCategoryService = $storeCategoryService;
        $this->validator = $validator;
    }

    /**
     * admin: Create new store category.
     * @Route("/createstorecategory", name="createStoreCategory", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Store Category")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Create new Store Category",
     *      @OA\JsonContent(
     *          @OA\Property(type="object", property="data",
     *              @OA\Property(type="string", property="storeCategoryName"),
     *              @OA\Property(type="string", property="description"),
     *              @OA\Property(type="string", property="image")
     *          ),
     *          @OA\Property(type="array", property="translate",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="storeCategoryID"),
     *                  @OA\Property(type="string", property="storeCategoryName"),
     *                  @OA\Property(type="string", property="description"),
     *                  @OA\Property(type="string", property="language")
     *              )
     *          )
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
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="storeCategoryName"),
     *                  @OA\Property(type="string", property="description"),
     *                  @OA\Property(type="string", property="image")
     *          )
     *      )
     * )
     * @Security(name="Bearer")
     */
    public function createStoreCategory(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StoreCategoryWithTranslationCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if(\count($violations) > 0)
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->storeCategoryService->createStoreCategory($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * admin: Update store category.
     * @Route("/updatestorecategory", name="updateStoreCategory", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Store Category")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update Store Category.",
     *      @OA\JsonContent(
     *          @OA\Property(type="object", property="data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="storeCategoryName"),
     *              @OA\Property(type="string", property="description"),
     *              @OA\Property(type="string", property="image")
     *          ),
     *          @OA\Property(type="array", property="translate",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="storeCategoryID"),
     *                  @OA\Property(type="string", property="storeCategoryName"),
     *                  @OA\Property(type="string", property="description"),
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
     *                  @OA\Property(type="string", property="storeCategoryName"),
     *                  @OA\Property(type="string", property="description"),
     *                  @OA\Property(type="string", property="image")
     *          )
     *      )
     * )
     * @Security(name="Bearer")
     */
    public function updateStoreCategory(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StoreCategoryWithTranslationUpdateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if(\count($violations) > 0)
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->storeCategoryService->updateStoreCategory($request);

        return $this->response($result, self::UPDATE);
    }

    /**
     * Get store categories.
     * @Route("storecategories", name="getStoreCategories", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Category")
     *
     * @OA\RequestBody(
     *      description="Filter store categories according to language",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="language")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Get Store Categories",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="storeCategoryName"),
     *                  @OA\Property(type="object", property="image",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL"),
     *                  ),
     *          )
     *      )
     * )
     */
      public function getStoreCategories(Request $request): JsonResponse
      {
          $data = json_decode($request->getContent(), true);

          $request = $this->autoMapping->map(stdClass::class, FilterStoreCategory::class, (object)$data);

          $result = $this->storeCategoryService->getStoreCategories($request);
  
          return $this->response($result, self::FETCH);
      }

    /**
     * Get store categories with mark (linked or not) with specific store product category level one
     * @Route("allstorecategories", name="getStoreCategoriesByStoreProductCategoryLevelOne", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Category")
     *
     * @OA\RequestBody(
     *      description="Filter store categories according to language",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="language"),
     *          @OA\Property(type="integer", property="storeProductCategoryLevelOneID")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Get Store Categories",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="storeCategoryName"),
     *                  @OA\Property(type="object", property="image",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL"),
     *                  ),
     *                  @OA\Property(type="boolean", property="linked"),
     *          )
     *      )
     * )
     */
    public function getStoreCategoriesByProductStoreCategoryLevelOne(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StoreCategoriesWithLinkedMarkRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if(\count($violations) > 0)
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->storeCategoryService->getStoreCategoriesByProductStoreCategoryLevelOne($request);

        return $this->response($result, self::FETCH);
    }

    /**
     * Get store categories by preferred language
     * @Route("storecategories", name="getStoreCategoriesByPreferredLanguage", methods={"GET"})
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Category")
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
     *      description="Get Store Categories",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="storeCategoryName"),
     *                  @OA\Property(type="object", property="image",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL"),
     *                  ),
     *          )
     *      )
     * )
     */
    public function getStoreCategoriesByPreferredLanguage(Request $request): JsonResponse
    {
        $result = $this->storeCategoryService->getStoreCategoriesByPreferredLanguage($request->getPreferredLanguage());

        return $this->response($result, self::FETCH);
    }

    /**
     * Get specific store category.
     * @Route("/storecategory/{id}", name="getStoreCategory", methods={"GET"})
     * @param Request $request
     * @param $id
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Category")
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
     *      description="Get Store Category by id",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="storeCategoryName"),
     *                  @OA\Property(type="object", property="image"),
     *                  @OA\Property(type="string", property="language"),
     *                  @OA\Property(type="object", property="translate",
     *                      @OA\Property(type="integer", property="id"),
     *                      @OA\Property(type="string", property="language"),
     *                      @OA\Property(type="string", property="storeCategoryName")
     *                  )
     *          )
     *      )
     * )
     */
      public function getStoreCategoryByID(Request $request, $id)
      {
          $result = $this->storeCategoryService->getStoreCategoryByID($request->getPreferredLanguage(), $id);
  
          return $this->response($result, self::FETCH);
      }

    /**
     * Get Store Categories And Stores.
     * @Route("storecategoriesandstores", name="getStoreCategoriesAndLast15Stores", methods={"GET"})
     * @return JsonResponse
     * *
     * @OA\Tag(name="Store Category")
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
     *      description="Get Store Categories And Stores",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                 @OA\Property(type="array", property="categories",
     *                  @OA\Items(
     *                       @OA\Property(type="integer", property="id"),
     *                       @OA\Property(type="string", property="storeCategoryName"),
     *                       @OA\Property(type="object", property="image",
     *                          @OA\Property(type="string", property="imageURL"),
     *                          @OA\Property(type="string", property="image"),
     *                          @OA\Property(type="string", property="baseURL"),
     *                          ),
     *                      ),
     *                  ),
     *                 @OA\Property(type="array", property="stores",
     *                  @OA\Items(
     *                       @OA\Property(type="integer", property="id"),
     *                       @OA\Property(type="string", property="storeCategoryName"),
     *                       @OA\Property(type="object", property="image",
     *                          @OA\Property(type="string", property="imageURL"),
     *                          @OA\Property(type="string", property="image"),
     *                          @OA\Property(type="string", property="baseURL"),
     *                          ),
     *                       @OA\Property(type="string", property="phone"),
     *                       @OA\Property(type="object", property="location"),
     *                       @OA\Property(type="boolean", property="privateOrders"),
     *                       @OA\Property(type="boolean", property="hasProducts"),
     *                       @OA\Property(type="integer", property="storeCategoryId"),
     *                       @OA\Property(type="string", property="rating"),
     *                       @OA\Property(type="object", property="closingTime"),
     *                       @OA\Property(type="object", property="openingTime"),
     *                       @OA\Property(type="string", property="status"),
     *
     *                      ),
     *                   ),
     *             )
     *          )
     *       )
     */
    public function getStoreCategoriesAndStores(Request $request): JsonResponse
    {
        $result = $this->storeCategoryService->getStoreCategoriesAndStores($request->getPreferredLanguage());

        return $this->response($result, self::FETCH);
    }

    /**
     * Client: Get Favourite Store Categories And its Stores for the signed-in client or Get last 15 Store Categories And its last 15 its Stores.
     * @Route("favouritestorecategoriesandstores", name="getFavouriteStoreCategoriesAndStores", methods={"GET"})
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Category")
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
     *      description="Get Store Categories And Stores",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="storeCategoryName"),
     *                  @OA\Property(type="array", property="stores",
     *                      @OA\Items(
     *                          @OA\Property(type="integer", property="id"),
     *                          @OA\Property(type="string", property="storeOwnerName"),
     *                          @OA\Property(type="object", property="image",
     *                              @OA\Property(type="string", property="imageURL"),
     *                              @OA\Property(type="string", property="image"),
     *                              @OA\Property(type="string", property="baseURL"),
     *                          ),
     *                          @OA\Property(type="string", property="phone"),
     *                          @OA\Property(type="string", property="status")
     *                      )
     *                  )
     *              )
     *          )
     *      )
     * )
     *
     */
    public function getFavouriteStoreCategoriesAndStores(Request $request): JsonResponse
    {
        $result = $this->storeCategoryService->getFavouriteStoreCategoriesAndStores($request->getPreferredLanguage(), $this->getUserId());

        return $this->response($result, self::FETCH);
    }

    /**
     * Client: Get Favourite Store Categories for the signed-in client.
     * @Route("userfavoritecategories", name="getFavouriteStoreCategories", methods={"GET"})
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Category")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
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
     *      description="Get Store Categories",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="storeCategoryName"),
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getFavouriteStoreCategories(Request $request): JsonResponse
    {
        $result = $this->storeCategoryService->getFavouriteStoreCategories($request->getPreferredLanguage(), $this->getUserId());

        return $this->response($result, self::FETCH);
    }

    /**
     * Delete store category.
     * @Route("storecategory/{id}", name="deleteStoreCategoryByID", methods={"DELETE"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Store Category")
     *
     * @OA\Response(
     *      response=200,
     *      description="Delete store category",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="storeCategoryName"),
     *              @OA\Property(type="string", property="image"),
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response=404,
     *      description="Returns storeCategoryNotFound",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="404"),
     *          @OA\Property(type="string", property="msg", description="Not found Successfully."),
     *          @OA\Property(type="string", property="Data", description="storeCategoryNotFound"),
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns the category related to subcategories or store.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9251"),
     *          @OA\Property(type="string", property="msg", description="error related Successfully."),
     *          @OA\Property(type="string", property="Data", description="related"),
     *      )
     * )
     */
    public function deleteStoreCategoryByID(Request $request): JsonResponse
    {
        $request = new DeleteRequest($request->get('id'));

        $result = $this->storeCategoryService->deleteStoreCategoryByID($request);
        if ($result == "storeCategoryNotFound"){
            return $this->response($result, self::NOTFOUND);
        }

        if ($result == "related"){
            return $this->response($result, self::ERROR_RELATED);
        }

        return $this->response($result, self::DELETE);
    }
}
