<?php

namespace App\Request;

class StoreOwnerVerificationStatusUpdateRequest
{
    private $userID;

    private $verificationStatus;

    /**
     * @return mixed
     */
    public function getUserID()
    {
        return $this->userID;
    }

    /**
     * @param mixed $userID
     */
    public function setUserID($userID): void
    {
        $this->userID = $userID;
    }

    /**
     * @param mixed $verificationStatus
     */
    public function setVerificationStatus($verificationStatus): void
    {
        $this->verificationStatus = $verificationStatus;
    }

}