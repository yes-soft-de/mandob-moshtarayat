<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\StoreProductCategoryTranslationEntity;
use App\Manager\StoreProductCategoryTranslationManager;
use App\Request\StoreProductCategoryTranslationCreateRequest;
use App\Request\StoreProductCategoryTranslationUpdateRequest;
use App\Response\StoreProductCategoryTranslationCreateResponse;
use App\Response\StoreProductCategoryTranslationGetResponse;
use App\Response\StoreProductCategoryTranslationUpdateResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class StoreProductCategoryTranslationService
{
    private $autoMapping;
    private $storeProductCategoryTranslationManager;
    private $params;

    public function __construct(AutoMapping $autoMapping, StoreProductCategoryTranslationManager $storeProductCategoryTranslationManager, ParameterBagInterface $params)
    {
        $this->autoMapping = $autoMapping;
        $this->storeProductCategoryTranslationManager = $storeProductCategoryTranslationManager;
        $this->params = $params->get('upload_base_url') . '/';
    }

    public function createStoreProductCategoryTranslation(StoreProductCategoryTranslationCreateRequest $request)
    {
        $storeProductCategoryTranslationResult = $this->storeProductCategoryTranslationManager->createStoreProductCategoryTranslation($request);

        return $this->autoMapping->map(StoreProductCategoryTranslationEntity::class, StoreProductCategoryTranslationCreateResponse::class, $storeProductCategoryTranslationResult);
    }

    public function updateStoreProductCategoryTranslationByStoreProductCategoryIdAndLanguage(StoreProductCategoryTranslationUpdateRequest $request)
    {
        $storeProductCategoryTranslationResult = $this->storeProductCategoryTranslationManager->updateStoreProductCategoryTranslationByStoreProductCategoryIdAndLanguage($request);

        return $this->autoMapping->map(StoreProductCategoryTranslationEntity::class, StoreProductCategoryTranslationUpdateResponse::class, $storeProductCategoryTranslationResult);
    }

    public function getByStoreCategoryIdAndLanguage($storeCategoryID, $language)
    {
        $response = [];

        $storeProductCategoriesTranslations = $this->storeProductCategoryTranslationManager->getByStoreCategoryIdAndLanguage($storeCategoryID, $language);

        foreach($storeProductCategoriesTranslations as $storeProductCategoryTranslation)
        {
            if($storeProductCategoryTranslation['productCategoryImage'])
            {
                $storeProductCategoryTranslation['productCategoryImage'] = $this->getImageParams($storeProductCategoryTranslation['productCategoryImage'],
                    $this->params . $storeProductCategoryTranslation['productCategoryImage'], $this->params);
            }

            $response[] = $this->autoMapping->map('array', StoreProductCategoryTranslationGetResponse::class, $storeProductCategoryTranslation);
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

}