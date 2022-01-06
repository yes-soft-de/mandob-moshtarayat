<?php

namespace App\Request;

class OneAndSubLevelTwoCategoriesLinkUpdateRequest
{
    /*
     * will be used when we want to link the sub category level one with sub category level two
     */
    private $subCategoryLevelOneID;

    private $subCategoryLevelTwoID;

    /**
     * @return mixed
     */
    public function getSubCategoryLevelOneID()
    {
        return $this->subCategoryLevelOneID;
    }

    /**
     * @param mixed $subCategoryLevelOneID
     */
    public function setSubCategoryLevelOneID($subCategoryLevelOneID): void
    {
        $this->subCategoryLevelOneID = $subCategoryLevelOneID;
    }

    /**
     * @return mixed
     */
    public function getSubCategoryLevelTwoID()
    {
        return $this->subCategoryLevelTwoID;
    }

    /**
     * @param mixed $subCategoryLevelTwoID
     */
    public function setSubCategoryLevelTwoID($subCategoryLevelTwoID): void
    {
        $this->subCategoryLevelTwoID = $subCategoryLevelTwoID;
    }

}