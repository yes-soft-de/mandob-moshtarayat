<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\StoreProductCategoryEntity;
use App\Repository\StoreProductCategoryEntityRepository;
use App\Request\DeleteRequest;
use App\Request\StoreProductCategoryCreateRequest;
use App\Request\StoreProductCategoryLevelOneUpdateRequest;
use App\Request\StoreProductCategoryLevelTwoCreateRequest;
use App\Request\StoreProductCategoryLevelTwoUpdateRequest;
use App\Request\StoreProductCategoryTranslationCreateRequest;
use App\Request\StoreProductCategoryUpdateRequest;
use App\Request\StoreProductCategoryWithTranslationCreateRequest;
use Doctrine\ORM\EntityManagerInterface;


class StoreProductCategoryManager
{
    private $autoMapping;
    private $entityManager;
    private $storeProductCategoryTranslationManager;
    private $storeProductCategoryEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, StoreProductCategoryEntityRepository $storeProductCategoryEntityRepository,
     StoreProductCategoryTranslationManager $storeProductCategoryTranslationManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->storeProductCategoryTranslationManager = $storeProductCategoryTranslationManager;
        $this->storeProductCategoryEntityRepository = $storeProductCategoryEntityRepository;
    }

    public function createStoreProductCategoryLevelOne(StoreProductCategoryWithTranslationCreateRequest $request)
    {
        // First insert the data in the primary language
        $storeProductCategoryCreateRequest = $this->autoMapping->map('array', StoreProductCategoryCreateRequest::class, $request->getData());

        $entity = $this->autoMapping->map(StoreProductCategoryCreateRequest::class, StoreProductCategoryEntity::class, $storeProductCategoryCreateRequest);
        $entity->setIsLevel1(true);
        $entity->setIsLevel2(false);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        // Secondly, insert the translation data
        if($request->getTranslate())
        {
            $this->createStoreProductCategoryTranslation($request->getTranslate(), $entity->getId());
        }

        return $entity;
    }

    public function createStoreProductCategoryTranslation($translationArrayRequest, $storeProductCategoryID)
    {
        if($translationArrayRequest)
        {
            foreach($translationArrayRequest as $translationRequest)
            {
                $storeProductCategoryTranslationCreateRequest = $this->autoMapping->map('array', StoreProductCategoryTranslationCreateRequest::class, $translationRequest);

                $storeProductCategoryTranslationCreateRequest->setStoreProductCategoryID($storeProductCategoryID);

                $this->storeProductCategoryTranslationManager->createStoreProductCategoryTranslation($storeProductCategoryTranslationCreateRequest);
            }
        }
        else
        {
            // No translations were provided!
            // Skip inserting translations
        }
    }

    public function createStoreProductCategoryLevelTwo(StoreProductCategoryLevelTwoCreateRequest $request)
    {
        $entity = $this->autoMapping->map(StoreProductCategoryLevelTwoCreateRequest::class, StoreProductCategoryEntity::class, $request);
        $entity->setIsLevel2(true);
        $entity->setIsLevel1(false);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }

     public function updateStoreProductCategoryLevelOne(StoreProductCategoryLevelOneUpdateRequest $request)
     {
       $entity = $this->storeProductCategoryEntityRepository->find($request->getId());
       if (!$entity) {
           return $entity;
       }
       $entity = $this->autoMapping->mapToObject(StoreProductCategoryLevelOneUpdateRequest::class, StoreProductCategoryEntity::class, $request, $entity);

       $this->entityManager->flush();

       return $entity;
     }

     public function updateStoreProductCategoryLevelTwo(StoreProductCategoryLevelTwoUpdateRequest $request)
     {
       $entity = $this->storeProductCategoryEntityRepository->find($request->getId());
       if (!$entity) {
           return $entity;
       }
       $entity = $this->autoMapping->mapToObject(StoreProductCategoryLevelTwoUpdateRequest::class, StoreProductCategoryEntity::class, $request, $entity);

       $this->entityManager->flush();

       return $entity;
     }

    public function getStoreProductsCategoryForStoreSpecific($storeOwnerProfileId)
    {
       return $this->storeProductCategoryEntityRepository->getStoreProductsCategoryForStoreSpecific($storeOwnerProfileId);
    }

    public function getStoreProductCategoryStoreSpecific($storeOwnerProfileId)
    {
       return $this->storeProductCategoryEntityRepository->getStoreProductCategoryStoreSpecific($storeOwnerProfileId);
    }

    public function getSubCategoriesByStoreCategoryID($storeCategoryID)
    {
       return $this->storeProductCategoryEntityRepository->getSubCategoriesByStoreCategoryID($storeCategoryID);
    }

    public function getStoreProductsCategoryLevelTwoByStoreProductCategoryID($storeProductCategoryID)
    {
       return $this->storeProductCategoryEntityRepository->getStoreProductsCategoryLevelTwoByStoreProductCategoryID($storeProductCategoryID);
    }

    public function getStoreProductsCategoryLevelTwoByStoreOwnerProfile($storeOwnerProfileID)
    {
       return $this->storeProductCategoryEntityRepository->getStoreProductsCategoryLevelTwoByStoreOwnerProfile($storeOwnerProfileID);
    }

    public function getCategoriesLevel1ById($id)
    {
       return $this->storeProductCategoryEntityRepository->getCategoriesLevel1ById($id);
    }

    public function getStoreProductsCategoriesIdLevelOneByStoreOwnerProfileID($storeOwnerProfileID)
    {
       return $this->storeProductCategoryEntityRepository->getStoreProductsCategoriesIdLevelOneByStoreOwnerProfileID($storeOwnerProfileID);
    }

    public function isItRelatedToProductsOrOtherCategory($id):string
    {
        $items = $this->storeProductCategoryEntityRepository->isItRelatedToProductsOrOtherCategory($id);

        if($items) {
            return "related";
        }
        return "not related";
    }
    public function isItRelatedToCategoryLevelTwo($id):string
    {
        $items = $this->storeProductCategoryEntityRepository->isItRelatedToCategoryLevelTwo($id);

        if($items) {
            return "related";
        }

        return "not related";
    }

    public function deleteStoreProductCategoryByID(DeleteRequest $request)
    {
        $storeProductCategoryEntity = $this->storeProductCategoryEntityRepository->find($request->getId());

        if(!$storeProductCategoryEntity){
            return 'storeProductCategoryNotFound';
        }
        else{
            $this->entityManager->remove($storeProductCategoryEntity);
            $this->entityManager->flush();

            return $storeProductCategoryEntity;
        }
    }
}
