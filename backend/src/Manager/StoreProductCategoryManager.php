<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\StoreProductCategoryEntity;
use App\Repository\StoreProductCategoryEntityRepository;
use App\Request\StoreProductCategoryCreateRequest;
use App\Request\StoreProductCategoryLevelOneUpdateRequest;
use App\Request\StoreProductCategoryLevelTwoCreateRequest;
use App\Request\StoreProductCategoryLevelTwoUpdateRequest;
use App\Request\StoreProductCategoryUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;


class StoreProductCategoryManager
{
    private $autoMapping;
    private $entityManager;
    private $storeProductCategoryEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, StoreProductCategoryEntityRepository $storeProductCategoryEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
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
         $isRelated = $this->isItRelatedToCategoryLevelTwo($request->getId());
         if ($isRelated == 'not related') {
             $entity = $this->storeProductCategoryEntityRepository->find($request->getId());
             if (!$entity) {
                 return $entity;
             }
             $entity = $this->autoMapping->mapToObject(StoreProductCategoryLevelOneUpdateRequest::class, StoreProductCategoryEntity::class, $request, $entity);

             $this->entityManager->flush();

             return $entity;
         }
         return $isRelated;
     }

     public function updateStoreProductCategoryLevelTwo(StoreProductCategoryLevelTwoUpdateRequest $request)
     {
         $isRelated = $this->isItRelatedToProducts($request->getId());
         if ($isRelated == 'not related') {
             $entity = $this->storeProductCategoryEntityRepository->find($request->getId());
             if (!$entity) {
                 return $entity;
             }
             $entity = $this->autoMapping->mapToObject(StoreProductCategoryLevelTwoUpdateRequest::class, StoreProductCategoryEntity::class, $request, $entity);

             $this->entityManager->flush();

             return $entity;
         }
         return $isRelated;
     }

    public function getStoreProductsCategoryForStoreSpecific($storeOwnerProfileId)
    {
       return $this->storeProductCategoryEntityRepository->getStoreProductsCategoryForStoreSpecific($storeOwnerProfileId);
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

    public function isItRelatedToProducts($id):string
    {
        $items = $this->storeProductCategoryEntityRepository->isItRelatedToProducts($id);

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
}
