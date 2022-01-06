<?php

namespace App\Service;

use App\AutoMapping;
use App\Constant\CategoryLinkTypeConstant;
use App\Entity\CategoryLinkEntity;
use App\Manager\CategoryLinkManager;
use App\Request\MainAndSubLevelOneCategoriesLinkUpdateRequest;
use App\Request\OneAndSubLevelTwoCategoriesLinkUpdateRequest;
use App\Response\CategoryLinkCreateResponse;

class CategoryLinkService
{
    private $autoMapping;
    private $categoryLinkManager;

    public function __construct(AutoMapping $autoMapping, CategoryLinkManager $categoryLinkManager)
    {
        $this->autoMapping = $autoMapping;
        $this->categoryLinkManager = $categoryLinkManager;
    }

    public function updateMainAndSubLevelOneCategoriesLink(MainAndSubLevelOneCategoriesLinkUpdateRequest $request)
    {
        $response = [];

        $mainCategoriesIDsArray = $request->getMainCategoriesIDs();

        if ($mainCategoriesIDsArray)
        {
            // First delete all old links
            $this->categoryLinkManager->deleteAllMainAndSubLevelOneCategoriesLinkBySubCategoryLevelOneID($request->getSubCategoryLevelOneID());

            // Then insert the new ones
            foreach ($mainCategoriesIDsArray as $mainCategoryID)
            {
                //create link for each main category id with sub category id
                $request->setMainCategoryID($mainCategoryID);

                $result = $this->categoryLinkManager->createMainAndSubLevelOneCategoryLink($request);

                $response[] = $this->autoMapping->map(CategoryLinkEntity::class, CategoryLinkCreateResponse::class, $result);
            }
        }

        return $response;
    }

    public function updateLinkBetweenCategoriesOneAndTwo(OneAndSubLevelTwoCategoriesLinkUpdateRequest $request)
    {
        $response = [];

       // First delete all old links
        $this->categoryLinkManager->deleteAllSubLevelOneAndSubLevelTwoCategoriesLinkBySubCategoryLevelTwoID($request->getSubCategoryLevelTwoID());

       // Then insert the new link
        $result = $this->categoryLinkManager->updateLinkBetweenCategoriesOneAndTwo($request);

        $response[] = $this->autoMapping->map(CategoryLinkEntity::class, CategoryLinkCreateResponse::class, $result);

        return $response;
    }
}
