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
    private $storeCategoryEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, StoreCategoryEntityRepository $storeCategoryEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
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

        $entity = $this->autoMapping->mapToObject(StoreCategoryUpdateRequest::class, StoreCategoryEntity::class, $request, $entity);

        $this->entityManager->flush();

        return $entity;
    }

    public function getStoreCategories()
    {
       return $this->storeCategoryEntityRepository->getStoreCategories();
    }

    public function getStoreCategory($id): ?StoreCategoryEntity
    {
       return $this->storeCategoryEntityRepository->find($id);
    }
}
