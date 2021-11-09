<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\ProductEntity;
use App\Manager\ProductManager;
use App\Manager\UserManager;
use App\Request\ProductCreateRequest;
use App\Response\ProductCreateResponse;
use App\Response\ProductsResponse;
use App\Response\ProductFullInfoResponse;
use App\Response\ProductsByProductCategoryIdResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class ProductService
{
    private $autoMapping;
    private $productManager;
    private $params;
    private $userManager;

    public function __construct(AutoMapping $autoMapping, ProductManager $productManager, ParameterBagInterface $params, userManager $userManager)
    {
        $this->autoMapping = $autoMapping;
        $this->productManager = $productManager;
        $this->userManager = $userManager;
        $this->params = $params->get('upload_base_url') . '/';
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
            $response[] = $this->autoMapping->map('array', ProductsByProductCategoryIdResponse::class, $item);
        }
        return $response;
    }

    public function getProductsByCategoryIdAndStoreOwnerProfileId($storeProductCategoryID, $storeOwnerProfileId)
    {
        $response = [];
        $items = $this->productManager->getProductsByCategoryIdAndStoreOwnerProfileId($storeProductCategoryID, $storeOwnerProfileId);
        foreach ($items as $item) {
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
            $item['imageURL'] = $item['productImage'];
            $item['image'] = $this->params . $item['productImage'];
            $item['baseURL'] = $this->params;
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
            $response[] = $this->autoMapping->map('array', ProductsByProductCategoryIdResponse::class, $item);
        }
        return $response;
    }

    public function getProductsByStoreProductCategoryID($storeProductCategoryID): ?array
    {
        $response = [];
        $items = $this->productManager->getProductsByStoreProductCategoryID($storeProductCategoryID);
        foreach ($items as $item) {
            $item['image'] = $this->getImageParams($item['productImage'], $this->params.$item['productImage'], $this->params);
            $response[] = $this->autoMapping->map('array', ProductsByProductCategoryIdResponse::class, $item);
        }
        return $response;
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
}