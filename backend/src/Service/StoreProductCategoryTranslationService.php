<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\StoreProductCategoryTranslationEntity;
use App\Manager\StoreProductCategoryTranslationManager;
use App\Request\StoreProductCategoryTranslationCreateRequest;
use App\Response\StoreProductCategoryTranslationCreateResponse;

class StoreProductCategoryTranslationService
{
    private $autoMapping;
    private $storeProductCategoryTranslationManager;

    public function __construct(AutoMapping $autoMapping, StoreProductCategoryTranslationManager $storeProductCategoryTranslationManager)
    {
        $this->autoMapping = $autoMapping;
        $this->storeProductCategoryTranslationManager = $storeProductCategoryTranslationManager;
    }

    public function createStoreProductCategoryTranslation(StoreProductCategoryTranslationCreateRequest $request)
    {
        $storeProductCategoryTranslationResult = $this->storeProductCategoryTranslationManager->createStoreProductCategoryTranslation($request);

        return $this->autoMapping->map(StoreProductCategoryTranslationEntity::class, StoreProductCategoryTranslationCreateResponse::class, $storeProductCategoryTranslationResult);
    }

}