<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\StoreProductCategoryTranslationEntity;
use App\Repository\StoreProductCategoryTranslationEntityRepository;
use App\Request\StoreProductCategoryTranslationCreateRequest;
use App\Request\StoreProductCategoryTranslationUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;

class StoreProductCategoryTranslationManager
{
    private $autoMapping;
    private $entityManager;
    private $storeProductCategoryTranslationEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, StoreProductCategoryTranslationEntityRepository $storeProductCategoryTranslationEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->storeProductCategoryTranslationEntityRepository = $storeProductCategoryTranslationEntityRepository;
    }

    public function createStoreProductCategoryTranslation(StoreProductCategoryTranslationCreateRequest $request)
    {
        $entity = $this->autoMapping->map(StoreProductCategoryTranslationCreateRequest::class, StoreProductCategoryTranslationEntity::class, $request);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }

    public function updateStoreProductCategoryTranslationByStoreProductCategoryIdAndLanguage(StoreProductCategoryTranslationUpdateRequest $request)
    {
        $storeProductCategoryTranslationEntity = $this->storeProductCategoryTranslationEntityRepository->getByStoreProductCategoryIdAndLanguage($request->getStoreProductCategoryID(),
            $request->getLanguage());

        if(!$storeProductCategoryTranslationEntity)
        {
            return 'storeProductCategoryTranslationNotFound';
        }
        else
        {
            $storeProductCategoryTranslationEntity = $this->autoMapping->mapToObject(StoreProductCategoryTranslationUpdateRequest::class, StoreProductCategoryTranslationEntity::class,
                $request, $storeProductCategoryTranslationEntity);

            $this->entityManager->flush();

            return $storeProductCategoryTranslationEntity;
        }
    }

    public function getByStoreCategoryIdAndLanguage($storeCategoryID, $language)
    {
        return $this->storeProductCategoryTranslationEntityRepository->getByStoreCategoryIdAndLanguage($storeCategoryID, $language);
    }

    public function getStoreProductCategoriesTranslationsByStoreProductCategoryIdAndLanguage($storeProductCategoryID, $language)
    {
        return $this->storeProductCategoryTranslationEntityRepository->getStoreProductCategoriesTranslationsByStoreProductCategoryIdAndLanguage($storeProductCategoryID, $language);
    }

    public function getStoreProductCategoryTranslationsByStoreProductCategoryID($storeProductCategoryID)
    {
        return $this->storeProductCategoryTranslationEntityRepository->getStoreProductCategoryTranslationsByStoreProductCategoryID($storeProductCategoryID);
    }

    public function deleteAllStoreProductCategoryTranslationsByStoreProductCategoryID($storeProductCategoryID)
    {
        $storeProductCategoryTranslationEntities = $this->storeProductCategoryTranslationEntityRepository->getAllStoreProductCategoryTranslationsEntitiesByStoreProductCategoryID($storeProductCategoryID);

        if(!$storeProductCategoryTranslationEntities) {

            return 'storeProductCategoryTranslationNotFound';
        } else {

            foreach ($storeProductCategoryTranslationEntities as $storeProductCategoryTranslationEntity) {

                $this->entityManager->remove($storeProductCategoryTranslationEntity);
                $this->entityManager->flush();
            }

            return $storeProductCategoryTranslationEntities;
        }
    }
}
