<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\StoreCategoryEntity;
use App\Repository\StoreCategoryEntityRepository;
use App\Request\DeleteRequest;
use App\Request\StoreCategoryCreateRequest;
use App\Request\StoreCategoryTranslationCreateRequest;
use App\Request\StoreCategoryUpdateRequest;
use App\Request\StoreCategoryWithTranslationCreateRequest;
use Doctrine\ORM\EntityManagerInterface;


class StoreCategoryManager
{
    private $autoMapping;
    private $entityManager;
    private $userManager;
    private $storeCategoryTranslationManager;
    private $storeCategoryEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, StoreCategoryEntityRepository $storeCategoryEntityRepository,
     UserManager $userManager, StoreCategoryTranslationManager $storeCategoryTranslationManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->userManager = $userManager;
        $this->storeCategoryTranslationManager = $storeCategoryTranslationManager;
        $this->storeCategoryEntityRepository = $storeCategoryEntityRepository;
    }

    public function createStoreCategory(StoreCategoryWithTranslationCreateRequest $request)
    {
        // First insert the data in the essential language
        $storeCategoryCreateRequest = $this->autoMapping->map('array', StoreCategoryCreateRequest::class, $request->getData());

        $entity = $this->autoMapping->map(StoreCategoryCreateRequest::class, StoreCategoryEntity::class, $storeCategoryCreateRequest);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        // Secondly, insert the translation data
        if($request->getTranslate())
        {
            $this->createStoreCategoryTranslation($request->getTranslate(), $entity->getId());
        }

        return $entity;
    }

    public function createStoreCategoryTranslation($translationArrayRequest, $storeCategoryID)
    {
        if($translationArrayRequest)
        {
            foreach($translationArrayRequest as $translationRequest)
            {
                $storeCategoryTranslationCreateRequest = $this->autoMapping->map('array', StoreCategoryTranslationCreateRequest::class, $translationRequest);

                $storeCategoryTranslationCreateRequest->setStoreCategoryID($storeCategoryID);

                $this->storeCategoryTranslationManager->createStoreCategoryTranslation($storeCategoryTranslationCreateRequest);
            }
        }
        else
        {
            // No translations were provided!
            // Skip inserting translations
        }
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

    public function getLast15StoreCategories()
    {
       return $this->storeCategoryEntityRepository->getLast15StoreCategories();
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

    public function getFavouriteStoreCategories($clientID)
    {
        $favouriteCategories = $this->userManager->getFavouriteCategoriesIDsByClientID($clientID);

        return $this->storeCategoryEntityRepository->getStoreCategoriesByClientFavouriteCategoriesIDs($favouriteCategories['favouriteCategories']);

    }

    public function getStoreCategory($id): ?StoreCategoryEntity
    {
       return $this->storeCategoryEntityRepository->find($id);
    }

    public function isItRelatedToSubcategoriesOrStore($id):string
    {
        $items = $this->storeCategoryEntityRepository->isItRelatedToSubcategoriesOrStore($id);
        if($items) {
            return "related";
        }

        return "not related";
    }

    public function deleteStoreCategoryByID(DeleteRequest $request)
    {
        $storeCategoryEntity = $this->storeCategoryEntityRepository->find($request->getId());

        if(!$storeCategoryEntity){
            return 'storeCategoryNotFound';
        }
        else{
            $this->entityManager->remove($storeCategoryEntity);
            $this->entityManager->flush();

            return $storeCategoryEntity;
        }
    }
}

