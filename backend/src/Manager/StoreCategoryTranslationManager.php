<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\StoreCategoryTranslationEntity;
use App\Repository\StoreCategoryTranslationEntityRepository;
use App\Request\StoreCategoryTranslationCreateRequest;
use App\Request\StoreCategoryTranslationUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;

class StoreCategoryTranslationManager
{
    private $autoMapping;
    private $entityManager;
    private $storeCategoryTranslationEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, StoreCategoryTranslationEntityRepository $storeCategoryTranslationEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->storeCategoryTranslationEntityRepository = $storeCategoryTranslationEntityRepository;
    }

    public function createStoreCategoryTranslation(StoreCategoryTranslationCreateRequest $request)
    {
        $entity = $this->autoMapping->map(StoreCategoryTranslationCreateRequest::class, StoreCategoryTranslationEntity::class, $request);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }

    public function updateStoreCategoryTranslationByStoreCategoryIdAndLanguage(StoreCategoryTranslationUpdateRequest $request)
    {
        $storeCategoryTranslationEntity = $this->storeCategoryTranslationEntityRepository->getByStoreCategoryIdAndLanguage($request->getStoreCategoryID(),
            $request->getLanguage());

        if(!$storeCategoryTranslationEntity)
        {
            return 'storeCategoryTranslationNotFound';
        }
        else
        {
            $storeCategoryTranslationEntity = $this->autoMapping->mapToObject(StoreCategoryTranslationUpdateRequest::class, StoreCategoryTranslationEntity::class,
                $request, $storeCategoryTranslationEntity);

            $this->entityManager->flush();

            return $storeCategoryTranslationEntity;
        }
    }

    public function getStoreCategoriesTranslationByLanguage($language)
    {
        return $this->storeCategoryTranslationEntityRepository->getStoreCategoriesTranslationByLanguage($language);
    }

}