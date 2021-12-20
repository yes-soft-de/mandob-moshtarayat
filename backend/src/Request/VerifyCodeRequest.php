<?php

namespace App\Request;

class VerifyCodeRequest
{
    private $userID;

    private $code;

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
    public function getCode()
    {
        return $this->code;
    }

}