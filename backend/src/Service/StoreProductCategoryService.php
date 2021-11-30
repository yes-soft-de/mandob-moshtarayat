<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\StoreProductCategoryEntity;
use App\Manager\StoreProductCategoryManager;
use App\Request\StoreProductCategoryCreateRequest;
use App\Request\StoreProductCategoryLevelOneUpdateRequest;
use App\Request\StoreProductCategoryLevelTwoCreateRequest;
use App\Request\StoreProductCategoryLevelTwoUpdateRequest;
use App\Response\ProductsByProductCategoryIdForStoreResponse;
use App\Response\ProductsByProductCategoryIdResponse;
use App\Response\StoreProductCategoryLevelOneCreateResponse;
use App\Response\StoreProductCategoryLevelTwoCreateResponse;
use App\Response\StoreProductCategoryUpdateLevelOneResponse;
use App\Response\StoreProductCategoryUpdateLevelTwoResponse;
use App\Response\StoreProductsCategoriesResponse;
use App\Response\StoreProductsCategoryAndProductsResponse;
use App\Response\StoreProductsCategoryLevelTwoAndStoreProductsResponse;
use App\Response\StoreProductsCategoryResponse;
use App\Response\StoreProductsCategoryWithProductsResponse;
use App\Response\SubCategoriesAndProductsByStoreCategoryIDResponse;
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
         
        return $this->autoMapping->map(StoreProductCategoryEntity::class, StoreProductCategoryLevelOneCreateResponse::class, $item);
    }

    public function createStoreProductCategoryLevelTwo(StoreProductCategoryLevelTwoCreateRequest $request)
    {
        $item = $this->storeProductCategoryManager->createStoreProductCategoryLevelTwo($request);

        return $this->autoMapping->map(StoreProductCategoryEntity::class, StoreProductCategoryLevelTwoCreateResponse::class, $item);
    }

     public function updateStoreProductCategoryLevelOne(StoreProductCategoryLevelOneUpdateRequest $request)
     {
         $item = $this->storeProductCategoryManager->updateStoreProductCategoryLevelOne($request);

         return $this->autoMapping->map(StoreProductCategoryEntity::class, StoreProductCategoryUpdateLevelOneResponse::class, $item);
     }

     public function updateStoreProductCategoryLevelTwo(StoreProductCategoryLevelTwoUpdateRequest $request)
     {
         $item = $this->storeProductCategoryManager->updateStoreProductCategoryLevelTwo($request);

         return $this->autoMapping->map(StoreProductCategoryEntity::class, StoreProductCategoryUpdateLevelTwoResponse::class, $item);
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

       $items = $this->storeProductCategoryManager->getSubCategoriesByStoreCategoryID($storeCategoryID);

       foreach($items as $item) {
           $item['productCategoryImage'] = $this->getImageParams($item['productCategoryImage'], $this->params.$item['productCategoryImage'], $this->params);

           $response[] = $this->autoMapping->map('array', StoreProductsCategoryResponse::class, $item);
      }
       return $response;
    }

    public function getStoreProductsCategoryLevelOneByStoreCategoryIDFroAdmin($storeCategoryID)
    {
       $response = [];

       $items = $this->storeProductCategoryManager->getSubCategoriesByStoreCategoryID($storeCategoryID);

       foreach($items as $item)
       {
           if($item['productCategoryImage'])
           {
               $item['productCategoryImage'] = $this->getImageParams($item['productCategoryImage'], $this->params . $item['productCategoryImage'], $this->params);
           }
           else
           {
               $item['productCategoryImage'] = $this->getImageParams($item['productCategoryImage'], $item['productCategoryImage'], $this->params);
           }

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

    public function getStoreProductsCategoryLeveltwoAndProductsByStoreProductCategoryIDAndStoreOwnerProfileId($storeProductCategoryID, $storeOwnerProfileId)
    {
       $response = [];

       $items = $this->storeProductCategoryManager->getStoreProductsCategoryLevelTwoByStoreProductCategoryID($storeProductCategoryID);

       foreach($items as $item) {
           $item['productCategoryImage'] = $this->getImageParams($item['productCategoryImage'], $this->params.$item['productCategoryImage'], $this->params);
           $item['products'] = $this->productService->getProductsByStoreProfileIDAndStoreProductCategoryID($storeOwnerProfileId, $item['id']);

           $response[] = $this->autoMapping->map('array', StoreProductsCategoryAndProductsResponse::class, $item);
      }
       return $response;
    }

    public function getStoreProductsCategoryLevelTwoByStoreProductCategoryIDForAdmin($storeProductCategoryID)
    {
       $response = [];

       $items = $this->storeProductCategoryManager->getStoreProductsCategoryLevelTwoByStoreProductCategoryID($storeProductCategoryID);

       foreach($items as $item)
       {
           if($item['productCategoryImage'])
           {
               $item['productCategoryImage'] = $this->getImageParams($item['productCategoryImage'], $this->params.$item['productCategoryImage'], $this->params);
           }
           else
           {
               $item['productCategoryImage'] = $this->getImageParams($item['productCategoryImage'], $item['productCategoryImage'], $this->params);
           }

           $response[] = $this->autoMapping->map('array', StoreProductsCategoryResponse::class, $item);
       }

       return $response;
    }

    public function getSubCategoriesByStoreCategoryID($storeCategoryID)
    {
       $response = [];

       //productCategoriesLevel1
       $items = $this->storeProductCategoryManager->getSubCategoriesByStoreCategoryID($storeCategoryID);

       foreach($items as $item) {
           $item['productCategoryImage'] = $this->getImageParams($item['productCategoryImage'], $this->params.$item['productCategoryImage'], $this->params);
           $item['productCategoriesLevel2'] = $this->getStoreProductsCategoryLeveltwoByStoreProductCategoryID($item['id']);

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

    public function getStoreProductsCategoriesAndProductsByStoreOwnerProfileID($userID): array
    {
        $response = [];

        $storeOwnerProfileId = $this->userManager->getStoreProfileId($userID);

        $categoriesIdsLevel1 = $this->storeProductCategoryManager->getStoreProductsCategoriesIdLevelOneByStoreOwnerProfileID($storeOwnerProfileId);

        foreach($categoriesIdsLevel1 as $id) {
            $categoriesLevel1 = $this->storeProductCategoryManager->getCategoriesLevel1ById($id['storeProductCategoryID']);

            foreach($categoriesLevel1 as $item) {
                $item['productCategoryImage'] = $this->getImageParams($item['productCategoryImage'], $this->params.$item['productCategoryImage'], $this->params);
                $item['productCategoriesLevel2'] = $this->getStoreProductsCategoryLeveltwoAndProductsByStoreProductCategoryIDAndStoreOwnerProfileId($item['id'], $storeOwnerProfileId);

                $response[] = $this->autoMapping->map('array', StoreProductsCategoriesResponse::class, $item);
            }
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

    public function getStoreProductsCategoryLevelTwoWithProductsByStoreProductCategoryID($storeProductCategoryID)
    {
        $response = [];

        $items = $this->storeProductCategoryManager->getStoreProductsCategoryLevelTwoByStoreProductCategoryID($storeProductCategoryID);

        foreach($items as $item)
        {
            $item['products'] = $this->productService->getProductsByProductCategoryId($item['id']);

            if($item['products'])
            {
                foreach($item['products'] as $product)
                {
                    $response[] = $this->autoMapping->map(ProductsByProductCategoryIdResponse::class, StoreProductsCategoryWithProductsResponse::class, $product);
                }
            }
        }

        return $response;
    }

    public function getProductsByStoreCategroyLevelOne($storeProductCategoryID, $userID)
    {
        $response = [];

        $storeOwnerProfileID = $this->userManager->getStoreProfileId($userID);

        $products = $this->productService->getProductsByCategoryIdAndStoreOwnerProfileId($storeProductCategoryID, $storeOwnerProfileID);

        foreach($products as $product)
        {
            $response[] = $this->autoMapping->map(ProductsByProductCategoryIdResponse::class, ProductsByProductCategoryIdForStoreResponse::class, $product);
        }

        return $response;
    }

}
