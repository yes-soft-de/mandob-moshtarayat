<?php

namespace App\Manager;

use App\AutoMapping;
use App\Constant\CategoryLinkTypeConstant;
use App\Entity\CategoryLinkEntity;
use App\Repository\CategoryLinkEntityRepository;
use App\Request\MainAndSubLevelOneCategoriesLinkUpdateRequest;
use App\Request\OneAndSubLevelTwoCategoriesLinkUpdateRequest;
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

    public function createMainAndSubLevelOneCategoryLink(MainAndSubLevelOneCategoriesLinkUpdateRequest $request)
    {
        $categoryLink = $this->autoMapping->map(MainAndSubLevelOneCategoriesLinkUpdateRequest::class, CategoryLinkEntity::class, $request);

        $categoryLink->setLinkType(CategoryLinkTypeConstant::$MAIN_WITH_LEVEL_ONE_LINK_TYPE);

        $this->entityManager->persist($categoryLink);
        $this->entityManager->flush();

        return $categoryLink;
    }

    public function updateLinkBetweenCategoriesOneAndTwo(OneAndSubLevelTwoCategoriesLinkUpdateRequest $request)
    {
        $categoryLink = $this->autoMapping->map(OneAndSubLevelTwoCategoriesLinkUpdateRequest::class, CategoryLinkEntity::class, $request);

        $categoryLink->setLinkType(CategoryLinkTypeConstant::$LEVEL_ONE_WITH_LEVEL_TWO_LINK_TYPE);

        $this->entityManager->persist($categoryLink);
        $this->entityManager->flush();

        return $categoryLink;
    }

    public function deleteAllMainAndSubLevelOneCategoriesLinkBySubCategoryLevelOneID($subCategoryLevelOneID)
    {
        $links = $this->categoryLinkEntityRepository->getAllMainAndSubLevelOneCategoryLinksBySubCategoryLevelOne($subCategoryLevelOneID);

        if ($links){

            foreach ($links as $link){

                $this->entityManager->remove($link);
                $this->entityManager->flush();
            }
        }
    }

    public function deleteAllSubLevelOneAndSubLevelTwoCategoriesLinkBySubCategoryLevelTwoID($subCategoryLevelTwoID)
    {
        $links = $this->categoryLinkEntityRepository->deleteAllSubLevelOneAndSubLevelTwoCategoriesLinkBySubCategoryLevelTwoID($subCategoryLevelTwoID);

        if ($links){

            foreach ($links as $link){

                $this->entityManager->remove($link);
                $this->entityManager->flush();
            }
        }
    }
}
