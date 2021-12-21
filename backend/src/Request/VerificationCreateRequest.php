<?php

namespace App\Request;

class VerificationCreateRequest
{
    private $userID;

    private $code;

    private $token;

    /**
     * @return mixed
     */
    public function getUserID()
    {
        return $this->userID;
    }

    /**
     * @param mixed $code
     */
    public function setCode($code): void
    {
        $this->code = $code;
    }

}