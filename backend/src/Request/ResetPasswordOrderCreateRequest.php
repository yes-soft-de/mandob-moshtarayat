<?php

namespace App\Request;

class ResetPasswordOrderCreateRequest
{
    private $userID;

    private $code;

    public function getUserID()
    {
        return $this->userID;
    }

    public function setCode($code)
    {
        $this->code = $code;
    }

}