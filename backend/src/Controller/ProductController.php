<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\ProductCreateRequest;
use App\Request\ProductUpdateRequest;
use App\Service\ProductService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;

class ProductController extends BaseController
{
    private $autoMapping;
    private $productService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ProductService $productService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->productService = $productService;
    }
    
    /**
     * @Route("/createproductbyadmin", name="createProductByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function createProductByAdmin(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, ProductCreateRequest::class, (object)$data);
        $result = $this->productService->createProductByAdmin($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("/productscategory/{storeProductCategoryID}", name="getProductsByStoreProductCategoryID", methods={"GET"})
     * @param Request $request
     * @return JsonResponse
     */
    public function getProductsByProductCategoryId($storeProductCategoryID)
    {
        $result = $this->productService->getProductsByProductCategoryId($storeProductCategoryID);

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/productsbycategoryidandstoreownerprofileid/{storeProductCategoryID}/{storeOwnerProfileId}", name="getProductsByProductCategoryIdAndStoreOwnerProfileId  ", methods={"GET"})
     * @param Request $request
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
     * @Route("/product/{id}", name="getProductById", methods={"GET"})
     * @return JsonResponse
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

        return $this->response($result, self::CREATE);
    }
}
