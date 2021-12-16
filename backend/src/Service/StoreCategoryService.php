<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\StoreCategoryEntity;
use App\Manager\StoreCategoryManager;
use App\Request\FilterStoreCategory;
use App\Request\StoreCategoryWithTranslationCreateRequest;
use App\Response\ClientFavouriteStoreCategoriesAndStoresGetResponse;
use App\Response\ClientFavouriteStoreCategoriesResponse;
use App\Response\StoreCategoriesAndStoresResponse;
use App\Response\StoreCategoryCreateResponse;
use App\Response\StoreCategoryByIdResponse;
use App\Response\StoreCategoryGetResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class StoreCategoryService
{
    private $autoMapping;
    private $storeCategoryManager;
    private $params;
    private $primaryLanguage;
    private $storeOwnerProfileService;

    public function __construct(AutoMapping $autoMapping, StoreCategoryManager $storeCategoryManager, ParameterBagInterface $params, StoreOwnerProfileService $storeOwnerProfileService)
    {
        $this->autoMapping = $autoMapping;
        $this->storeCategoryManager = $storeCategoryManager;
        $this->storeOwnerProfileService = $storeOwnerProfileService;
        $this->params = $params->get('upload_base_url') . '/';
        $this->primaryLanguage = $params->get('primary_language');
    }

    public function createStoreCategory(StoreCategoryWithTranslationCreateRequest $request)
    {
        $storeCategoryEntity = $this->storeCategoryManager->createStoreCategory($request);

        return $this->autoMapping->map(StoreCategoryEntity::class, StoreCategoryCreateResponse::class, $storeCategoryEntity);
    }

    public function updateStoreCategory($request)
    {
        $item = $this->storeCategoryManager->updateStoreCategory($request);

        return $this->autoMapping->map(StoreCategoryEntity::class, StoreCategoryCreateResponse::class, $item);
    }

    public function getStoreCategories(FilterStoreCategory $request)
    {
       $response = [];

       if($request->getLanguage() && $request->getLanguage() != $this->primaryLanguage)
       {
           $storeCategoriesTranslations = $this->storeCategoryManager->getStoreCategoriesTranslations();

           $storeCategories = $this->replaceStoreCategoryTranslatedNameByPrimaryOne($storeCategoriesTranslations, $request->getLanguage());
       }
       else
       {
           $storeCategories = $this->storeCategoryManager->getStoreCategories();
       }

        foreach ($storeCategories as $item) {
            $item['image'] = $this->getImageParams($item['image'], $this->params . $item['image'], $this->params);

            $response[] = $this->autoMapping->map('array', StoreCategoryGetResponse::class, $item);
        }

       return $response;
    }

    public function getStoreCategoriesByPreferredLanguage($userLocale)
    {
        $response = [];

        if($userLocale != null && $userLocale != $this->primaryLanguage)
        {
            $storeCategoriesTranslations = $this->storeCategoryManager->getStoreCategoriesTranslations();

            $storeCategories = $this->replaceStoreCategoryTranslatedNameByPrimaryOne($storeCategoriesTranslations, $userLocale);
        }
        else
        {
            $storeCategories = $this->storeCategoryManager->getStoreCategories();
        }

        foreach ($storeCategories as $item) {
            $item['image'] = $this->getImageParams($item['image'], $this->params . $item['image'], $this->params);

            $response[] = $this->autoMapping->map('array', StoreCategoryGetResponse::class, $item);
        }

        return $response;
    }

    public function getStoreCategoryByID($userLocale, $id)
    {
        if ($userLocale != null && $userLocale != $this->primaryLanguage)
        {
            $categoryTranslationResult = $this->storeCategoryManager->getStoreCategoryTranslationByID($id);

            if($categoryTranslationResult['language'] == $userLocale)
            {
                $item = $categoryTranslationResult;
            }
            elseif($categoryTranslationResult['language'] == null)
            {
                $categoryTranslationResult['storeCategoryName'] = $categoryTranslationResult['primaryStoreCategoryName'];

                $item = $categoryTranslationResult;
            }
            else
            {
                $item = $this->storeCategoryManager->getStoreCategoryByID($id);
            }
        }
        else
        {
            $item = $this->storeCategoryManager->getStoreCategoryByID($id);
        }

       if ($item)
       {
           $item['image'] = $this->getImageParams($item['image'], $this->params . $item['image'], $this->params);
       }

       return $this->autoMapping->map('array', StoreCategoryByIdResponse::class, $item);
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

    public function getStoreCategoriesAndStores($userLocale)
    {
        if(($userLocale != null) && $userLocale != $this->primaryLanguage)
        {
            $storeCategoriesTranslations = $this->storeCategoryManager->getStoreCategoriesTranslations();

            $item['categories'] = $this->replaceStoreCategoryTranslatedNameByPrimaryOne($storeCategoriesTranslations, $userLocale);
        }
        else
        {
            $item['categories'] = $this->storeCategoryManager->getStoreCategories();
        }

        foreach ($item['categories'] as $key => $value)
        {
            $item['categories'][$key]['image'] = $this->getImageParams($value['image'], $this->params . $value['image'], $this->params);
        }

        $item['stores'] = $this->storeOwnerProfileService->getLast15Stores();

        return $this->autoMapping->map("array", StoreCategoriesAndStoresResponse::class, $item);
    }

    public function getFavouriteStoreCategoriesAndStores($userLocale, $clientID): array
    {
        if($userLocale != null && $userLocale != $this->primaryLanguage)
        {
            $storeCategoriesTranslations = $this->storeCategoryManager->getFavouriteStoreCategoriesTranslationsAndStores($clientID);

            $categories = $this->replaceStoreCategoryTranslatedNameByPrimaryOne($storeCategoriesTranslations, $userLocale);

            if(!$categories)
            {
                $categories = $this->storeCategoryManager->getLast15StoreCategoriesTranslations($userLocale);

                return $this->getCategoriesAndStores($categories);
            }
        }
        else
        {
            $categories = $this->storeCategoryManager->getFavouriteStoreCategoriesAndStores($clientID);

            if(!$categories)
            {
                $categories = $this->storeCategoryManager->getLast15StoreCategories();

                return $this->getCategoriesAndStores($categories);
            }
        }

        return $this->getLast15StoresByCategoryID($categories);
    }

    public function getCategoriesAndStores($categories): array
    {
        $response = [];

        foreach($categories as $category)
        {
            $category['stores'] = $this->storeOwnerProfileService->getStoreOwnerProfileByCategoryID($category['id']);

            if($category['stores']){
                foreach($category['stores'] as $key => $value){

                    $category['stores'][$key]['image'] = $this->getImageParams($value['image'], $this->params.$value['image'], $this->params);
                }
            }

            $response[] = $this->autoMapping->map("array", ClientFavouriteStoreCategoriesAndStoresGetResponse::class, $category);
        }

        return $response;
    }

    public function getLast15StoresByCategoryID($categories): array
    {
        $response = [];

        foreach($categories as $category)
        {
            $category['stores'] = $this->storeOwnerProfileService->getLast15StoresByCategoryID($category['id']);

            if($category['stores']){
                foreach($category['stores'] as $key => $value){

                    $category['stores'][$key]['image'] = $this->getImageParams($value['image'], $this->params.$value['image'], $this->params);
                }
            }

            $response[] = $this->autoMapping->map("array", ClientFavouriteStoreCategoriesAndStoresGetResponse::class, $category);
        }

        return $response;
    }

    public function getFavouriteStoreCategories($userLocale, $clientID): array
    {
        $response = [];

        if($userLocale != null && $userLocale != $this->primaryLanguage)
        {
            $storeCategoriesTranslations = $this->storeCategoryManager->getStoreCategoriesTranslationsByClientFavouriteCategories($clientID);

            $categories = $this->replaceStoreCategoryTranslatedNameByPrimaryOne($storeCategoriesTranslations, $userLocale);
        }
        else
        {
            $categories = $this->storeCategoryManager->getFavouriteStoreCategories($clientID);
        }

        foreach($categories as $category){
            $response[] = $this->autoMapping->map("array", ClientFavouriteStoreCategoriesResponse::class, $category);

        }

        return $response;
    }

    public function deleteStoreCategoryByID($request)
    {
        $isRelated = $this->storeCategoryManager->isItRelatedToSubcategoriesOrStore($request->getID());
        if($isRelated == "not related"){
            $result = $this->storeCategoryManager->deleteStoreCategoryByID($request);

            if($result == 'storeCategoryNotFound'){
                return $result;
            }

            else{
                return $this->autoMapping->map(StoreCategoryEntity::class, StoreCategoryByIdResponse::class, $result);
            }
        }

        return $isRelated;
    }

    public function replaceStoreCategoryTranslatedNameByPrimaryOne($storeCategoriesTranslation, $userLocale)
    {
        $storeCategories = [];

        if($storeCategoriesTranslation)
        {
            foreach($storeCategoriesTranslation as $storeCategory)
            {
                if($storeCategory['language'] == $userLocale)
                {
                    $storeCategories[] = $storeCategory;
                }
                elseif($storeCategory['language'] == null)
                {
                    $storeCategory['storeCategoryName'] = $storeCategory['primaryStoreCategoryName'];

                    $storeCategories[] = $storeCategory;
                }
                elseif($storeCategory['language'] != null && $storeCategory['language'] != $userLocale)
                {
                    if(!$this->checkIfItemExistsInSpecificLanguage($storeCategoriesTranslation, $storeCategory['id'], $userLocale))
                    {
                        $storeCategory['storeCategoryName'] = $storeCategory['primaryStoreCategoryName'];

                        $storeCategories[] = $storeCategory;
                    }
                }
            }
        }

        return $storeCategories;
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

//    public function checkIfValueExistForSpecificKeyInArray($array, $key, $value)
//    {
//        foreach ($array as $item)
//        {
//            if ($item[$key] == $value)
//            {
//                return true;
//            }
//        }
//
//        return false;
//    }
}
