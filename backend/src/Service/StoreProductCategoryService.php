<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\StoreProductCategoryEntity;
use App\Manager\StoreProductCategoryManager;
use App\Request\StoreProductCategoryCreateRequest;
use App\Request\StoreProductCategoryLevelTwoCreateRequest;
use App\Request\StoreProductCategoryUpdateRequest;
use App\Response\StoreProductCategoryCreateResponse;
use App\Response\StoreProductsCategoryResponse;
use App\Service\UserService;


class StoreProductCategoryService
{
    private $autoMapping;
    private $storeProductCategoryManager;
    private $userService;

    public function __construct(AutoMapping $autoMapping, StoreProductCategoryManager $storeProductCategoryManager, UserService $userService)
    {
        $this->autoMapping = $autoMapping;
        $this->storeProductCategoryManager = $storeProductCategoryManager;
        $this->userService = $userService;
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
            $response[] = $this->autoMapping->map('array', StoreProductsCategoryResponse::class, $item);
      }
       return $response;
    }

    public function getStoreProductsCategoryLeveltwoByStoreProductCategoryID($storeProductCategoryID)
    {
        $response = [];
       $items = $this->storeProductCategoryManager->getStoreProductsCategoryLevelTwoByStoreProductCategoryID($storeProductCategoryID);
       foreach($items as $item) {
            $response[] = $this->autoMapping->map('array', StoreProductsCategoryResponse::class, $item);
      }
       return $response;
    }
}
