<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\ProductTranslationEntity;
use App\Repository\ProductTranslationEntityRepository;
use App\Request\ProductTranslationCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class ProductTranslationManager
{
    private $autoMapping;
    private $entityManager;
    private $productTranslationEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, ProductTranslationEntityRepository $productTranslationEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->productTranslationEntityRepository = $productTranslationEntityRepository;
    }

    public function createProductTranslation(ProductTranslationCreateRequest $request)
    {
        $productTranslationEntity = $this->autoMapping->map(ProductTranslationCreateRequest::class, ProductTranslationEntity::class, $request);

        $this->entityManager->persist($productTranslationEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $productTranslationEntity;
    }

}