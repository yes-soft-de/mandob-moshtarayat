<?php

namespace App\Request;

class PreferredLanguageUpdateRequest
{
    private $userID;

    private $userType;  // captain, client, or owner (refers to store owner)

    private $preferredLanguage;

    /**
     * @return mixed
     */
    public function getUserType()
    {
        return $this->userType;
    }

    /**
     * @param mixed $userID
     */
    public function setUserID($userID): void
    {
        $this->userID = $userID;
    }

}