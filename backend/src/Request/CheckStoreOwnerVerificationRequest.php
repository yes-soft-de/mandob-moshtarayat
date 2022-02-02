<?php

namespace App\Request;

class CheckStoreOwnerVerificationRequest
{
    private $userID;

    /**
     * @return mixed
     */
    public function getUserID()
    {
        return $this->userID;
    }

}