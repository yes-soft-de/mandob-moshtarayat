<?php

namespace App\Request;

class StoreCategoryUpdateRequest
{
    private $id;
    
    private $storeCategoryName;
    
    private $description;
    
    private $image;

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
     * Get the value of image
     */ 
    public function getImage()
    {
        return $this->image;
    }

    /**
     * Set the value of image
     *
     * @return  self
     */ 
    public function setImage($image)
    {
        $this->image = $image;

        return $this;
    }

    /**
     * Get the value of id
     */ 
    public function getId()
    {
        return $this->id;
    }
}
