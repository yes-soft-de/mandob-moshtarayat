<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\ProductTranslationEntity;
use App\Repository\ProductTranslationEntityRepository;
use App\Request\ProductTranslationCreateRequest;
use App\Request\ProductTranslationUpdateRequest;
use App\Request\ProductTranslationLanguageCodeUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;

class ProductTranslationManager
{
    private $autoMapping;
    private $entityManager;
    private $productTranslationEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, ProductTranslationEntityRepository $productTranslationEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->productTranslationEntityRepository = $productTranslationEntityRepository;
    }

    public function createProductTranslation(ProductTranslationCreateRequest $request)
    {
        $productTranslationEntity = $this->autoMapping->map(ProductTranslationCreateRequest::class, ProductTranslationEntity::class, $request);

        $this->entityManager->persist($productTranslationEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $productTranslationEntity;
    }

    public function updateProductTranslationByProductIdAndLanguage(ProductTranslationUpdateRequest $request)
    {
        $productTranslationEntity = $this->productTranslationEntityRepository->getByProductIdAndLanguage($request->getProductID(), $request->getLanguage());

        if(!$productTranslationEntity)
        {
            return 'productTranslationNotFound';
        }
        else
        {
            $productTranslationEntity = $this->autoMapping->mapToObject(ProductTranslationUpdateRequest::class, ProductTranslationEntity::class,
                $request, $productTranslationEntity);

            $this->entityManager->flush();

            return $productTranslationEntity;
        }
    }

    // for testing issues: update language code
    public function updateAllProductTranslationLanguageCodeByProductIdAndLanguage(ProductTranslationLanguageCodeUpdateRequest $request)
    {
        $productTranslationEntities = $this->productTranslationEntityRepository->getAllProductsTranslationsByLanguage($request->getOldLanguage());

        if(!$productTranslationEntities)
        {
            return 'productTranslationNotFound';
        }
        else
        {
            foreach ($productTranslationEntities as $productTranslationEntity) {

                $productTranslationEntity = $this->autoMapping->mapToObject(ProductTranslationLanguageCodeUpdateRequest::class, ProductTranslationEntity::class,
                $request, $productTranslationEntity);

                $productTranslationEntity->setLanguage($request->getNewLanguageCode());

                $this->entityManager->flush();

            }

            return $productTranslationEntities;
        }
    }
}
