<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\StoreProductCategoryEntity;
use App\Manager\StoreProductCategoryManager;
use App\Request\FilterStoreProductCategoryLevelOne;
use App\Request\FilterStoreProductCategoryLevelTwo;
use App\Request\StoreProductCategoryCreateRequest;
use App\Request\StoreProductCategoryLevelOneUpdateRequest;
use App\Request\StoreProductCategoryLevelTwoCreateRequest;
use App\Request\StoreProductCategoryLevelTwoUpdateRequest;
use App\Request\StoreProductCategoryTranslationCreateRequest;
use App\Request\StoreProductCategoryTranslationUpdateRequest;
use App\Request\StoreProductCategoryWithTranslationCreateRequest;
use App\Request\StoreProductCategoryWithTranslationUpdateRequest;
use App\Response\ProductsByProductCategoryIdForStoreResponse;
use App\Response\ProductsByProductCategoryIdResponse;
use App\Response\StoreProductCategoryByIdResponse;
use App\Response\StoreProductCategoryLevelOneCreateResponse;
use App\Response\StoreProductCategoryLevelTwoCreateResponse;
use App\Response\StoreProductCategoryTranslationGetResponse;
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
    private $storeProductCategoryTranslationService;
    private $params;
    private $userManager;
    private $primaryLanguage;

    public function __construct(AutoMapping $autoMapping, StoreProductCategoryManager $storeProductCategoryManager, ProductService $productService, ParameterBagInterface $params, userManager $userManager,
     StoreProductCategoryTranslationService $storeProductCategoryTranslationService)
    {
        $this->autoMapping = $autoMapping;
        $this->storeProductCategoryManager = $storeProductCategoryManager;
        $this->userManager = $userManager;
        $this->productService = $productService;
        $this->storeProductCategoryTranslationService = $storeProductCategoryTranslationService;
        $this->params = $params->get('upload_base_url') . '/';
        $this->primaryLanguage = $params->get('primary_language');
    }

    public function createStoreProductCategoryLevelOne(StoreProductCategoryWithTranslationCreateRequest $request)
    {
        // First insert the data in the primary language
        $storeProductCategoryCreateRequest = $this->autoMapping->map('array', StoreProductCategoryCreateRequest::class, $request->getData());

        $entity = $this->storeProductCategoryManager->createStoreProductCategoryLevelOne($storeProductCategoryCreateRequest);

        // Secondly, insert the translation data
        if($request->getTranslate())
        {
            $this->createStoreProductCategoryTranslation($request->getTranslate(), $entity->getId());
        }

        return $this->autoMapping->map(StoreProductCategoryEntity::class, StoreProductCategoryLevelOneCreateResponse::class, $entity);
    }

    public function createStoreProductCategoryTranslation($translationArrayRequest, $storeProductCategoryID)
    {
        if($translationArrayRequest)
        {
            foreach($translationArrayRequest as $translationRequest)
            {
                $storeProductCategoryTranslationCreateRequest = $this->autoMapping->map('array', StoreProductCategoryTranslationCreateRequest::class, $translationRequest);

                $storeProductCategoryTranslationCreateRequest->setStoreProductCategoryID($storeProductCategoryID);

                $this->storeProductCategoryTranslationService->createStoreProductCategoryTranslation($storeProductCategoryTranslationCreateRequest);
            }
        }
        else
        {
            // No translations were provided!
            // Skip inserting translations
        }
    }

    public function createStoreProductCategoryLevelTwo(StoreProductCategoryWithTranslationCreateRequest $request)
    {
        // First insert the data in the primary language
        $storeProductCategoryCreateRequest = $this->autoMapping->map('array', StoreProductCategoryLevelTwoCreateRequest::class, $request->getData());

        $entity = $this->storeProductCategoryManager->createStoreProductCategoryLevelTwo($storeProductCategoryCreateRequest);

        // Secondly, insert the translation data
        if($request->getTranslate())
        {
            $this->createStoreProductCategoryTranslation($request->getTranslate(), $entity->getId());
        }

        return $this->autoMapping->map(StoreProductCategoryEntity::class, StoreProductCategoryLevelTwoCreateResponse::class, $entity);
    }

     public function updateStoreProductCategoryLevelOne(StoreProductCategoryWithTranslationUpdateRequest $request)
     {
         // First, update the content in the primary language
         $storeProductCategoryUpdateRequest = $this->autoMapping->map('array', StoreProductCategoryLevelOneUpdateRequest::class, $request->getData());

         //Second, update the translation data
         if($request->getTranslate())
         {
             $this->updateStoreProductCategoryLevelOneTranslation($request->getTranslate());

             // pass the store product category name in primary language to the entity being updated
             $storeProductCategoryEntity = $this->storeProductCategoryManager->getStoreProductCategoryEntityByID($storeProductCategoryUpdateRequest->getId());

             if($storeProductCategoryEntity)
             {
                 $storeProductCategoryUpdateRequest->setProductCategoryName($storeProductCategoryEntity->getProductCategoryName());
             }
         }

         $item = $this->storeProductCategoryManager->updateStoreProductCategoryLevelOne($storeProductCategoryUpdateRequest);

         return $this->autoMapping->map(StoreProductCategoryEntity::class, StoreProductCategoryUpdateLevelOneResponse::class, $item);
     }

     public function updateStoreProductCategoryLevelOneTranslation($translationArrayRequest)
     {
         if($translationArrayRequest)
         {
             foreach($translationArrayRequest as $translationRequest)
             {
                 $storeProductCategoryTranslationUpdateRequest = $this->autoMapping->map('array', StoreProductCategoryTranslationUpdateRequest::class, $translationRequest);

                 $this->storeProductCategoryTranslationService->updateStoreProductCategoryTranslationByStoreProductCategoryIdAndLanguage($storeProductCategoryTranslationUpdateRequest);
             }
         }
     }

     public function updateStoreProductCategoryLevelTwoTranslation($translationArrayRequest)
     {
         if($translationArrayRequest)
         {
             foreach($translationArrayRequest as $translationRequest)
             {
                 $storeProductCategoryTranslationUpdateRequest = $this->autoMapping->map('array', StoreProductCategoryTranslationUpdateRequest::class, $translationRequest);

                 $this->storeProductCategoryTranslationService->updateStoreProductCategoryTranslationByStoreProductCategoryIdAndLanguage($storeProductCategoryTranslationUpdateRequest);
             }
         }
     }

     public function updateStoreProductCategoryLevelTwo(StoreProductCategoryWithTranslationUpdateRequest $request)
     {
         // First, update the content in the primary language
         $storeProductCategoryUpdateRequest = $this->autoMapping->map('array', StoreProductCategoryLevelTwoUpdateRequest::class, $request->getData());

         //Second, update the translation data
         if($request->getTranslate())
         {
             $this->updateStoreProductCategoryLevelTwoTranslation($request->getTranslate());

             // pass the store product category name in primary language to the entity being updated
             $storeProductCategoryEntity = $this->storeProductCategoryManager->getStoreProductCategoryEntityByID($storeProductCategoryUpdateRequest->getId());

             if($storeProductCategoryEntity)
             {
                 $storeProductCategoryUpdateRequest->setProductCategoryName($storeProductCategoryEntity->getProductCategoryName());
             }
         }

         $item = $this->storeProductCategoryManager->updateStoreProductCategoryLevelTwo($storeProductCategoryUpdateRequest);

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

    public function getStoreProductCategoryStoreSpecific($storeOwnerProfileId)
    {
       $response = [];

       $items = $this->storeProductCategoryManager->getStoreProductCategoryStoreSpecific($storeOwnerProfileId);

       foreach($items as $item) {
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

    public function getStoreProductsCategoryLevelOneByStoreCategoryID($userLocale, $storeCategoryID)
    {
        $response = [];

        if($userLocale != null && $userLocale != $this->primaryLanguage)
        {
            $storeProductCategoriesTranslation = $this->storeProductCategoryTranslationService->getByStoreCategoryIdAndLanguage($storeCategoryID, $userLocale);

            foreach($storeProductCategoriesTranslation as $storeProductCategoryTranslation)
            {
                $response[] = $this->autoMapping->map(StoreProductCategoryTranslationGetResponse::class, StoreProductsCategoryResponse::class, $storeProductCategoryTranslation);
            }
        }
        else
        {
            $items = $this->storeProductCategoryManager->getSubCategoriesByStoreCategoryID($storeCategoryID);

            foreach($items as $item) {
                $item['productCategoryImage'] = $this->getImageParams($item['productCategoryImage'], $this->params.$item['productCategoryImage'], $this->params);

                $response[] = $this->autoMapping->map('array', StoreProductsCategoryResponse::class, $item);
            }
        }

        return $response;
    }

    public function getStoreProductsCategoryLevelOneByStoreCategoryIDFroAdmin(FilterStoreProductCategoryLevelOne $request)
    {
       $response = [];

       if($request->getLanguage() && $request->getLanguage() != $this->primaryLanguage)
       {
           $storeProductCategories = $this->storeProductCategoryTranslationService->getByStoreCategoryIdAndLanguage($request->getStoreCategoryID(), $request->getLanguage());

           foreach($storeProductCategories as $storeProductCategory)
           {
               $response[] = $this->autoMapping->map(StoreProductCategoryTranslationGetResponse::class, StoreProductsCategoryResponse::class, $storeProductCategory);
           }
       }
       else
       {
           $storeProductCategories = $this->storeProductCategoryManager->getSubCategoriesByStoreCategoryID($request->getStoreCategoryID());

           foreach($storeProductCategories as $productCategory)
           {
               if($productCategory['productCategoryImage'])
               {
                   $productCategory['productCategoryImage'] = $this->getImageParams($productCategory['productCategoryImage'], $this->params . $productCategory['productCategoryImage'], $this->params);
               }
               else
               {
                   $productCategory['productCategoryImage'] = $this->getImageParams($productCategory['productCategoryImage'], $productCategory['productCategoryImage'], $this->params);
               }

               $response[] = $this->autoMapping->map('array', StoreProductsCategoryResponse::class, $productCategory);
           }
       }

       return $response;
    }

    public function getStoreProductsCategoryLeveltwoByStoreProductCategoryID($userLocale, $storeProductCategoryID)
    {
        $response = [];

        if($userLocale != null && $userLocale != $this->primaryLanguage)
        {
            $storeProductCategoriesTranslation = $this->storeProductCategoryTranslationService->getStoreProductCategoriesTranslationsByStoreProductCategoryIdAndLanguage($storeProductCategoryID, $userLocale);

            foreach($storeProductCategoriesTranslation as $storeProductCategoryTranslation)
            {
                $response[] = $this->autoMapping->map(StoreProductCategoryTranslationGetResponse::class, StoreProductsCategoryResponse::class, $storeProductCategoryTranslation);
            }
        }
        else
        {
            $items = $this->storeProductCategoryManager->getStoreProductsCategoryLevelTwoByStoreProductCategoryID($storeProductCategoryID);

            foreach ($items as $item) {
                $item['productCategoryImage'] = $this->getImageParams($item['productCategoryImage'], $this->params . $item['productCategoryImage'], $this->params);

                $response[] = $this->autoMapping->map('array', StoreProductsCategoryResponse::class, $item);
            }
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

    public function getStoreProductsCategoryLevelTwoByStoreProductCategoryIDForAdmin(FilterStoreProductCategoryLevelTwo $request)
    {
        $response = [];

        if($request->getLanguage() && $request->getLanguage() != $this->primaryLanguage)
        {
            $storeProductCategories = $this->storeProductCategoryTranslationService->getStoreProductCategoriesTranslationsByStoreProductCategoryIdAndLanguage($request->getStoreProductCategoryID(),
                 $request->getLanguage());

            foreach($storeProductCategories as $storeProductCategory)
            {
                $response[] = $this->autoMapping->map(StoreProductCategoryTranslationGetResponse::class, StoreProductsCategoryResponse::class, $storeProductCategory);
            }
        }
        else
        {
            $items = $this->storeProductCategoryManager->getStoreProductsCategoryLevelTwoByStoreProductCategoryID($request->getStoreProductCategoryID());

            foreach ($items as $item) {
                if ($item['productCategoryImage']) {
                    $item['productCategoryImage'] = $this->getImageParams($item['productCategoryImage'], $this->params . $item['productCategoryImage'], $this->params);
                } else {
                    $item['productCategoryImage'] = $this->getImageParams($item['productCategoryImage'], $item['productCategoryImage'], $this->params);
                }

                $response[] = $this->autoMapping->map('array', StoreProductsCategoryResponse::class, $item);
            }
        }

        return $response;
    }

    public function getSubCategoriesByStoreCategoryID($userLocale, $storeCategoryID)
    {
       $response = [];

       //productCategoriesLevel1
       if($userLocale != null && $userLocale != $this->primaryLanguage)
       {
           $storeProductCategoriesTranslation = $this->storeProductCategoryTranslationService->getByStoreCategoryIdAndLanguage($storeCategoryID, $userLocale);

           foreach($storeProductCategoriesTranslation as $storeProductCategory)
           {
               $temporaryItem = $this->autoMapping->map(StoreProductCategoryTranslationGetResponse::class, SubCategoriesAndProductsByStoreCategoryIDResponse::class, $storeProductCategory);

               // temporaryItem was created just to do the following statement
               $temporaryItem->productCategoriesLevel2 = $this->getStoreProductsCategoryLeveltwoByStoreProductCategoryID($userLocale, $storeProductCategory->storeProductCategoryID);

               $response[] = $temporaryItem;
           }
       }
       else
       {
           $items = $this->storeProductCategoryManager->getSubCategoriesByStoreCategoryID($storeCategoryID);

           foreach ($items as $item) {
               $item['productCategoryImage'] = $this->getImageParams($item['productCategoryImage'], $this->params . $item['productCategoryImage'], $this->params);
               $item['productCategoriesLevel2'] = $this->getStoreProductsCategoryLeveltwoByStoreProductCategoryID($this->primaryLanguage, $item['id']);

               $response[] = $this->autoMapping->map('array', SubCategoriesAndProductsByStoreCategoryIDResponse::class, $item);
           }
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
        if($imageURL)
        {
            $item['image'] = $image;
        }
        else
        {
            $item['image'] = $imageURL;
        }

        $item['imageURL'] = $imageURL;
        $item['baseURL'] = $baseURL;

        return $item;
    }

    public function getStoreProductsCategoryLevelTwoWithProductsByStoreProductCategoryID($storeProductCategoryID)
    {
        $response = [];

        $items = $this->storeProductCategoryManager->getStoreProductsCategoryLevelTwoByStoreProductCategoryID($storeProductCategoryID);

        foreach($items as $item)
        {
            $item['products'] = $this->productService->getActiveProductsByProductCategoryId($item['id']);

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

    public function getProductsByStoreCategroyLevelOne($userLocale, $storeProductCategoryID, $userID)
    {
        $response = [];

        $storeOwnerProfileID = $this->userManager->getStoreProfileId($userID);

        // First, get the direct products of the store product category level one
        $products = $this->productService->getProductsByCategoryIdAndStoreOwnerProfileId($userLocale, $storeProductCategoryID, $storeOwnerProfileID);

        foreach($products as $product)
        {
            $response[] = $this->autoMapping->map(ProductsByProductCategoryIdResponse::class, ProductsByProductCategoryIdForStoreResponse::class, $product);
        }

        //Then, get the products of the store product category level two of the store product category level one
        $items = $this->storeProductCategoryManager->getStoreProductsCategoryLevelTwoByStoreProductCategoryID($storeProductCategoryID);

        foreach($items as $item)
        {
            $item['products'] = $this->productService->getProductsByCategoryIdAndStoreOwnerProfileId($userLocale, $item['id'], $storeOwnerProfileID);

            if($item['products'])
            {
                foreach($item['products'] as $product)
                {
                    $response[] = $this->autoMapping->map(ProductsByProductCategoryIdResponse::class, ProductsByProductCategoryIdForStoreResponse::class, $product);
                }
            }
        }

        return $response;
    }

    public function deleteStoreProductCategoryByID($request)
    {
        $isRelated = $this->storeProductCategoryManager->isItRelatedToProductsOrOtherCategory($request->getID());
        if($isRelated == "not related") {
            $result = $this->storeProductCategoryManager->deleteStoreProductCategoryByID($request);

            if ($result == 'storeProductCategoryNotFound') {
                return $result;
            }
            else {
                return $this->autoMapping->map(StoreProductCategoryEntity::class, StoreProductCategoryByIdResponse::class, $result);
            }
        }
        return $isRelated;
    }
}
