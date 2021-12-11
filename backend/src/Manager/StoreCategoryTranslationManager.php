<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\StoreCategoryTranslationEntity;
use App\Request\StoreCategoryTranslationCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class StoreCategoryTranslationManager
{
    private $autoMapping;
    private $entityManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
    }

    public function createStoreCategoryTranslation(StoreCategoryTranslationCreateRequest $request)
    {
        $entity = $this->autoMapping->map(StoreCategoryTranslationCreateRequest::class, StoreCategoryTranslationEntity::class, $request);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }

}