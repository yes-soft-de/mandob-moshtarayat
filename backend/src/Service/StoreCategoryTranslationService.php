<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\StoreCategoryTranslationEntity;
use App\Manager\StoreCategoryTranslationManager;
use App\Request\StoreCategoryTranslationCreateRequest;
use App\Response\StoreCategoryTranslationCreateResponse;
use App\Response\StoreCategoryTranslationGetResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class StoreCategoryTranslationService
{
    private $autoMapping;
    private $storeCategoryTranslationManager;
    private $params;

    public function __construct(AutoMapping $autoMapping, StoreCategoryTranslationManager $storeCategoryTranslationManager, ParameterBagInterface $params)
    {
        $this->autoMapping = $autoMapping;
        $this->storeCategoryTranslationManager = $storeCategoryTranslationManager;
        $this->params = $params->get('upload_base_url') . '/';
    }

    public function createStoreCategoryTranslation(StoreCategoryTranslationCreateRequest $request)
    {
        $storeCategoryTranslationResult = $this->storeCategoryTranslationManager->createStoreCategoryTranslation($request);

        return $this->autoMapping->map(StoreCategoryTranslationEntity::class, StoreCategoryTranslationCreateResponse::class, $storeCategoryTranslationResult);
    }

    public function getStoreCategoriesTranslationByLanguage($language)
    {
        $response = [];

        $storeCategoriesTranslations = $this->storeCategoryTranslationManager->getStoreCategoriesTranslationByLanguage($language);

        foreach($storeCategoriesTranslations as $storeCategoryTranslation)
        {
            if($storeCategoryTranslation['image'])
            {
                $storeCategoryTranslation['image'] = $this->getImageParams($storeCategoryTranslation['image'],$this->params . $storeCategoryTranslation['image'], $this->params);
            }

            $response[] = $this->autoMapping->map('array', StoreCategoryTranslationGetResponse::class, $storeCategoryTranslation);
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

    public function deleteAllStoreCategoryTranslationsByStoreCategoryID($storeCategoryID)
    {
        $response = [];

        $storeCategoryTranslationsEntities = $this->storeCategoryTranslationManager->deleteAllStoreCategoryTranslationsByStoreCategoryID($storeCategoryID);

        if($storeCategoryTranslationsEntities == 'storeCategoryTranslationNotFound') {

            return $storeCategoryTranslationsEntities;
        } else {

            foreach ($storeCategoryTranslationsEntities as $storeCategoryTranslationsEntity) {

                $response[] = $this->autoMapping->map(StoreCategoryTranslationEntity::class, StoreCategoryTranslationGetResponse::class, $storeCategoryTranslationsEntity);
            }

            return $response;
        }
    }
}
