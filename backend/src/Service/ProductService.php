<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\ProductEntity;
use App\Manager\ProductManager;
use App\Manager\UserManager;
use App\Request\ProductCreateRequest;
use App\Response\ProductCreateResponse;
use App\Response\ProductsByStoreProductCategoryIdResponse;
use App\Response\ProductsResponse;
use App\Response\ProductFullInfoResponse;
use App\Response\ProductsByProductCategoryIdResponse;
use App\Response\StoreProductCategoriesResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;
use App\Service\StoreOwnerProfileService;

class ProductService
{
    private $autoMapping;
    private $productManager;
    private $params;
    private $userManager;
    private $ratingService;
    private $storeOwnerProfileService;

    public function __construct(AutoMapping $autoMapping, ProductManager $productManager, ParameterBagInterface $params, userManager $userManager,  RatingService $ratingService,StoreOwnerProfileService $storeOwnerProfileService)
    {
        $this->autoMapping = $autoMapping;
        $this->productManager = $productManager;
        $this->userManager = $userManager;
        $this->params = $params->get('upload_base_url') . '/';
        $this->ratingService = $ratingService;
        $this->storeOwnerProfileService = $storeOwnerProfileService;
    }

    public function createProductByAdmin(ProductCreateRequest $request)
    {
        $item = $this->productManager->createProductByAdmin($request);

        return $this->autoMapping->map(ProductEntity::class, ProductCreateResponse::class, $item);
    }

    public function getProductsByProductCategoryId($storeProductCategoryID)
    {
        $response = [];
        $items = $this->productManager->getProductsByProductCategoryId($storeProductCategoryID);
        foreach ($items as $item) {

            $item['store'] = $this->storeOwnerProfileService->getStoreNameById($item['storeOwnerProfileID']);
            $item['image'] = $this->getImageParams($item['productImage'], $this->params.$item['productImage'], $this->params);
            $item['rate'] = $this->ratingService->getAvgRating($item['id'], 'product');
            $item['soldCount'] = $this->getProductsSoldCount($item['id']);
            $response[] = $this->autoMapping->map('array', ProductsByProductCategoryIdResponse::class, $item);
        }
        return $response;
    }

    public function getProductsByCategoryIdAndStoreOwnerProfileId($storeProductCategoryID, $storeOwnerProfileId)
    {
        $response = [];
        $items = $this->productManager->getProductsByCategoryIdAndStoreOwnerProfileId($storeProductCategoryID, $storeOwnerProfileId);
        foreach ($items as $item) {
            $item['image'] = $this->getImageParams($item['productImage'], $this->params.$item['productImage'], $this->params);
            $item['rate'] = $this->ratingService->getAvgRating($item['id'], 'product');
            $item['soldCount'] = $this->getProductsSoldCount($item['id']);
            $response[] = $this->autoMapping->map('array', ProductsByProductCategoryIdResponse::class, $item);
        }
        return $response;
    }

    public function getProducts()
    {
        $items = $this->productManager->getProducts();
        foreach ($items as $item) {
            $response[] = $this->autoMapping->map('array', ProductsResponse::class, $item);
        }
        return $response;
    }

    public function getProductByIdWithFullInfo($id)
    {
        $item = $this->productManager->getProductByIdWithFullInfo($id);

        if($item['productImage'])
        {
            $item['productImage'] = $this->params . $item['productImage'];
        }

        if($item['image'])
        {
            $item['image'] = $this->params . $item['image'];
        }

        $item['rate'] = $this->ratingService->getAvgRating($item['id'], 'product');

        $item['soldCount'] = $this->getProductsSoldCount($item['id']);

        return $this->autoMapping->map('array', ProductFullInfoResponse::class, $item);
    }

    public function getProductsTopWanted(): ?array
    {
        $response = [];

        $Products = $this->productManager->getProductsTopWanted();

        foreach ($Products as $Product) {
            $img = isset($Product['image']);
            if ($img) {
                $topOwner['imageURL'] = $Product['image'];
            }
            $response[] = $this->autoMapping->map('array', ProductFullInfoResponse::class, $Product);
        }

        return $response;
    }

    public function productsTopWantedOfSpecificStoreOwner($storeOwnerProfileId): ?array
    {
        $response = [];

        $Products = $this->productManager->productsTopWantedOfSpecificStoreOwner($storeOwnerProfileId);

        foreach ($Products as $Product) {
            $img = isset($Product['image']);
            if ($img) {
                $topOwner['imageURL'] = $Product['image'];
            }

            $response[] = $this->autoMapping->map('array', ProductFullInfoResponse::class, $Product);
        }

        return $response;
    }

    public function getStoreProductsByProfileId($storeOwnerProfileId): ?array
    {
        $response = [];
        $items = $this->productManager->getStoreProductsByProfileId($storeOwnerProfileId);
        foreach ($items as $item) {
            $item['image'] = $this->getImageParams($item['productImage'], $this->params.$item['productImage'], $this->params);
            $item['rate'] = $this->ratingService->getAvgRating($item['id'], 'product');
            $item['soldCount'] = $this->getProductsSoldCount($item['id']);
            $response[] = $this->autoMapping->map('array', ProductsByProductCategoryIdResponse::class, $item);
        }
        return $response;
    }

