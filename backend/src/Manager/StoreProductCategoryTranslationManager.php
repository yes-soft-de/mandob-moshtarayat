<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\StoreProductCategoryTranslationEntity;
use App\Repository\StoreProductCategoryTranslationEntityRepository;
use App\Request\StoreProductCategoryTranslationCreateRequest;
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

}