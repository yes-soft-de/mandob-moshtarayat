<?php

namespace App\Request;

class ResetPasswordOrderCreateRequest
{
    private $userID;

    private $code;

    private $role;

    public function getUserID()
    {
        return $this->userID;
    }

    public function setCode($code)
    {
        $this->code = $code;
    }

    public function getRole()
    {
        return $this->role;
    }
}