    public function getStoreProducts($userID): ?array
    {
        $response = [];
        $storeOwnerProfileId = $this->userManager->getStoreProfileId($userID);
        $items = $this->productManager->getStoreProducts($storeOwnerProfileId);
        foreach ($items as $item) {
            $item['image'] = $this->getImageParams($item['productImage'], $this->params.$item['productImage'], $this->params);
            $item['rate'] = $this->ratingService->getAvgRating($item['id'], 'product');
            $item['soldCount'] = $this->getProductsSoldCount($item['id']);
            $response[] = $this->autoMapping->map('array', ProductsByProductCategoryIdResponse::class, $item);
        }
        return $response;
    }

    public function getProductsByStoreProductCategoryID($storeProductCategoryID): ?array
    {
        $response = [];
        $items = $this->productManager->getProductsByStoreProductCategoryID($storeProductCategoryID);
        foreach ($items as $item) {

            $item['store'] = $this->storeOwnerProfileService->getStoreNameById($item['storeOwnerProfileID']);
            $item['rate'] = $this->ratingService->getAvgRating($item['id'], 'product');
            $item['image'] = $this->getImageParams($item['productImage'], $this->params.$item['productImage'], $this->params);
            $item['soldCount'] = $this->getProductsSoldCount($item['id']);
            $response[] = $this->autoMapping->map('array', ProductsByProductCategoryIdResponse::class, $item);
        }
        return $response;
    }

    public function getProductsSoldCount($id)
    {
        return $this->productManager->getProductsSoldCount($id);

    }

    public function getProductsByStoreProfileIDAndStoreProductCategoryID($storeOwnerProfileId, $storeProductCategoryID): ?array
    {
        $response = [];
        $items = $this->productManager-> getProductsByStoreProfileIDAndStoreProductCategoryID($storeOwnerProfileId, $storeProductCategoryID);
        foreach ($items as $item) {
            $item['image'] = $this->getImageParams($item['productImage'], $this->params.$item['productImage'], $this->params);
            $response[] = $this->autoMapping->map('array', ProductsByProductCategoryIdResponse::class, $item);
        }
        return $response;
    }

    public function updateProductByAdmin($request)
    {
        $item = $this->productManager->updateProductByAdmin($request);

        return $this->autoMapping->map(ProductEntity::class, ProductCreateResponse::class, $item);
    }

    public function countProducts()
    {
        return $this->productManager->countProducts();
    }

    public function getProductsByName($name)
    {
        return $this->productManager->getProductsByName($name);
    }

    public function createProductByStore(ProductCreateRequest $request, $userID)
    {
        $storeOwnerProfileId = $this->userManager->getStoreProfileId($userID);

        $request->setStoreOwnerProfileID($storeOwnerProfileId['id']);

        $item = $this->productManager->createProductByStore($request);

        return $this->autoMapping->map(ProductEntity::class, ProductCreateResponse::class, $item);
    }

    public function getImageParams($imageURL, $image, $baseURL): array
    {
        $item['imageURL'] = $imageURL;
        $item['image'] = $image;
        $item['baseURL'] = $baseURL;

        return $item;
    }

    public function updateProductByStore($request)
    {
        $item = $this->productManager->updateProductByStore($request);

        return $this->autoMapping->map(ProductEntity::class, ProductCreateResponse::class, $item);
    }

    public function getProductsByStoreCategoryID($storeCategoryID): ?array
    {
        $response = [];

        $storeProductCategoriesIdsLevel1 = $this->productManager->getStoreProductCategoryIdLevel1($storeCategoryID);

        foreach($storeProductCategoriesIdsLevel1 as $item )
        {
//            $item['productCategoryImage'] = $this->getImageParams($item['productCategoryImage'], $this->params . $item['productCategoryImage'], $this->params);

            $item['storeProductCategoriesLevel2'] = $this->getStoreProductCategoryLevel2($item['id']);

            foreach($item['storeProductCategoriesLevel2'] as $value)
            {
                if($value->products)
                {
                   foreach($value->products as $product)
                   {
                       $response[] = $this->autoMapping->map(ProductsByProductCategoryIdResponse::class, ProductsByStoreProductCategoryIdResponse::class, $product);
                   }
                }
            }
        }

        return $response;
    }

    public function getStoreProductCategoryLevel2($storeProductCategoryIdLevel1): array
    {
        $response = [];

        $storeProductCategoriesLevel1 = $this->productManager->getStoreProductCategoryLevel2($storeProductCategoryIdLevel1);

        foreach ($storeProductCategoriesLevel1 as $item)
        {
            $item['productCategoryImage'] = $this->getImageParams($item['productCategoryImage'], $this->params . $item['productCategoryImage'], $this->params);

            $item['products'] = $this->getProductsByStoreProductCategoryID($item['id']);

            $response[] = $this->autoMapping->map('array', StoreProductCategoriesResponse::class, $item);
        }

        return $response;
    }

    public function updateProductStatusByStore($request)
    {
        $item = $this->productManager->updateProductStatusByStore($request);

        return $this->autoMapping->map(ProductEntity::class, ProductCreateResponse::class, $item);
    }
}
