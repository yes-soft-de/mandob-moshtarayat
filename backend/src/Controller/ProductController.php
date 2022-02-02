<?php

namespace App\Controller;

use App\AutoMapping;
use App\Constant\ResponseConstant;
use App\Request\DeleteRequest;
use App\Request\ProductAvailableAndQuantityAvailableRequest;
use App\Request\ProductCancelByStoreOwnerRequest;
use App\Request\ProductCommissionByAdminUpdateRequest;
use App\Request\ProductCreateRequest;
use App\Request\ProductFilterByNameRequest;
use App\Request\ProductTranslationLanguageCodeUpdateRequest;
use App\Request\ProductUpdateRequest;
use App\Request\ProductWithTranslationCreateRequest;
use App\Request\ProductWithTranslationUpdateRequest;
use App\Request\UpdateProductToDeletedRequest;
use App\Service\ProductService;
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

class ProductController extends BaseController
{
    private $autoMapping;
    private $productService;
    private $validator;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ProductService $productService, ValidatorInterface $validator)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->productService = $productService;
        $this->validator = $validator;
    }
    
    /**
     * admin:Create product.
     * @Route("/createproductbyadmin", name="createProductByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Product")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Create new product by store",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="productName"),
     *          @OA\Property(type="string", property="productImage"),
     *          @OA\Property(type="number", property="productPrice"),
     *          @OA\Property(type="integer", property="storeProductCategoryID"),
     *          @OA\Property(type="integer", property="discount"),
     *          @OA\Property(type="string", property="description"),
     *          @OA\Property(type="integer", property="productQuantity"),
     *          @OA\Property(type="number", property="commission"),
     *          @OA\Property(type="boolean", property="isCommission"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the new product",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="productName"),
     *                  @OA\Property(type="string", property="productImage"),
     *                  @OA\Property(type="number", property="productPrice"),
     *                  @OA\Property(type="integer", property="storeOwnerProfileID"),
     *                  @OA\Property(type="integer", property="storeProductCategoryID"),
     *                  @OA\Property(type="integer", property="discount"),
     *                  @OA\Property(type="string", property="description"),
     *                  @OA\Property(type="string", property="status"),
     *                  @OA\Property(type="number", property="commission"),
     *                  @OA\Property(type="boolean", property="isCommission"),
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function createProductByAdmin(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, ProductCreateRequest::class, (object)$data);

        $result = $this->productService->createProductByAdmin($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * Get products of category specific.
     * @Route("/productscategory/{storeProductCategoryID}", name="productsByStoreProductCategoryID", methods={"GET"})
     * @param $storeProductCategoryID
     * @return JsonResponse
     *
     * @OA\Tag(name="Product")
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
     *      description="Get products of category specific",
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
     *                  @OA\Property(type="string", property="description"),
     *                  @OA\Property(type="string", property="rate"),
     *                  @OA\Property(type="string", property="soldCount"),
     *                  @OA\Property(type="object", property="image",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL"),
     *                  ),
     *                  @OA\Property(type="object", property="store",
     *                      @OA\Property(type="integer", property="id"),
     *                      @OA\Property(type="string", property="storeOwnerName"),
     *                  ),
     *              )
     *          )
     *      )
     * )
     *
     */
    public function getProductsByProductCategoryId(Request $request, $storeProductCategoryID)
    {
        $result = $this->productService->getProductsByProductCategoryId($request->getPreferredLanguage(), $storeProductCategoryID);

        return $this->response($result, self::FETCH);
    }

    /**
     * Get products of store specific and category specific.
     * @Route("/productsbycategoryidandstoreownerprofileid/{storeProductCategoryID}/{storeOwnerProfileId}", name="getProductsByProductCategoryIdAndStoreOwnerProfileId  ", methods={"GET"})
     * @param $storeProductCategoryID
     * @param $storeOwnerProfileId
     * @return JsonResponse
     * *
     * @OA\Tag(name="Product")
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
     *      description="Get products of store specific and category specific",
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
     *                  @OA\Property(type="string", property="description"),
     *                  @OA\Property(type="string", property="rate"),
     *                  @OA\Property(type="string", property="soldCount"),
     *                  @OA\Property(type="object", property="image",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL"),
     *                  ),
     *                  @OA\Property(type="object", property="store",
     *                      @OA\Property(type="integer", property="id"),
     *                      @OA\Property(type="string", property="storeOwnerName"),
     *                  ),
     *                  @OA\Property(type="number", property="commission"),
     *              )
     *          )
     *      )
     * )
     *
     */
    public function getProductsByCategoryIdAndStoreOwnerProfileId(Request $request, $storeProductCategoryID, $storeOwnerProfileId)
    {
        $result = $this->productService->getProductsByCategoryIdAndStoreOwnerProfileId($request->getPreferredLanguage(), $storeProductCategoryID, $storeOwnerProfileId);

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/products", name="getProducts", methods={"GET"})
     * @return JsonResponse
     */
    public function getProducts()
    {
        $result = $this->productService->getProducts();

        return $this->response($result, self::FETCH);
    }

    /**
     * Get product specific.
     * @Route("product/{id}", name="getProductById", methods={"GET"})
     * @return JsonResponse
     *
     * @OA\Tag(name="Product")
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
     *      description="Get product specific",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="productName"),
     *                  @OA\Property(type="string", property="productImage"),
     *                  @OA\Property(type="number", property="productPrice"),
     *                  @OA\Property(type="integer", property="storeOwnerProfileID"),
     *                  @OA\Property(type="integer", property="storeProductCategoryID"),
     *                  @OA\Property(type="string", property="storeOwnerName"),
     *                  @OA\Property(type="string", property="phone"),
     *                  @OA\Property(type="object", property="location"),
     *                  @OA\Property(type="string", property="branchName"),
     *                  @OA\Property(type="number", property="discount"),
     *                  @OA\Property(type="number", property="deliveryCost"),
     *                  @OA\Property(type="string", property="description"),
     *                  @OA\Property(type="string", property="rate"),
     *                  @OA\Property(type="string", property="soldCount"),
     *                  @OA\Property(type="string", property="status"),
     *                  @OA\Property(type="string", property="image"),
     *                  @OA\Property(type="number", property="commission"),
     *                  @OA\Property(type="boolean", property="isCommission"),
     *                  @OA\Property(type="number", property="productPriceWithOutCommission"),
     *              )
     *          )
     *      )
     * )
     *
     */
    public function getProductByIdWithFullInfo(Request $request, $id): JsonResponse
    {
        $result = $this->productService->getProductByIdWithFullInfo($request->getPreferredLanguage(), $id);

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/productstopwanted", name="productsTopWanted", methods={"GET"})
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Product")
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
     *      description="Get top wanted products",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="productName"),
     *                  @OA\Property(type="string", property="productImage"),
     *                  @OA\Property(type="number", property="productPrice"),
     *                  @OA\Property(type="integer", property="storeOwnerProfileID"),
     *                  @OA\Property(type="integer", property="storeProductCategoryID"),
     *                  @OA\Property(type="string", property="storeOwnerName"),
     *                  @OA\Property(type="string", property="phone"),
     *                  @OA\Property(type="object", property="location"),
     *                  @OA\Property(type="string", property="branchName"),
     *                  @OA\Property(type="number", property="discount"),
     *                  @OA\Property(type="number", property="deliveryCost"),
     *                  @OA\Property(type="string", property="description"),
     *                  @OA\Property(type="string", property="rate"),
     *                  @OA\Property(type="string", property="soldCount"),
     *                  @OA\Property(type="string", property="status"),
     *                  @OA\Property(type="object", property="image"),
     *              )
     *          )
     *      )
     * )
     *
     */
    public function getProductsTopWanted(Request $request): JsonResponse
    {
        $result = $this->productService->getProductsTopWanted($request->getPreferredLanguage());

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/productstopwantedofspecificstoreowner/{storeOwnerProfileId}", name="productsTopWantedOfSpecificStoreOwner", methods={"GET"})
     * @return JsonResponse
     *
     * @OA\Tag(name="Product")
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
     *      description="Get top wanted products of specific store",
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
     *                  @OA\Property(type="string", property="storeOwnerName"),
     *                  @OA\Property(type="string", property="description"),
     *                  @OA\Property(type="string", property="discount"),
     *                  @OA\Property(type="string", property="rate"),
     *                  @OA\Property(type="string", property="soldCount"),
     *                  @OA\Property(type="object", property="image",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL"),
     *                  ),
     *                  @OA\Property(type="object", property="location"),
     *                  @OA\Property(type="string", property="phone"),
     *                  @OA\Property(type="string", property="branchName"),
     *                  @OA\Property(type="string", property="status"),
     *              )
     *          )
     *      )
     * )
     *
     */
    public function productsTopWantedOfSpecificStoreOwner(Request $request, $storeOwnerProfileId)
    {
        $result = $this->productService->productsTopWantedOfSpecificStoreOwner($request->getPreferredLanguage(), $storeOwnerProfileId);

        return $this->response($result, self::FETCH);
    }

    /**
     * Get products of store specific.
     * @Route("/productsstorebyprofileid/{storeOwnerProfileId}", name="getStoreProductsByProfileId", methods={"GET"})
     * @return JsonResponse
     *
     * @OA\Tag(name="Product")
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
     *      description="Get products of store specific",
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
     *                  @OA\Property(type="string", property="description"),
     *                  @OA\Property(type="string", property="discount"),
     *                  @OA\Property(type="string", property="rate"),
     *                  @OA\Property(type="string", property="soldCount"),
     *                  @OA\Property(type="object", property="image",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL"),
     *                  ),
     *                  @OA\Property(type="number", property="commission"),
     *                  @OA\Property(type="boolean", property="isCommission"),
     *              )
     *          )
     *      )
     * )
     *
     */
    public function getStoreProductsByProfileId(Request $request, $storeOwnerProfileId)
    {
        $result = $this->productService->getStoreProductsByProfileId($request->getPreferredLanguage(), $storeOwnerProfileId);

        return $this->response($result, self::FETCH);
    }

    /**
     * Get products of subcategory of level two.
     * @Route("productsbystoreproductcategoryid/{storeProductCategoryID}", name="getProductsByStoreProductCategoryID", methods={"GET"})
     * @return JsonResponse
     *
     * @OA\Tag(name="Product")
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
     *      description="Get products of subcategory of level two",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="productName"),
     *                  @OA\Property(type="number", property="productPrice"),
     *                  @OA\Property(type="number", property="productQuantity"),
     *                  @OA\Property(type="integer", property="storeOwnerProfileID"),
     *                  @OA\Property(type="integer", property="storeProductCategoryID"),
     *                  @OA\Property(type="string", property="description"),
     *                  @OA\Property(type="string", property="rate"),
     *                  @OA\Property(type="string", property="soldCount"),
     *                  @OA\Property(type="string", property="status"),
     *                  @OA\Property(type="object", property="image",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL"),
     *                  ),
     *                  @OA\Property(type="object", property="store",
     *                      @OA\Property(type="integer", property="id"),
     *                      @OA\Property(type="string", property="storeOwnerName"),
     *                  ),
     *              )
     *          )
     *      )
     * )
     *
     */
    public function getProductsByStoreProductCategoryID(Request $request, $storeProductCategoryID): JsonResponse
    {
        $result = $this->productService->getProductsByStoreProductCategoryID($request->getPreferredLanguage(), $storeProductCategoryID);

        return $this->response($result, self::FETCH);
    }

    /**
     * store: Get products of subcategory of level two for specific store.
     * @Route("productsbystoreproductcategoryidforstore/{storeProductCategoryID}", name="getProductsByStoreProductCategoryIDForStore", methods={"GET"})
     * @param Request $request
     * @param $storeProductCategoryID
     * @return JsonResponse
     * @IsGranted("ROLE_OWNER")
     *
     * @OA\Tag(name="Product")
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
     *      description="Get products of subcategory of level two for specific store",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="productName"),
     *                  @OA\Property(type="number", property="productPrice"),
     *                  @OA\Property(type="number", property="productQuantity"),
     *                  @OA\Property(type="integer", property="storeOwnerProfileID"),
     *                  @OA\Property(type="integer", property="storeProductCategoryID"),
     *                  @OA\Property(type="string", property="description"),
     *                  @OA\Property(type="string", property="rate"),
     *                  @OA\Property(type="string", property="soldCount"),
     *                  @OA\Property(type="string", property="status"),
     *                  @OA\Property(type="object", property="image",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL"),
     *                  ),
     *                  @OA\Property(type="object", property="store",
     *                      @OA\Property(type="integer", property="id"),
     *                      @OA\Property(type="string", property="storeOwnerName"),
     *                  ),
     *                  @OA\Property(type="boolean", property="isLevel1"),
     *                  @OA\Property(type="boolean", property="isLevel2"),
     *                  @OA\Property(type="boolean", property="isCommission"),
     *                  @OA\Property(type="object", property="categoryLink",
     *                      @OA\Property(type="integer", property="subCategoryLevelOneID"),
     *                      @OA\Property(type="integer", property="subCategoryLevelTwoID"),
     *                  ),
     *              )
     *          )
     *      )
     * )
     */
    public function getProductsByStoreProductCategoryIDForStore(Request $request, $storeProductCategoryID): JsonResponse
    {
        $result = $this->productService->getProductsByStoreProductCategoryIDForStore($request->getPreferredLanguage(), $storeProductCategoryID, $this->getUserId());

        return $this->response($result, self::FETCH);
    }

    /**
     * store: Get products of specific store for store , if send value for name you get filter.
     * @Route("getproductsstore", name="getStoreProducts", methods={"POST"})
     * @IsGranted("ROLE_OWNER")
     * @return JsonResponse
     * *
     * @OA\Tag(name="Product")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Filter by product name",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="name"),
     *          @OA\Property(type="string", property="language")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Get products of specific store for store",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="productName"),
     *                  @OA\Property(type="number", property="productPrice"),
     *                  @OA\Property(type="integer", property="productQuantity"),
     *                  @OA\Property(type="integer", property="storeOwnerProfileID"),
     *                  @OA\Property(type="integer", property="storeProductCategoryID"),
     *                  @OA\Property(type="string", property="description"),
     *                  @OA\Property(type="integer", property="discount"),
     *                  @OA\Property(type="string", property="rate"),
     *                  @OA\Property(type="string", property="soldCount"),
     *                  @OA\Property(type="string", property="status"),
     *                  @OA\Property(type="object", property="image",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL"),
     *                  ),
     *                  @OA\Property(type="boolean", property="isLevel1"),
     *                  @OA\Property(type="boolean", property="isLevel2"),
     *              )
     *          )
     *      )
     * )
     * @Security(name="Bearer")
     *
     */
    public function getStoreProducts(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, ProductFilterByNameRequest::class, (object)$data);

        $result = $this->productService->getStoreProducts($this->getUserId(),$request);

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: Update product by admin.
     * @Route("/updateProductByAdmin", name="updateProductByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Product")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update product by admin",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="productName"),
     *          @OA\Property(type="string", property="productImage"),
     *          @OA\Property(type="number", property="productPrice"),
     *          @OA\Property(type="integer", property="storeOwnerProfileID"),
     *          @OA\Property(type="integer", property="storeProductCategoryID"),
     *          @OA\Property(type="number", property="commission"),
     *          @OA\Property(type="boolean", property="isCommission"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns product",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="productName"),
     *                  @OA\Property(type="string", property="productImage"),
     *                  @OA\Property(type="number", property="storeOwnerProfileID"),
     *                  @OA\Property(type="integer", property="storeProductCategoryID"),
     *                  @OA\Property(type="number", property="commission"),
     *                  @OA\Property(type="boolean", property="isCommission"),
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateProductByAdmin(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, ProductUpdateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->productService->updateProductByAdmin($request);

        return $this->response($result, self::UPDATE);
    }

    /**
     * admin: Update product commission by admin.
     * @Route("updateproductcommissionbyadmin", name="updateProductCommissionByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Product")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update product by admin",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="number", property="commission"),
     *          @OA\Property(type="boolean", property="isCommission"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns product",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="productName"),
     *                  @OA\Property(type="string", property="productImage"),
     *                  @OA\Property(type="number", property="storeOwnerProfileID"),
     *                  @OA\Property(type="integer", property="storeProductCategoryID"),
     *                  @OA\Property(type="number", property="commission"),
     *                  @OA\Property(type="boolean", property="isCommission"),
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateProductCommissionByAdmin(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, ProductCommissionByAdminUpdateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->productService->updateProductCommissionByAdmin($request);

        return $this->response($result, self::UPDATE);
    }

    /**
     * store: Create new product by store.
     * @Route("createproductbystore", name="createProductByStore", methods={"POST"})
     * @IsGranted("ROLE_OWNER")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Product")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Create new product by store",
     *      @OA\JsonContent(
     *          @OA\Property(type="object", property="data",
     *              @OA\Property(type="string", property="productName"),
     *              @OA\Property(type="string", property="productImage"),
     *              @OA\Property(type="number", property="productPrice"),
     *              @OA\Property(type="integer", property="storeProductCategoryID"),
     *              @OA\Property(type="integer", property="discount"),
     *              @OA\Property(type="integer", property="productQuantity")
     *          ),
     *          @OA\Property(type="array", property="translate",
     *              @OA\Items(
     *                  @OA\Property(type="string", property="productName"),
     *                  @OA\Property(type="string", property="language")
     *              )
     *          )
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the new product",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="productName"),
     *                  @OA\Property(type="string", property="productImage"),
     *                  @OA\Property(type="number", property="productPrice"),
     *                  @OA\Property(type="integer", property="storeOwnerProfileID"),
     *                  @OA\Property(type="integer", property="storeProductCategoryID"),
     *                  @OA\Property(type="integer", property="discount"),
     *                  @OA\Property(type="string", property="description"),
     *                  @OA\Property(type="string", property="status"),
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function createProductByStore(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, ProductWithTranslationCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if(\count($violations) > 0)
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->productService->createProductByStore($request, $this->getUserId());

        return $this->response($result, self::CREATE);
    }

    /**
     * store: Update product by store.
     * @Route("updateproductbystore", name="updateProductByStore", methods={"PUT"})
     * @IsGranted("ROLE_OWNER")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Product")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update product by store",
     *      @OA\JsonContent(
     *          @OA\Property(type="object", property="data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="productName"),
     *              @OA\Property(type="string", property="productImage"),
     *              @OA\Property(type="number", property="productPrice"),
     *              @OA\Property(type="integer", property="storeProductCategoryID"),
     *              @OA\Property(type="integer", property="discount"),
     *              @OA\Property(type="integer", property="productQuantity"),
     *              @OA\Property(type="string", property="status")
     *          ),
     *          @OA\Property(type="array", property="translate",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="productID"),
     *                  @OA\Property(type="string", property="productName"),
     *                  @OA\Property(type="string", property="language")
     *              )
     *          )
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns product",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="productName"),
     *                  @OA\Property(type="string", property="productImage"),
     *                  @OA\Property(type="number", property="productPrice"),
     *                  @OA\Property(type="integer", property="storeOwnerProfileID"),
     *                  @OA\Property(type="integer", property="storeProductCategoryID"),
     *                  @OA\Property(type="integer", property="discount"),
     *                  @OA\Property(type="string", property="description"),
     *                  @OA\Property(type="string", property="status"),
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateProductByStore(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, ProductWithTranslationUpdateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->productService->updateProductByStore($request, $this->getUserId());

        return $this->response($result, self::UPDATE);
    }

    /**
     * Get products of subcategory of level one or two.
     * @Route("/productsbystorecategory/{storeCategoryID}", name="getProductsByStoreCategoryID", methods={"GET"})
     * @param Request $request
     * @param $storeCategoryID
     * @return JsonResponse
     *
     * @OA\Tag(name="Product")
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
     *      description="Get products of subcategory of level one",
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
     */
    public function getProductsByStoreCategoryID(Request $request, $storeCategoryID): JsonResponse
    {
        $result = $this->productService->getProductsByStoreCategoryID($request->getPreferredLanguage(), $storeCategoryID);

        return $this->response($result, self::FETCH);
    }

    /**
     * store: Update product status for active or inactive.
     * @Route("/updateproductstatusbystore", name="updateProductStatusByStore", methods={"PUT"})
     * @IsGranted("ROLE_OWNER")
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Product")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update product status for active or inactive",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="status")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns product",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="productName"),
     *                  @OA\Property(type="string", property="productImage"),
     *                  @OA\Property(type="number", property="productPrice"),
     *                  @OA\Property(type="integer", property="storeOwnerProfileID"),
     *                  @OA\Property(type="integer", property="storeProductCategoryID"),
     *                  @OA\Property(type="integer", property="discount"),
     *                  @OA\Property(type="string", property="description"),
     *                  @OA\Property(type="string", property="status"),
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateProductStatusByStore(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, ProductCancelByStoreOwnerRequest::class, (object)$data);

        $result = $this->productService->updateProductStatusByStore($request);

        return $this->response($result, self::UPDATE);
    }

    /**
     * Get products similar of the second level subcategory.
     * @Route("/productssimilar/{storeProductCategoryID}", name="getSimilarProductsByStoreProductCategoryIdOfLevelTwo", methods={"GET"})
     * @param Request $request
     * @param $storeProductCategoryID
     * @return JsonResponse
     *
     * @OA\Tag(name="Product")
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
     *      description="Get products similar of the second level subcategory",
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
     */
    public function getSimilarProductsByStoreProductCategoryIdOfLevelTwo(Request $request, $storeProductCategoryID): JsonResponse
    {
        $result = $this->productService->getSimilarProductsByStoreProductCategoryIdOfLevelTwo($request->getPreferredLanguage(), $storeProductCategoryID);

        return $this->response($result, self::FETCH);
    }

    /**
     * Delete product.
     * @Route("product/{id}", name="deleteProductByID", methods={"DELETE"})
     * @param Request $request
     * @return JsonResponse
     **
     * @OA\Tag(name="Product")
     *
     * @OA\Response(
     *      response=401,
     *      description="Delete product",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="productName"),
     *              @OA\Property(type="string", property="productImage"),
     *              @OA\Property(type="number", property="productPrice"),
     *              @OA\Property(type="integer", property="storeOwnerProfileID"),
     *              @OA\Property(type="integer", property="storeProductCategoryID"),
     *              @OA\Property(type="integer", property="discount"),
     *              @OA\Property(type="string", property="description"),
     *              @OA\Property(type="string", property="status")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response=404,
     *      description="Returns Not found Successfully.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="string", property="Data"),
     *      )
     * )
     *
     */
    public function deleteProductById(Request $request)
    {
        $request = new DeleteRequest($request->get('id'));

        $result = $this->productService->deleteProductById($request);
        if ($result == "productNotFound"){
            return $this->response($result, self::NOTFOUND);
        }

        return $this->response($result, self::DELETE);
    }

    /**
     * get Last 30 Products.
     * @Route("productslast30", name="getLast30Products", methods={"GET"})
     * @return JsonResponse
     * *
     * @OA\Tag(name="Product")
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
     *      description="Get last 30 products",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="productName"),
     *                  @OA\Property(type="number", property="productPrice"),
     *                  @OA\Property(type="number", property="productQuantity"),
     *                  @OA\Property(type="integer", property="storeOwnerProfileID"),
     *                  @OA\Property(type="integer", property="storeProductCategoryID"),
     *                  @OA\Property(type="object", property="image",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL"),
     *                  ),
     *                  @OA\Property(type="string", property="discount"),
     *                  @OA\Property(type="string", property="description"),
     *                  @OA\Property(type="string", property="rate"),
     *                  @OA\Property(type="string", property="soldCount"),
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
    public function getLast30Products(Request $request): JsonResponse
    {
        $result = $this->productService->getLast30Products($request->getPreferredLanguage());

        return $this->response($result, self::FETCH);
    }

    /**
     * Get products of store specific.
     * @Route("/productsstoreownerprofileid/{storeOwnerProfileId}", name="getProductsStoreOwnerProfileId  ", methods={"GET"})
     * @param $storeOwnerProfileId
     * @return JsonResponse
     * *
     * @OA\Tag(name="Product")
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
     *      description="Get products of store specific for client",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="productName"),
     *                  @OA\Property(type="number", property="productPrice"),
     *                  @OA\Property(type="integer", property="productQuantity"),
     *                  @OA\Property(type="integer", property="storeOwnerProfileID"),
     *                  @OA\Property(type="integer", property="storeProductCategoryID"),
     *                  @OA\Property(type="integer", property="discount"),
     *                  @OA\Property(type="string", property="description"),
     *                  @OA\Property(type="string", property="rate"),
     *                  @OA\Property(type="string", property="soldCount"),
     *                  @OA\Property(type="string", property="status"),
     *                  @OA\Property(type="object", property="image",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL"),
     *                  ),
     *                  @OA\Property(type="object", property="store",
     *                      @OA\Property(type="integer", property="id"),
     *                      @OA\Property(type="string", property="storeOwnerName"),
     *                  ),
     *                  @OA\Property(type="number", property="commission"),
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getProductsStoreOwnerProfileId(Request $request, $storeOwnerProfileId): JsonResponse
    {
        $result = $this->productService->getProductsStoreOwnerProfileId($request->getPreferredLanguage(), $storeOwnerProfileId);

        return $this->response($result, self::FETCH);
    }

    /**
     * update product to deleted .
     * @Route("updateproducttodeleted/{id}", name=" updateProductToDeleted", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse
     **
     * @OA\Tag(name="Product")
     *
     * @OA\Response(
     *      response=204,
     *      description="update product to deleted",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="productName"),
     *              @OA\Property(type="string", property="productImage"),
     *              @OA\Property(type="number", property="productPrice"),
     *              @OA\Property(type="integer", property="storeOwnerProfileID"),
     *              @OA\Property(type="integer", property="storeProductCategoryID"),
     *              @OA\Property(type="integer", property="discount"),
     *              @OA\Property(type="string", property="description"),
     *              @OA\Property(type="string", property="status")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response=404,
     *      description="Returns Not found Successfully.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="string", property="Data"),
     *      )
     * )
     *
     */

    public function updateProductToDeleted(Request $request, $id)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, UpdateProductToDeletedRequest::class, (object)$data);
        $request->setId($id);

        $result = $this->productService->updateProductToDeleted($request);
        if ($result == "productNotFound"){
            return $this->response($result, self::NOTFOUND);
        }
        return $this->response($result, self::UPDATE);
    }

    /**
     * Is the product available, is the required quantity available.
     * @Route("productavailableandquantityavailable", name="productAvailableAndQuantityAvailable", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */

    public function productAvailableAndQuantityAvailable(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, ProductAvailableAndQuantityAvailableRequest::class, (object)$data);

        if(!isset($data['productDetails'])){
            return $this->response(ResponseConstant::$ERROR_VALIDATION_PRODUCT_DETAILS, self::ERROR);
        }

        $request->setProductDetails($data['productDetails']);

        $response = $this->productService->productAvailableAndQuantityAvailable($request);

        return $this->response($response, self::FETCH);
    }

    /**
     *
     * @Route("deletedfalse", name="deletedFalse", methods={"PUT"})
     * @return JsonResponse
     */
    public function deletedFalse(): JsonResponse
    {
        $result = $this->productService->deletedFalse();

        return $this->response($result, self::FETCH);
    }

    /**
     * for testing issues: update language code
     * @Route("producttranslationlanguage", name="updateProductTranslationLanguageByLanguage", methods={"PUT"})
     */
    public function updateAllProductTranslationLanguageCodeByProductIdAndLanguage(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, ProductTranslationLanguageCodeUpdateRequest::class, (object)$data);

        $response = $this->productService->updateAllProductTranslationLanguageCodeByProductIdAndLanguage($request);

        return $this->response($response, self::UPDATE);
    }
}
