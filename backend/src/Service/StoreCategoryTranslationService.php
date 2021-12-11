<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\StoreCategoryTranslationEntity;
use App\Manager\StoreCategoryTranslationManager;
use App\Request\StoreCategoryTranslationCreateRequest;
use App\Response\StoreCategoryTranslationCreateResponse;

class StoreCategoryTranslationService
{
    private $autoMapping;
    private $storeCategoryTranslationManager;

    public function __construct(AutoMapping $autoMapping, StoreCategoryTranslationManager $storeCategoryTranslationManager)
    {
        $this->autoMapping = $autoMapping;
        $this->storeCategoryTranslationManager = $storeCategoryTranslationManager;
    }

    public function createStoreCategoryTranslation(StoreCategoryTranslationCreateRequest $request)
    {
        $storeCategoryTranslationResult = $this->storeCategoryTranslationManager->createStoreCategoryTranslation($request);

        return $this->autoMapping->map(StoreCategoryTranslationEntity::class, StoreCategoryTranslationCreateResponse::class, $storeCategoryTranslationResult);
    }

}