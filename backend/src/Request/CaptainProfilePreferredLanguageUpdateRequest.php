<?php

namespace App\Request;

class CaptainProfilePreferredLanguageUpdateRequest
{
    private $userID;

    private $preferredLanguage;

    /**
     * Get the value of userID
     */ 
    public function getUserID()
    {
        return $this->userID;
    }

    /**
     * Set the value of userID
     *
     * @return  self
     */ 
    public function setUserID($userID)
    {
        $this->userID = $userID;

        return $this;
    }

    /**
     * Get the value of identity
     */ 
    public function getPreferredLanguage()
    {
        return $this->preferredLanguage;
    }

    /**
     * Set the value of identity
     *
     * @return  self
     */ 
    public function setPreferredLanguage($preferredLanguage)
    {
        $this->preferredLanguage = $preferredLanguage;

        return $this;
    }
}
