<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\ProductTranslationEntity;
use App\Manager\ProductTranslationManager;
use App\Request\ProductTranslationCreateRequest;
use App\Request\ProductTranslationUpdateRequest;
use App\Request\ProductTranslationLanguageCodeUpdateRequest;
use App\Response\ProductTranslationCreateResponse;
use App\Response\ProductTranslationUpdateResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class ProductTranslationService
{
    private $autoMapping;
    private $productTranslationManager;
    private $params;

    public function __construct(AutoMapping $autoMapping, ProductTranslationManager $productTranslationManager, ParameterBagInterface $params)
    {
        $this->autoMapping = $autoMapping;
        $this->productTranslationManager = $productTranslationManager;
        $this->params = $params->get('upload_base_url') . '/';
    }

    public function createProductTranslation(ProductTranslationCreateRequest $request)
    {
        $productTranslationResult = $this->productTranslationManager->createProductTranslation($request);

        return $this->autoMapping->map(ProductTranslationEntity::class, ProductTranslationCreateResponse::class, $productTranslationResult);
    }

    public function updateProductTranslationByProductIdAndLanguage(ProductTranslationUpdateRequest $request)
    {
        $productTranslationResult = $this->productTranslationManager->updateProductTranslationByProductIdAndLanguage($request);

        if($productTranslationResult == 'productTranslationNotFound')
        {
            // do nothing
        }
        else
        {
            return $this->autoMapping->map(ProductTranslationEntity::class, ProductTranslationUpdateResponse::class, $productTranslationResult);
        }
    }

    // for testing issues: update language code
    public function updateAllProductTranslationLanguageCodeByProductIdAndLanguage(ProductTranslationLanguageCodeUpdateRequest $request): array
    {
        $productTranslationEntities = $this->productTranslationManager->updateAllProductTranslationLanguageCodeByProductIdAndLanguage($request);

        if ($productTranslationEntities === 'productTranslationNotFound') {

        }
        else {

            $response = [];

            foreach ($productTranslationEntities as $productTranslationEntity) {

                $response[] = $this->autoMapping->map(ProductTranslationEntity::class, ProductTranslationUpdateResponse::class, $productTranslationEntity);
            }

            return $response;
        }
    }
}