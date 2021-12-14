<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\ProductTranslationEntity;
use App\Manager\ProductTranslationManager;
use App\Request\ProductTranslationCreateRequest;
use App\Response\ProductTranslationCreateResponse;
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

}