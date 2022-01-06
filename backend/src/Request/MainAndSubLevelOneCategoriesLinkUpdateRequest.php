<?php

namespace App\Request;

class MainAndSubLevelOneCategoriesLinkUpdateRequest
{
//    private $linkType;

    /*
     * an array of main categories IDs
     * will be used when we want to link the sub category level one with one main category or more
     */
    private $mainCategoriesIDs;

    private $mainCategoryID;

    private $subCategoryLevelOneID;

//    /**
//     * @return mixed
//     */
//    public function getLinkType()
//    {
//        return $this->linkType;
//    }

    /**
     * @return mixed
     */
    public function getMainCategoriesIDs()
    {
        return $this->mainCategoriesIDs;
    }

    /**
     * @param mixed $mainCategoryID
     */
    public function setMainCategoryID($mainCategoryID): void
    {
        $this->mainCategoryID = $mainCategoryID;
    }

    /**
     * @return mixed
     */
    public function getSubCategoryLevelOneID()
    {
        return $this->subCategoryLevelOneID;
    }

}