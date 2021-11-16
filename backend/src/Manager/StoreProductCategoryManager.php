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
         $entity = $this->storeProductCategoryEntityRepository->find($request->getId());
         if (!$entity) {
             return null;
         }
         $entity = $this->autoMapping->mapToObject(StoreProductCategoryLevelOneUpdateRequest::class, StoreProductCategoryEntity::class, $request, $entity);

         $this->entityManager->flush();

         return $entity;
     }

     public function updateStoreProductCategoryLevelTwo(StoreProductCategoryLevelTwoUpdateRequest $request)
     {
         $entity = $this->storeProductCategoryEntityRepository->find($request->getId());
         if (!$entity) {
             return null;
         }
         $entity = $this->autoMapping->mapToObject(StoreProductCategoryLevelTwoUpdateRequest::class, StoreProductCategoryEntity::class, $request, $entity);

         $this->entityManager->flush();

         return $entity;
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
}
