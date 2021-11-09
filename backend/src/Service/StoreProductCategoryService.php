<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\StoreProductCategoryEntity;
use App\Manager\StoreProductCategoryManager;
use App\Request\StoreProductCategoryCreateRequest;
use App\Request\StoreProductCategoryLevelTwoCreateRequest;
use App\Request\StoreProductCategoryUpdateRequest;
use App\Response\StoreProductCategoryCreateResponse;
use App\Response\StoreProductsCategoryLevelTwoAndStoreProductsResponse;
use App\Response\StoreProductsCategoryResponse;
use App\Response\SubCategoriesAndProductsByStoreCategoryIDResponse;
use App\Service\ProductService;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;
use App\Manager\UserManager;


class StoreProductCategoryService
{
    private $autoMapping;
    private $storeProductCategoryManager;
    private $productService;
    private $params;
    private $userManager;

    public function __construct(AutoMapping $autoMapping, StoreProductCategoryManager $storeProductCategoryManager, ProductService $productService, ParameterBagInterface $params, userManager $userManager)
    {
        $this->autoMapping = $autoMapping;
        $this->storeProductCategoryManager = $storeProductCategoryManager;
        $this->userManager = $userManager;
        $this->productService = $productService;
        $this->params = $params->get('upload_base_url') . '/';
    }

    public function createStoreProductCategoryLevelOne(StoreProductCategoryCreateRequest $request)
    {
        $item = $this->storeProductCategoryManager->createStoreProductCategoryLevelOne($request);
         
        return $this->autoMapping->map(StoreProductCategoryEntity::class, StoreProductCategoryCreateResponse::class, $item);
    }

    public function createStoreProductCategoryLevelTwo(StoreProductCategoryLevelTwoCreateRequest $request)
    {
        $item = $this->storeProductCategoryManager->createStoreProductCategoryLevelTwo($request);

        return $this->autoMapping->map(StoreProductCategoryEntity::class, StoreProductCategoryCreateResponse::class, $item);
    }

     public function updateStoreProductCategory(StoreProductCategoryUpdateRequest $request)
     {
         $item = $this->storeProductCategoryManager->updateStoreProductCategory($request);

         return $this->autoMapping->map(StoreProductCategoryEntity::class, StoreProductCategoryCreateResponse::class, $item);
     }

    public function getStoreProductsCategoryForStoreSpecific($storeOwnerProfileId)
    {
        $response = [];
       $items = $this->storeProductCategoryManager->getStoreProductsCategoryForStoreSpecific($storeOwnerProfileId);
       foreach($items as $item) {
            $response[] = $this->autoMapping->map('array', StoreProductsCategoryResponse::class, $item); 
      } 
       return $response;
    }

    public function getStoreProductsCategoryLevelOneByStoreCategoryID($storeCategoryID)
    {
        $response = [];
       $items = $this->storeProductCategoryManager->getStoreProductsCategoryLevelOneByStoreCategoryID($storeCategoryID);
       foreach($items as $item) {
           $item['productCategoryImage'] = $this->getImageParams($item['productCategoryImage'], $this->params.$item['productCategoryImage'], $this->params);

           $response[] = $this->autoMapping->map('array', StoreProductsCategoryResponse::class, $item);
      }
       return $response;
    }

    public function getStoreProductsCategoryLeveltwoByStoreProductCategoryID($storeProductCategoryID)
    {
        $response = [];
       $items = $this->storeProductCategoryManager->getStoreProductsCategoryLevelTwoByStoreProductCategoryID($storeProductCategoryID);
       foreach($items as $item) {
           $item['productCategoryImage'] = $this->getImageParams($item['productCategoryImage'], $this->params.$item['productCategoryImage'], $this->params);

           $response[] = $this->autoMapping->map('array', StoreProductsCategoryResponse::class, $item);
      }
       return $response;
    }

    public function getSubCategoriesAndProductsByStoreCategoryID($storeCategoryID)
    {
       $response = [];
       //productCategoriesLevel1
       $items = $this->storeProductCategoryManager->getStoreProductsCategoryLevelOneByStoreCategoryID($storeCategoryID);

       foreach($items as $item) {
           $item['productCategoriesLevel2'] = $this->storeProductCategoryManager->getStoreProductsCategoryLevelTwoByStoreProductCategoryID($item['id']);
           foreach($item['productCategoriesLevel2'] as $productCategoryLevel2) {
               $item['productCategoriesLevel2']['products'] = $this->productService->getProductsByStoreProductCategoryID($productCategoryLevel2['id']);

           }
           $response[] = $this->autoMapping->map('array', SubCategoriesAndProductsByStoreCategoryIDResponse::class, $item);
       }
       return $response;
    }

    public function getStoreProductsCategoryLevelTwoAndStoreProductsByStoreOwnerProfile($userID) {
        $response = [];
        $storeOwnerProfileId = $this->userManager->getStoreProfileId($userID);
        $productCategoriesLevel2 = $this->storeProductCategoryManager->getStoreProductsCategoryLevelTwoByStoreOwnerProfile($storeOwnerProfileId);
         foreach ($productCategoriesLevel2 as $category) {
             $category['productCategoryImage'] = $this->getImageParams($category['productCategoryImage'], $this->params.$category['productCategoryImage'], $this->params);

             $category['products'] = $this->productService->getProductsByStoreProfileIDAndStoreProductCategoryID($storeOwnerProfileId, $category['id']);
             $response[] = $this->autoMapping->map('array', StoreProductsCategoryLevelTwoAndStoreProductsResponse::class, $category);
         }
        return $response;
    }

    public function getImageParams($imageURL, $image, $baseURL): array
    {
        $item['imageURL'] = $imageURL;
        $item['image'] = $image;
        $item['baseURL'] = $baseURL;

        return $item;
    }
}
