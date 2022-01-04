<?php

namespace App\Service;

use App\AutoMapping;
use App\Constant\CategoryLinkTypeConstant;
use App\Entity\CategoryLinkEntity;
use App\Manager\CategoryLinkManager;
use App\Request\CategoryLinkCreateRequest;
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

    public function createCategoryLink(CategoryLinkCreateRequest $request)
    {
        $response = [];

        // First check the type of the link
        if ($request->getLinkType() == CategoryLinkTypeConstant::$MAIN_WITH_LEVEL_ONE_LINK_TYPE)
        {
            $mainCategoriesIDsArray = $request->getMainCategoriesIDs();

            if ($mainCategoriesIDsArray)
            {
                foreach ($mainCategoriesIDsArray as $mainCategoryID)
                {
                    //create link for each main category id with sub category id
                    $request->setMainCategoryID($mainCategoryID);

                    $result = $this->categoryLinkManager->createCategoryLink($request);

                    $response[] = $this->autoMapping->map(CategoryLinkEntity::class, CategoryLinkCreateResponse::class, $result);
                }
            }
        }
        elseif ($request->getLinkType() == CategoryLinkTypeConstant::$LEVEL_ONE_WITH_LEVEL_TWO_LINK_TYPE)
        {
            $result = $this->categoryLinkManager->createCategoryLink($request);

            $response[] = $this->autoMapping->map(CategoryLinkEntity::class, CategoryLinkCreateResponse::class, $result);
        }

        return $response;
    }

}