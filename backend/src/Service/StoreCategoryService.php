<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\StoreCategoryEntity;
use App\Manager\StoreCategoryManager;
use App\Request\StoreCategoryCreateRequest;
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
        $item['imageURL'] = $imageURL;
        $item['image'] = $image;
        $item['baseURL'] = $baseURL;

        return $item;
    }

    public function getStoreCategoriesAndStores()
    {
        $response = [];

        $item['categories'] = $this->getStoreCategories();
        $item['stores'] = $this->storeOwnerProfileService->getLast15Stores();

        $response=  $this->autoMapping->map("array", StoreCategoriesAndStoresResponse::class, $item);

        return $response;
    }
}
