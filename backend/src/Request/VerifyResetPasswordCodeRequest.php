<?php

namespace App\Request;

class VerifyResetPasswordCodeRequest
{
    private $code;

    public function getCode()
    {
        return $this->code;
    }

}