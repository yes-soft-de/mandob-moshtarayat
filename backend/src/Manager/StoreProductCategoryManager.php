<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\StoreProductCategoryEntity;
use App\Repository\StoreProductCategoryEntityRepository;
use App\Request\StoreProductCategoryCreateRequest;
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

    public function createStoreProductCategory(StoreProductCategoryCreateRequest $request)
    {
        $entity = $this->autoMapping->map(StoreProductCategoryCreateRequest::class, StoreProductCategoryEntity::class, $request);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }

     public function updateStoreProductCategory(StoreProductCategoryUpdateRequest $request)
     {
         $entity = $this->storeProductCategoryEntityRepository->find($request->getId());

         if (!$entity) {
             return null;
         }
         $entity = $this->autoMapping->mapToObject(StoreProductCategoryUpdateRequest::class, StoreProductCategoryEntity::class, $request, $entity);

         $this->entityManager->flush();

         return $entity;
     }

    public function getStoreProductsCategoryForStoreSpecific($storeOwnerProfileId)
    {
       return $this->storeProductCategoryEntityRepository->getStoreProductsCategoryForStoreSpecific($storeOwnerProfileId);
    }
}
