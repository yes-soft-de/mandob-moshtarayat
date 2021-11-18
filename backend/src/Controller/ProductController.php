<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\ProductCancelByStoreOwnerRequest;
use App\Request\ProductCreateRequest;
use App\Request\ProductUpdateByStoreOwnerRequest;
use App\Request\ProductUpdateRequest;
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
     * @Route("/createproductbyadmin", name="createProductByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     */
    public function createProductByAdmin(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, ProductCreateRequest::class, (object)$data);

        $result = $this->productService->createProductByAdmin($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("/productscategory/{storeProductCategoryID}", name="productsByStoreProductCategoryID", methods={"GET"})
     * @param $storeProductCategoryID
     * @return JsonResponse
     */
    public function getProductsByProductCategoryId($storeProductCategoryID)
    {
        $result = $this->productService->getProductsByProductCategoryId($storeProductCategoryID);

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/productsbycategoryidandstoreownerprofileid/{storeProductCategoryID}/{storeOwnerProfileId}", name="getProductsByProductCategoryIdAndStoreOwnerProfileId  ", methods={"GET"})
     * @param $storeProductCategoryID
     * @param $storeOwnerProfileId
     * @return JsonResponse
     */
    public function getProductsByCategoryIdAndStoreOwnerProfileId($storeProductCategoryID, $storeOwnerProfileId)
    {
        $result = $this->productService->getProductsByCategoryIdAndStoreOwnerProfileId($storeProductCategoryID, $storeOwnerProfileId);

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
     * @Route("product/{id}", name="getProductById", methods={"GET"})
     * @return JsonResponse
     *
     * @OA\Tag(name="Product")

     * @OA\Response(
     *      response=200,
     *      description="Returns information of the product",
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
     *              )
     *          )
     *      )
     * )
     *
     */
    public function getProductByIdWithFullInfo($id)
    {
        $result = $this->productService->getProductByIdWithFullInfo($id);

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/productstopwanted", name="productsTopWanted", methods={"GET"})
     * @return JsonResponse
     */
    public function getProductsTopWanted()
    {
        $result = $this->productService->getProductsTopWanted();

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/productstopwantedofspecificstoreowner/{storeOwnerProfileId}", name="productsTopWantedOfSpecificStoreOwner", methods={"GET"})
     * @return JsonResponse
     */
    public function productsTopWantedOfSpecificStoreOwner($storeOwnerProfileId)
    {
        $result = $this->productService->productsTopWantedOfSpecificStoreOwner($storeOwnerProfileId);

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/productsStoreByProfileId/{storeOwnerProfileId}", name="getStoreProductsByProfileId", methods={"GET"})
     * @return JsonResponse
     */
    public function getStoreProductsByProfileId($storeOwnerProfileId)
    {
        $result = $this->productService->getStoreProductsByProfileId($storeOwnerProfileId);

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/productsbystoreproductcategoryid/{storeProductCategoryID}", name="getProductsByStoreProductCategoryID", methods={"GET"})
     * @return JsonResponse
     * *
     * @OA\Tag(name="Product")

     * @OA\Response(
     *      response=200,
     *      description="Returns array of subcategory products ",
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
    public function getProductsByStoreProductCategoryID($storeProductCategoryID)
    {
        $result = $this->productService->getProductsByStoreProductCategoryID($storeProductCategoryID);

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/getproductsstore", name="getStoreProducts", methods={"GET"})
     * @IsGranted("ROLE_OWNER")
     * @return JsonResponse
     */
    public function getStoreProducts(): JsonResponse
    {

        $result = $this->productService->getStoreProducts($this->getUserId());

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/updateProductByAdmin", name="updateProductByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function updateProductByAdmin(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, ProductUpdateRequest::class, (object)$data);
        $result = $this->productService->updateProductByAdmin($request);

        return $this->response($result, self::UPDATE);
    }

    /**
     * @Route("/createproductbystore", name="createProductByStore", methods={"POST"})
     * @IsGranted("ROLE_OWNER")
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Product")
     *@OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     * @OA\RequestBody(
     *      description="Create New Product",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="productName"),
     *          @OA\Property(type="string", property="productImage"),
     *          @OA\Property(type="number", property="productPrice"),
     *          @OA\Property(type="integer", property="storeProductCategoryID"),
     *          @OA\Property(type="integer", property="discount"),
     *          @OA\Property(type="string", property="description"),
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
     * @Security(name="Bearer")
     */
    public function createProductByStore(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, ProductCreateRequest::class, (object)$data);

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
     * @Route("/updateproductbystore", name="updateProductByStore", methods={"PUT"})
     * @IsGranted("ROLE_OWNER")
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Product")
     *@OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     * @OA\RequestBody(
     *      description="Update Product",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="productName"),
     *          @OA\Property(type="string", property="productImage"),
     *          @OA\Property(type="number", property="productPrice"),     *
     *          @OA\Property(type="integer", property="storeOwnerProfileID"),
     *          @OA\Property(type="integer", property="storeProductCategoryID"),
     *          @OA\Property(type="integer", property="discount"),
     *          @OA\Property(type="string", property="description"),
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
     * @Security(name="Bearer")
     */
    public function updateProductByStore(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, ProductUpdateByStoreOwnerRequest::class, (object)$data);
        $result = $this->productService->updateProductByStore($request);

        return $this->response($result, self::UPDATE);
    }

    /**
     * @Route("/productsbystorecategory/{storeCategoryID}", name="getProductsByStoreCategoryID", methods={"GET"})
     * @return JsonResponse
     * @OA\Tag(name="Product")
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns products by store category ",
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
    public function getProductsByStoreCategoryID($storeCategoryID): JsonResponse
    {
        $result = $this->productService->getProductsByStoreCategoryID($storeCategoryID);

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/updateproductstatusbystore", name="updateProductStatusByStore", methods={"PUT"})
     * @IsGranted("ROLE_OWNER")
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Product")
     *@OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update Product status",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="status")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
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
     * @Route("/productssimilar/{storeProductCategoryID}", name="getSimilarProductsByStoreProductCategoryIdOfLevelTwo", methods={"GET"})
     * @return JsonResponse
     * @OA\Tag(name="Product")
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns Similar Products By Store Product CategoryID Of Level Two ",
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
    public function getSimilarProductsByStoreProductCategoryIdOfLevelTwo($storeProductCategoryID): JsonResponse
    {
        $result = $this->productService->getSimilarProductsByStoreProductCategoryIdOfLevelTwo($storeProductCategoryID);

        return $this->response($result, self::FETCH);
    }

}
