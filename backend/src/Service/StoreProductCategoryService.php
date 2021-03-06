<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\StoreProductCategoryEntity;
use App\Manager\StoreProductCategoryManager;
use App\Request\FilterStoreProductCategoryLevelOne;
use App\Request\FilterStoreProductCategoryLevelTwo;
use App\Request\StoreProductCategoriesLevelOneAllGetRequest;
use App\Request\StoreProductCategoriesLevelTwoAllGetRequest;
use App\Request\StoreProductCategoryCreateRequest;
use App\Request\StoreProductCategoryLevelOneUpdateRequest;
use App\Request\StoreProductCategoryLevelTwoCreateRequest;
use App\Request\StoreProductCategoryLevelTwoUpdateRequest;
use App\Request\StoreProductCategoryTranslationCreateRequest;
use App\Request\StoreProductCategoryTranslationUpdateRequest;
use App\Request\StoreProductCategoryWithTranslationCreateRequest;
use App\Request\StoreProductCategoryWithTranslationUpdateRequest;
use App\Request\SubCategoriesWithLinkedMarkRequest;
use App\Response\ProductsByProductCategoryIdAndStoreOwnerProfileIdForDashboardResponse;
use App\Response\ProductsByProductCategoryIdAndStoreOwnerProfileIdResponse;
use App\Response\ProductsByProductCategoryIdForStoreResponse;
use App\Response\ProductsByProductCategoryIdResponse;
use App\Response\StoreProductCategoryLevelOneAllGetForStoreResponse;
use App\Response\StoreProductCategoryLevelOneAllGetResponse;
use App\Response\StoreProductCategoryByIdResponse;
use App\Response\StoreProductCategoryLevelOneCreateResponse;
use App\Response\StoreProductCategoryLevelTwoAllGetResponse;
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
use App\Response\SubCategoriesWithLinkedMarkResponse;
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
            $storeProductCategoriesTranslations = $this->storeProductCategoryManager->getSubCategoriesTranslationsByStoreCategoryID($storeCategoryID);

            $items = $this->replaceStoreProductCategoryTranslatedNameByPrimaryOne($storeProductCategoriesTranslations, $userLocale);
        }
        else
        {
            $items = $this->storeProductCategoryManager->getSubCategoriesByStoreCategoryID($storeCategoryID);
        }

        foreach($items as $item) {
            $item['productCategoryImage'] = $this->getImageParams($item['productCategoryImage'], $this->params.$item['productCategoryImage'], $this->params);

            $response[] = $this->autoMapping->map('array', StoreProductsCategoryResponse::class, $item);
        }

        return $response;
    }

    public function getAllStoreProductCategoriesLevelOneForStore($userLocale)
    {
        $response = [];

        if($userLocale != null && $userLocale != $this->primaryLanguage)
        {
            $storeProductCategoriesTranslations = $this->storeProductCategoryManager->getAllStoreProductCategoriesLevelOneTranslations();

            $items = $this->replaceStoreProductCategoryTranslatedNameByPrimaryOne($storeProductCategoriesTranslations, $userLocale);
        }
        else
        {
            $items = $this->storeProductCategoryManager->getAllStoreProductCategoriesLevelOne();
        }

        foreach($items as $item) {
            $item['productCategoryImage'] = $this->getImageParams($item['productCategoryImage'], $this->params.$item['productCategoryImage'], $this->params);

            $response[] = $this->autoMapping->map('array', StoreProductCategoryLevelOneAllGetForStoreResponse::class, $item);
        }

        return $response;
    }

    public function getStoreProductsCategoryLevelOneByStoreCategoryIDFroAdmin(FilterStoreProductCategoryLevelOne $request)
    {
       $response = [];

       if($request->getLanguage() && $request->getLanguage() != $this->primaryLanguage)
       {
           if ($request->getStoreCategoryID()) {

               $storeProductCategoriesTranslations = $this->storeProductCategoryManager->getSubCategoriesTranslationsByStoreCategoryID($request->getStoreCategoryID());
           } else {

               $storeProductCategoriesTranslations = $this->storeProductCategoryManager->getAllStoreProductCategoriesLevelOneTranslations();
           }

           $storeProductCategories = $this->replaceStoreProductCategoryTranslatedNameByPrimaryOne($storeProductCategoriesTranslations, $request->getLanguage());
       }
       else
       {
           if ($request->getStoreCategoryID()) {

               $storeProductCategories = $this->storeProductCategoryManager->getSubCategoriesByStoreCategoryID($request->getStoreCategoryID());
           } else {

               $storeProductCategories = $this->storeProductCategoryManager->getAllStoreProductCategoriesLevelOne();
           }
       }

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

       return $response;
    }

    public function getStoreProductsCategoryLeveltwoByStoreProductCategoryID($userLocale, $storeProductCategoryID)
    {
        $response = [];

        if($userLocale != null && $userLocale != $this->primaryLanguage)
        {
            $storeProductCategoriesTranslations = $this->storeProductCategoryManager->getStoreProductsCategoryLevelTwoTranslationsByStoreProductCategoryID($storeProductCategoryID);

            $items = $this->replaceStoreProductCategoryTranslatedNameByPrimaryOne($storeProductCategoriesTranslations, $userLocale);
        }
        else
        {
            $items = $this->storeProductCategoryManager->getOnlyStoreProductsCategoryLevelTwoByStoreProductCategoryLevelOneID($storeProductCategoryID);
        }

        foreach ($items as $item) {
            $item['productCategoryImage'] = $this->getImageParams($item['productCategoryImage'], $this->params . $item['productCategoryImage'], $this->params);

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

    public function getStoreProductsCategoryLevelTwoByStoreProductCategoryIDForAdmin(FilterStoreProductCategoryLevelTwo $request)
    {
        $response = [];

        if($request->getLanguage() && $request->getLanguage() != $this->primaryLanguage)
        {
            if ($request->getStoreProductCategoryID()) {

                $storeProductCategoriesTranslations = $this->storeProductCategoryManager->getStoreProductsCategoryLevelTwoTranslationsByStoreProductCategoryID($request->getStoreProductCategoryID());
            } else {

                $storeProductCategoriesTranslations = $this->storeProductCategoryManager->getAllStoreProductCategoriesLevelTwoTranslations();
            }

            $items = $this->replaceStoreProductCategoryTranslatedNameByPrimaryOne($storeProductCategoriesTranslations, $request->getLanguage());
        }
        else
        {
            if ($request->getStoreProductCategoryID()) {

                $items = $this->storeProductCategoryManager->getOnlyStoreProductsCategoryLevelTwoByStoreProductCategoryLevelOneID($request->getStoreProductCategoryID());
            } else {

                $items = $this->storeProductCategoryManager->getAllStoreProductCategoriesLevelTwo();
            }
        }

        foreach ($items as $item) {
            if ($item['productCategoryImage']) {
                $item['productCategoryImage'] = $this->getImageParams($item['productCategoryImage'], $this->params . $item['productCategoryImage'], $this->params);
            } else {
                $item['productCategoryImage'] = $this->getImageParams($item['productCategoryImage'], $item['productCategoryImage'], $this->params);
            }

            $response[] = $this->autoMapping->map('array', StoreProductsCategoryResponse::class, $item);
        }

        return $response;
    }

    public function getSubCategoriesByStoreCategoryID($userLocale, $storeCategoryID)
    {
       $response = [];

       //productCategoriesLevel1
       if($userLocale != null && $userLocale != $this->primaryLanguage)
       {
           $storeProductCategoriesTranslations = $this->storeProductCategoryManager->getSubCategoriesTranslationsByStoreCategoryID($storeCategoryID);

           $items = $this->replaceStoreProductCategoryTranslatedNameByPrimaryOne($storeProductCategoriesTranslations, $userLocale);
       }
       else
       {
           $items = $this->storeProductCategoryManager->getSubCategoriesByStoreCategoryID($storeCategoryID);
       }

        foreach ($items as $item) {
            $item['productCategoryImage'] = $this->getImageParams($item['productCategoryImage'], $this->params . $item['productCategoryImage'], $this->params);

            $item['productCategoriesLevel2'] = $this->getStoreProductsCategoryLeveltwoByStoreProductCategoryID($userLocale, $item['id']);

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
            $categoriesLevel1 = $this->storeProductCategoryManager->getCategoriesLevel1ById($id[1]);

            foreach($categoriesLevel1 as $item) {
                $item['productCategoryImage'] = $this->getImageParams($item['productCategoryImage'], $this->params.$item['productCategoryImage'], $this->params);
                $item['productCategoriesLevel2'] = $this->getStoreProductsCategoryLeveltwoAndProductsByStoreProductCategoryIDAndStoreOwnerProfileId($item['id'], $storeOwnerProfileId);

                $response[] = $this->autoMapping->map('array', StoreProductsCategoriesResponse::class, $item);
            }
        }

        return $response;
    }

    public function getStoreProductCategoryByID($userLocale, $storeProductCategoryID)
    {
        if ($userLocale != null && $userLocale != $this->primaryLanguage)
        {
            $categoryTranslationResult = $this->storeProductCategoryManager->getStoreProductCategoryTranslationByStoreProductCategoryIdAndLanguage($storeProductCategoryID, $userLocale);

            if($categoryTranslationResult)
            {
                $storeProductCategory = $categoryTranslationResult;
            }
            else
            {
                $storeProductCategory = $this->storeProductCategoryManager->getStoreProductCategoryByID($storeProductCategoryID);
            }
        }
        else
        {
            $storeProductCategory = $this->storeProductCategoryManager->getStoreProductCategoryByID($storeProductCategoryID);
        }

        if ($storeProductCategory)
        {
            $storeProductCategory['productCategoryImage'] = $this->getImageParams($storeProductCategory['productCategoryImage'], $this->params . $storeProductCategory['productCategoryImage'], $this->params);
        }

        $storeProductCategory['translate'] = $this->storeProductCategoryManager->getStoreProductCategoryTranslationsByStoreProductCategoryID($storeProductCategoryID);

        return $this->autoMapping->map('array', StoreProductCategoryByIdResponse::class, $storeProductCategory);
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

    public function getStoreProductsCategoryLevelTwoWithProductsByStoreProductCategoryID($userLocale, $storeProductCategoryID)
    {
        $response = [];

        $items = $this->storeProductCategoryManager->getStoreProductsCategoryLevelTwoByStoreProductCategoryID($storeProductCategoryID);

        foreach($items as $item)
        {
            $item['products'] = $this->productService->getActiveProductsByProductCategoryId($userLocale, $item['id']);

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
        $products = $this->productService->getProductsByCategoryIdAndStoreOwnerProfileIdForStore($userLocale, $storeProductCategoryID, $storeOwnerProfileID);

        foreach($products as $product)
        {
            $response[] = $this->autoMapping->map(ProductsByProductCategoryIdResponse::class, ProductsByProductCategoryIdForStoreResponse::class, $product);
        }

        // Then, get the store product categories level two of the store product category level one id
        $storeProductCategoriesLevelTwo = $this->storeProductCategoryManager->getOnlyStoreProductsCategoryLevelTwoByStoreProductCategoryLevelOneID($storeProductCategoryID);

        if ($storeProductCategoriesLevelTwo)
        {
            foreach ($storeProductCategoriesLevelTwo as $storeProductCategoryLevelTwo)
            {
                $products = $this->productService->getProductsByStoreProductCategoryLevelTwo($userLocale, $storeProductCategoryLevelTwo['id'], $storeOwnerProfileID);

                foreach($products as $product)
                {
                    $response[] = $this->autoMapping->map(ProductsByProductCategoryIdResponse::class, ProductsByProductCategoryIdForStoreResponse::class, $product);
                }
            }
        }

        return $response;
    }

    // For Dashboard
    public function getProductsByStoreCategroyLevelOneIdAndStoreOwnerProfileID($userLocale, $storeProductCategoryID, $storeOwnerProfileID)
    {
        $response = [];

        // First, get the direct products of the store product category level one
        $products = $this->productService->getProductsByCategoryIdAndStoreOwnerProfileIdForAdmin($userLocale, $storeProductCategoryID, $storeOwnerProfileID);

        foreach($products as $product)
        {
            $response[] = $this->autoMapping->map(ProductsByProductCategoryIdAndStoreOwnerProfileIdResponse::class, ProductsByProductCategoryIdAndStoreOwnerProfileIdForDashboardResponse::class, $product);
        }

        //Then, get the products of the store product category level two of the store product category level one
        $items = $this->storeProductCategoryManager->getStoreProductsCategoryLevelTwoByStoreProductCategoryIdForAdmin($storeProductCategoryID);

        foreach($items as $item)
        {
            $item['products'] = $this->productService->getProductsByCategoryIdAndStoreOwnerProfileIdForAdmin($userLocale, $item['id'], $storeOwnerProfileID);

            if($item['products'])
            {
                foreach($item['products'] as $product)
                {
                    $response[] = $this->autoMapping->map(ProductsByProductCategoryIdAndStoreOwnerProfileIdResponse::class, ProductsByProductCategoryIdAndStoreOwnerProfileIdForDashboardResponse::class, $product);
                }
            }
        }

        return $response;
    }

    public function deleteStoreProductCategoryByID($request)
    {
        $isRelated = $this->storeProductCategoryManager->isItRelatedToProductsOrOtherCategory($request->getId());
        if($isRelated == "not related") {
            $result = $this->storeProductCategoryManager->deleteStoreProductCategoryByID($request);

            if ($result == 'storeProductCategoryNotFound') {
                return $result;
            }
            else {

                // delete all store product category translation/s
                $this->storeProductCategoryTranslationService->deleteAllStoreProductCategoryTranslationsByStoreProductCategoryID($request->getId());

                return $this->autoMapping->map(StoreProductCategoryEntity::class, StoreProductCategoryByIdResponse::class, $result);
            }
        }
        return $isRelated;
    }

    public function replaceStoreProductCategoryTranslatedNameByPrimaryOne($storeProductCategoriesTranslation, $userLocale)
    {
        $storeCategories = [];

        if($storeProductCategoriesTranslation)
        {
            foreach($storeProductCategoriesTranslation as $storeProductCategory)
            {
                if($storeProductCategory['language'] == $userLocale)
                {
                    $storeCategories[] = $storeProductCategory;
                }
                elseif($storeProductCategory['language'] == null)
                {
                    $storeProductCategory['productCategoryName'] = $storeProductCategory['primaryStoreProductCategory'];

                    $storeCategories[] = $storeProductCategory;
                }
                elseif($storeProductCategory['language'] != null && $storeProductCategory['language'] != $userLocale)
                {
                    // here means that there is another content in different language rather that the required one or the primary one
                    if (!$this->checkIfItemExistsInSpecificLanguage($storeProductCategoriesTranslation, $storeProductCategory['id'], $userLocale))
                    {
                        $storeProductCategory['productCategoryName'] = $storeProductCategory['primaryStoreProductCategory'];

                        $storeCategories[] = $storeProductCategory;
                    }
                }
            }
        }

        return $storeCategories;
    }

    public function getAllStoreProductCategoriesLevelOne(StoreProductCategoriesLevelOneAllGetRequest $request)
    {
        $response = [];

        if ($request->getLanguage() && $request->getLanguage() != $this->primaryLanguage) {

            $storeProductCategoriesTranslations = $this->storeProductCategoryManager->getAllStoreProductCategoriesLevelOneTranslations();

            $storeProductCategoriesLevelOne = $this->replaceStoreProductCategoryTranslatedNameByPrimaryOne($storeProductCategoriesTranslations, $request->getLanguage());
        }
        else {

            $storeProductCategoriesLevelOne = $this->storeProductCategoryManager->getAllStoreProductCategoriesLevelOne();
        }

        foreach ($storeProductCategoriesLevelOne as $storeProductCategoryLevelOne) {

            $storeProductCategoryLevelOne['productCategoryImage'] = $this->getImageParams($storeProductCategoryLevelOne['productCategoryImage'], $this->params.$storeProductCategoryLevelOne['productCategoryImage'], $this->params);

            $response[] = $this->autoMapping->map('array', StoreProductCategoryLevelOneAllGetResponse::class, $storeProductCategoryLevelOne);
        }

        return $response;
    }

    public function getAllStoreProductCategoriesLevelTwo(StoreProductCategoriesLevelTwoAllGetRequest $request)
    {
        $response = [];

        if ($request->getLanguage() && $request->getLanguage() != $this->primaryLanguage) {

            $storeProductCategoriesTranslations = $this->storeProductCategoryManager->getAllStoreProductCategoriesLevelTwoTranslations();

            $storeProductCategoriesLevelTwo = $this->replaceStoreProductCategoryTranslatedNameByPrimaryOne($storeProductCategoriesTranslations, $request->getLanguage());
        }
        else {

            $storeProductCategoriesLevelTwo = $this->storeProductCategoryManager->getAllStoreProductCategoriesLevelTwo();
        }

        foreach ($storeProductCategoriesLevelTwo as $storeProductCategoryLevelTwo) {

            $storeProductCategoryLevelTwo['productCategoryImage'] = $this->getImageParams($storeProductCategoryLevelTwo['productCategoryImage'], $this->params.$storeProductCategoryLevelTwo['productCategoryImage'], $this->params);

            $response[] = $this->autoMapping->map('array', StoreProductCategoryLevelTwoAllGetResponse::class, $storeProductCategoryLevelTwo);
        }

        return $response;
    }

    public function checkIfItemExistsInSpecificLanguage($array, $itemID, $language)
    {
        foreach ($array as $item)
        {
            if ($item['id'] == $itemID && $item['language'] == $language)
            {
                return true;
            }
        }

        return false;
    }

    public function getStoreProductCategoryLevelOne(SubCategoriesWithLinkedMarkRequest $request)
    {
        $response = [];

        $storeCategoriesByProductCategoryLevelOne = $this->storeProductCategoryManager->getStoreProductCategoryLevelOne($request->getStoreProductCategoryLevelTwoID());

        if ($request->getLanguage() && $request->getLanguage() != $this->primaryLanguage) {

            $storeProductCategoriesTranslations = $this->storeProductCategoryManager->getSubCategoriesLevelOneTranslations();

            $storeCategoriesLevelOne = $this->replaceStoreProductCategoryTranslatedNameByPrimaryOne($storeProductCategoriesTranslations, $request->getLanguage());
        }
        else {

            $storeCategoriesLevelOne = $this->storeProductCategoryManager->getAllStoreProductCategoriesLevelOne();
        }

        /* Following block will just mark each store category that linked with the store product category level one by
        setting 'linked' to true
        */
        foreach ($storeCategoriesByProductCategoryLevelOne as $productCategoryLevelOne){

            foreach ($storeCategoriesLevelOne as $key => $value){

                $subCategory['linked'] = false;

                if ($value['id'] === $productCategoryLevelOne['id']){

                    $storeCategoriesLevelOne[$key]['linked'] = true;
                }
            }
        }
        // end block

        foreach ($storeCategoriesLevelOne as $subCategory){

            $subCategory['productCategoryImage'] = $this->getImageParams($subCategory['productCategoryImage'], $this->params.$subCategory['productCategoryImage'], $this->params);

            $response[] = $this->autoMapping->map('array', SubCategoriesWithLinkedMarkResponse::class, $subCategory);
        }

        return $response;
    }

}
