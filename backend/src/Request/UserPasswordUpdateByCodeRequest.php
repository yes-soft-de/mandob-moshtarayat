<?php

namespace App\Request;

class UserPasswordUpdateByCodeRequest
{
    private $code;

    private $password;

    private $passwordConfirmation;

    public function getCode()
    {
        return $this->code;
    }

    public function getPassword()
    {
        return $this->password;
    }

    public function getPasswordConfirmation()
    {
        return $this->passwordConfirmation;
    }

}