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

    public function createStoreProductCategoryLevelOne(StoreProductCategoryCreateRequest $request)
    {
        $entity = $this->autoMapping->map(StoreProductCategoryCreateRequest::class, StoreProductCategoryEntity::class, $request);
        $entity->setIsLevel1(true);
        $entity->setIsLevel2(false);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
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

    public function getProductCategoryLevelOneByProductCategoryLevelTwoID($storeProductCategoryLevelTwoID)
    {
        return $this->storeProductCategoryEntityRepository->getProductCategoryLevelOneByProductCategoryLevelTwoID($storeProductCategoryLevelTwoID);
    }

    public function getSubCategoriesTranslationsByStoreCategoryID($storeCategoryID)
    {
        return $this->storeProductCategoryEntityRepository->getSubCategoriesTranslationsByStoreCategoryID($storeCategoryID);
    }

    public function getSubCategoriesLevelOneTranslations()
    {
        return $this->storeProductCategoryEntityRepository->getSubCategoriesLevelOneTranslations();
    }

    public function getAllStoreProductCategoriesLevelOneTranslations()
    {
        return $this->storeProductCategoryEntityRepository->getAllStoreProductCategoriesLevelOneTranslations();
    }

    public function getAllStoreProductCategoriesLevelTwoTranslations()
    {
        return $this->storeProductCategoryEntityRepository->getAllStoreProductCategoriesLevelTwoTranslations();
    }

    public function getStoreProductsCategoryLevelTwoByStoreProductCategoryID($storeProductCategoryID)
    {
       return $this->storeProductCategoryEntityRepository->getStoreProductsCategoryLevelTwoByStoreProductCategoryID($storeProductCategoryID);
    }

    public function getOnlyStoreProductsCategoryLevelTwoByStoreProductCategoryLevelOneID($storeProductCategoryID)
    {
        return $this->storeProductCategoryEntityRepository->getOnlyStoreProductsCategoryLevelTwoByStoreProductCategoryLevelOneID($storeProductCategoryID);
    }

    public function getStoreProductsCategoryLevelTwoByStoreProductCategoryIdForAdmin($storeProductCategoryID)
    {
        return $this->storeProductCategoryEntityRepository->getStoreProductsCategoryLevelTwoByStoreProductCategoryIdForAdmin($storeProductCategoryID);
    }

    public function getStoreProductsCategoryLevelTwoTranslationsByStoreProductCategoryID($storeProductCategoryID)
    {
        return $this->storeProductCategoryEntityRepository->getStoreProductsCategoryLevelTwoTranslationsByStoreProductCategoryID($storeProductCategoryID);
    }

    public function getStoreProductsCategoryLevelTwoByStoreOwnerProfile($storeOwnerProfileID)
    {
       return $this->storeProductCategoryEntityRepository->getStoreProductsCategoryLevelTwoByStoreOwnerProfile($storeOwnerProfileID);
    }

    public function getCategoriesLevel1ById($id)
    {
       return $this->storeProductCategoryEntityRepository->getCategoriesLevel1ById($id);
    }

    public function getStoreProductCategoryByID($id)
    {
        return $this->storeProductCategoryEntityRepository->getStoreProductCategoryByID($id);
    }

    public function getStoreProductCategoryTranslationsByStoreProductCategoryID($storeProductCategoryID)
    {
        return $this->storeProductCategoryTranslationManager->getStoreProductCategoryTranslationsByStoreProductCategoryID($storeProductCategoryID);
    }

    public function getStoreProductCategoryTranslationByStoreProductCategoryIdAndLanguage($storeProductCategoryID, $language)
    {
        return $this->storeProductCategoryEntityRepository->getStoreProductCategoryTranslationByStoreProductCategoryIdAndLanguage($storeProductCategoryID, $language);
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

    public function getStoreProductCategoryEntityByID($storeProductCategoryID)
    {
        return $this->storeProductCategoryEntityRepository->find($storeProductCategoryID);
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

    public function getStoreProductCategoryLevelOne($storeProductCategoryLevelTwoID)
    {
        return $this->storeProductCategoryEntityRepository->getStoreProductCategoryLevelOne($storeProductCategoryLevelTwoID);
    }

    // Return all store categories level one directly without any condition
    public function getAllStoreProductCategoriesLevelOne()
    {
        return $this->storeProductCategoryEntityRepository->getAllStoreProductCategoriesLevelOne();
    }

    // Return all store categories level two directly without any condition
    public function getAllStoreProductCategoriesLevelTwo()
    {
        return $this->storeProductCategoryEntityRepository->getAllStoreProductCategoriesLevelTwo();
    }
}
