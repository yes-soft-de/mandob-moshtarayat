<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\StoreCategoryEntity;
use App\Manager\StoreCategoryManager;
use App\Request\StoreCategoryCreateRequest;
use App\Response\ClientFavouriteStoreCategoriesAndStoresGetResponse;
use App\Response\ClientFavouriteStoreCategoriesResponse;
use App\Response\StoreCategoriesAndStoresResponse;
use App\Response\StoreCategoryCreateResponse;
use App\Response\StoreCategoryByIdResponse;
use App\Response\StoreCategoryGetResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;
use App\Service\StoreOwnerProfileService;

class StoreCategoryService
{
    private $autoMapping;
    private $storeCategoryManager;
    private $params;
    private $storeOwnerProfileService;

    public function __construct(AutoMapping $autoMapping, StoreCategoryManager $storeCategoryManager, ParameterBagInterface $params, StoreOwnerProfileService $storeOwnerProfileService)
    {
        $this->autoMapping = $autoMapping;
        $this->storeCategoryManager = $storeCategoryManager;
        $this->storeOwnerProfileService = $storeOwnerProfileService;
        $this->params = $params->get('upload_base_url') . '/';
    }

    public function createStoreCategory(StoreCategoryCreateRequest $request)
    {
        $item = $this->storeCategoryManager->createStoreCategory($request);

        return $this->autoMapping->map(StoreCategoryEntity::class, StoreCategoryCreateResponse::class, $item);
    }

    public function updateStoreCategory($request)
    {
        $item = $this->storeCategoryManager->updateStoreCategory($request);

        return $this->autoMapping->map(StoreCategoryEntity::class, StoreCategoryCreateResponse::class, $item);
    }

    public function getStoreCategories(): array
    {
       $response = [];

       $items = $this->storeCategoryManager->getStoreCategories();

       foreach($items as $item)
       {
           $item['image'] = $this->getImageParams($item['image'], $this->params.$item['image'], $this->params);

           $response[] =  $this->autoMapping->map('array', StoreCategoryGetResponse::class, $item);
       }

       return $response;
    }

    public function getStoreCategory($id)
    {
       $item = $this->storeCategoryManager->getStoreCategory($id);

       return $this->autoMapping->map(StoreCategoryEntity::class, StoreCategoryByIdResponse::class, $item);
       
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

    public function getStoreCategoriesAndStores()
    {
        $item['categories'] = $this->getStoreCategories();
        $item['stores'] = $this->storeOwnerProfileService->getLast15Stores();

        return $this->autoMapping->map("array", StoreCategoriesAndStoresResponse::class, $item);
    }

    public function getFavouriteStoreCategoriesAndStores($clientID)
    {
        $response = [];

        $categories = $this->storeCategoryManager->getFavouriteStoreCategoriesAndStores($clientID);

        if($categories)
        {
            foreach($categories as $category)
            {
                $category['stores'] = $this->storeOwnerProfileService->getStoreOwnerProfileByCategoryID($category['id']);

                if($category['stores'])
                {
                    foreach($category['stores'] as $key => $value)
                    {
                        $category['stores'][$key]['image'] = $this->getImageParams($value['image'], $this->params.$value['image'], $this->params);
                    }
                }

                $response[] = $this->autoMapping->map("array", ClientFavouriteStoreCategoriesAndStoresGetResponse::class, $category);
            }
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
        $result = $this->storeCategoryManager->deleteStoreCategoryByID($request);

        if($result == 'storeCategoryNotFound'){
            return $result;
        }
        else{
            return $this->autoMapping->map(StoreCategoryEntity::class, StoreCategoryByIdResponse::class, $result);
        }
    }
}
