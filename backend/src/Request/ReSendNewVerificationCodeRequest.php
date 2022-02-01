<?php

namespace App\Request;

class ReSendNewVerificationCodeRequest
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