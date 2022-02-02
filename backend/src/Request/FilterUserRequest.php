<?php

namespace App\Request;

class FilterUserRequest
{
    private $userID;

    private $roles;

    private $verificationStatus;

    /**
     * @return mixed
     */
    public function getUserID()
    {
        return $this->userID;
    }

    /**
     * @return mixed
     */
    public function getRoles()
    {
        return $this->roles;
    }

    /**
     * @return mixed
     */
    public function getVerificationStatus()
    {
        return $this->verificationStatus;
    }

}