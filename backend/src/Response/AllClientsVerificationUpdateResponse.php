<?php

namespace App\Response;

class AllClientsVerificationUpdateResponse
{
    public $id;

    public $userID;

    public $userName;

    public $roles = [];

    public $createDate;

    public $verificationStatus;
}
