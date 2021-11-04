<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\StoreProductCategoryEntity;
use App\Manager\StoreProductCategoryManager;
use App\Request\StoreProductCategoryCreateRequest;
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

    public function createStoreProductCategory(StoreProductCategoryCreateRequest $request)
    {
        $storeOwnerProfileId = $this->userService->getStoreProfileId($request->getUserID());
        $request->setStoreOwnerProfileId($storeOwnerProfileId['id']);
        $item = $this->storeProductCategoryManager->createStoreProductCategory($request);
         
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
}
