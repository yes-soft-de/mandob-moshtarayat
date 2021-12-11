<?php

namespace App\Request;

class StoreCategoryTranslationCreateRequest
{
    private $storeCategoryID;

    private $storeCategoryName;
  
    private $description;

    private $language;

    /**
     * @param mixed $storeCategoryID
     */
    public function setStoreCategoryID($storeCategoryID): void
    {
        $this->storeCategoryID = $storeCategoryID;
    }

    /**
     * Get the value of StoreCategoryName
     */ 
    public function getStoreCategoryName()
    {
        return $this->storeCategoryName;
    }

    /**
     * Set the value of StoreCategoryName
     *
     * @return  self
     */ 
    public function setStoreCategoryName($storeCategoryName)
    {
        $this->storeCategoryName = $storeCategoryName;

        return $this;
    }

    /**
     * Get the value of description
     */ 
    public function getDescription()
    {
        return $this->description;
    }

    /**
     * Set the value of description
     *
     * @return  self
     */ 
    public function setDescription($description)
    {
        $this->description = $description;

        return $this;
    }

    /**
     * @param mixed $language
     */
    public function setLanguage($language): void
    {
        $this->language = $language;
    }

}
