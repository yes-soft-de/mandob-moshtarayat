<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\DeleteRequest;
use App\Request\StoreCategoryCreateRequest;
use App\Request\StoreCategoryUpdateRequest;
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
     *          @OA\Property(type="string", property="storeCategoryName"),
     *          @OA\Property(type="string", property="description"),
     *          @OA\Property(type="string", property="image"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
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

        $request = $this->autoMapping->map(stdClass::class, StoreCategoryCreateRequest::class, (object)$data);

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
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="storeCategoryName"),
     *          @OA\Property(type="string", property="description"),
     *          @OA\Property(type="string", property="image"),
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

        $request = $this->autoMapping->map(stdClass::class, StoreCategoryUpdateRequest::class, (object)$data);

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
     * @Route("storecategories", name="getStoreCategories", methods={"GET"})
     * @return JsonResponse
     **
     * @OA\Tag(name="Store Category")
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
      public function getStoreCategories(): JsonResponse
      {
          $result = $this->storeCategoryService->getStoreCategories();
  
          return $this->response($result, self::FETCH);
      }

    /**
      * Get specific store category.
      * @Route("/storecategory/{id}", name="getStoreCategory", methods={"GET"})
      * @param Request $request
      * @return JsonResponse
     * *
     * @OA\Tag(name="Store Category")
     *
     * @OA\Response(
     *      response=200,
     *      description="Get Store Category by id",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="string", property="storeCategoryName"),
     *                  @OA\Property(type="object", property="image")
     *          )
     *      )
     * )
     */
      public function getStoreCategory($id)
      {
          $result = $this->storeCategoryService->getStoreCategory($id);
  
          return $this->response($result, self::FETCH);
      }

    /**
     * Get Store Categories And Stores.
     * @Route("storecategoriesandstores", name="getStoreCategoriesAndLast15Stores", methods={"GET"})
     * @return JsonResponse
     * *
     * @OA\Tag(name="Store Category")
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
    public function getStoreCategoriesAndStores(): JsonResponse
    {
        $result = $this->storeCategoryService->getStoreCategoriesAndStores();

        return $this->response($result, self::FETCH);
    }

    /**
     * Client: Get Favourite Store Categories And its Stores for the signed-in client.
     * @Route("favouritestorecategoriesandstores", name="getFavouriteStoreCategoriesAndStores", methods={"GET"})
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Category")
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
    public function getFavouriteStoreCategoriesAndStores(): JsonResponse
    {
        $result = $this->storeCategoryService->getFavouriteStoreCategoriesAndStores($this->getUserId());

        return $this->response($result, self::FETCH);
    }

    /**
     * Client: Get Favourite Store Categories for the signed-in client.
     * @Route("userfavoritecategories", name="getFavouriteStoreCategories", methods={"GET"})
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
    public function getFavouriteStoreCategories(): JsonResponse
    {
        $result = $this->storeCategoryService->getFavouriteStoreCategories($this->getUserId());

        return $this->response($result, self::FETCH);
    }

    /**
     * Delete store category.
     * @Route("storecategory/{id}", name="deleteStoreCategoryByID", methods={"DELETE"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     **
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
     *      response=275,
     *      description="Returns string",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="string", property="Data"),
     *      )
     * )
     */
    public function deleteStoreCategoryByID(Request $request): JsonResponse
    {
        $request = new DeleteRequest($request->get('id'));

        $result = $this->storeCategoryService->deleteStoreCategoryByID($request);
        if ($result == "storeCategoryNotFound"){
            return $this->response($result, self::ERROR_DELETE);
        }

        return $this->response($result, self::DELETE);
    }
}
