<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\CategoryLinkEntity;
use App\Repository\CategoryLinkEntityRepository;
use App\Request\CategoryLinkCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class CategoryLinkManager
{
    private $autoMapping;
    private $entityManager;
    private $categoryLinkEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, CategoryLinkEntityRepository $categoryLinkEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->categoryLinkEntityRepository = $categoryLinkEntityRepository;
    }

    public function createCategoryLink(CategoryLinkCreateRequest $request)
    {
        $categoryLink = $this->autoMapping->map(CategoryLinkCreateRequest::class, CategoryLinkEntity::class, $request);

        $this->entityManager->persist($categoryLink);
        $this->entityManager->flush();

        return $categoryLink;
    }
}
