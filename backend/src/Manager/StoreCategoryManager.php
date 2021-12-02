<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\StoreCategoryEntity;
use App\Repository\StoreCategoryEntityRepository;
use App\Request\StoreCategoryCreateRequest;
use App\Request\StoreCategoryUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;


class StoreCategoryManager
{
    private $autoMapping;
    private $entityManager;
    private $userManager;
    private $storeCategoryEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, StoreCategoryEntityRepository $storeCategoryEntityRepository,
     UserManager $userManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->userManager = $userManager;
        $this->storeCategoryEntityRepository = $storeCategoryEntityRepository;
    }

    public function createStoreCategory(StoreCategoryCreateRequest $request)
    {
        $entity = $this->autoMapping->map(StoreCategoryCreateRequest::class, StoreCategoryEntity::class, $request);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }

    public function updateStoreCategory(StoreCategoryUpdateRequest $request)
    {
      $entity = $this->storeCategoryEntityRepository->find($request->getId());
      if(!$entity){
          return $entity;
      }
      $entity = $this->autoMapping->mapToObject(StoreCategoryUpdateRequest::class, StoreCategoryEntity::class, $request, $entity);

      $this->entityManager->flush();

      return $entity;
    }

    public function getStoreCategories()
    {
       return $this->storeCategoryEntityRepository->getStoreCategories();
    }

    public function getFavouriteStoreCategoriesAndStores($clientID)
    {
        $favouriteCategories = $this->userManager->getFavouriteCategoriesIDsByClientID($clientID);

        if($favouriteCategories)
        {
            return $this->storeCategoryEntityRepository->getStoreCategoriesByClientFavouriteCategoriesIDs($favouriteCategories['favouriteCategories']);
        }
        else
        {
            return $this->storeCategoryEntityRepository->getStoreCategoriesByClientFavouriteCategoriesIDs($favouriteCategories);
        }

    }

    public function getStoreCategory($id): ?StoreCategoryEntity
    {
       return $this->storeCategoryEntityRepository->find($id);
    }

    public function isItRelatedToSubcategories($id):string
    {
        $items = $this->storeCategoryEntityRepository->isItRelatedToSubcategories($id);
        if($items) {
            return "related";
        }

        return "not related";
    }
}

