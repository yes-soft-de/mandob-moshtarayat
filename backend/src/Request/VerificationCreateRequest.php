<?php

namespace App\Request;

class VerificationCreateRequest
{
    private $userID;

    private $code;

    /**
     * @param mixed $code
     */
    public function setCode($code): void
    {
        $this->code = $code;
    }

}