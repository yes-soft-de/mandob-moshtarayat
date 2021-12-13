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
use App\Response\StoreCategoryTranslationGetResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class StoreCategoryService
{
    private $autoMapping;
    private $storeCategoryManager;
    private $params;
    private $primaryLanguage;
    private $storeOwnerProfileService;
    private $storeCategoryTranslationService;

    public function __construct(AutoMapping $autoMapping, StoreCategoryManager $storeCategoryManager, ParameterBagInterface $params, StoreOwnerProfileService $storeOwnerProfileService,
     StoreCategoryTranslationService $storeCategoryTranslationService)
    {
        $this->autoMapping = $autoMapping;
        $this->storeCategoryManager = $storeCategoryManager;
        $this->storeOwnerProfileService = $storeOwnerProfileService;
        $this->storeCategoryTranslationService = $storeCategoryTranslationService;
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
           $storeCategoriesTranslations = $this->storeCategoryTranslationService->getStoreCategoriesTranslationByLanguage($request->getLanguage());

           foreach($storeCategoriesTranslations as $storeCategoryTranslation)
           {
               $response[] = $this->autoMapping->map(StoreCategoryTranslationGetResponse::class, StoreCategoryGetResponse::class, $storeCategoryTranslation);
           }
       }
       else
       {
           $items = $this->storeCategoryManager->getStoreCategories();

           foreach ($items as $item) {
               $item['image'] = $this->getImageParams($item['image'], $this->params . $item['image'], $this->params);

               $response[] = $this->autoMapping->map('array', StoreCategoryGetResponse::class, $item);
           }
       }

       return $response;
    }

    public function getStoreCategoryByID($userLocale, $id)
    {
       $item = $this->storeCategoryManager->getStoreCategoryByID($userLocale, $this->primaryLanguage, $id);

       $item['image'] = $this->getImageParams($item['image'], $this->params.$item['image'], $this->params);

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
            $item['categories'] = $this->storeCategoryTranslationService->getStoreCategoriesTranslationByLanguage($userLocale);
        }
        else
        {
            $item['categories'] = $this->storeCategoryManager->getStoreCategories();

            foreach ($item['categories'] as $key => $value)
            {
                $item['categories'][$key]['image'] = $this->getImageParams($value['image'], $this->params . $value['image'], $this->params);
            }
        }

        $item['stores'] = $this->storeOwnerProfileService->getLast15Stores();

        return $this->autoMapping->map("array", StoreCategoriesAndStoresResponse::class, $item);
    }

    public function getFavouriteStoreCategoriesAndStores($clientID): array
    {
        $categories = $this->storeCategoryManager->getFavouriteStoreCategoriesAndStores($clientID);

        if(!$categories) {
            $categories = $this->storeCategoryManager->getLast15StoreCategories();

            return $this->getCategoriesAndStores($categories);
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

    public function getFavouriteStoreCategories($clientID): array
    {
        $response = [];

        $categories = $this->storeCategoryManager->getFavouriteStoreCategories($clientID);

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
}
