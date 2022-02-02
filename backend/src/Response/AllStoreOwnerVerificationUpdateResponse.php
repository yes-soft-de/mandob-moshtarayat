<?php

namespace App\Response;

class AllStoreOwnerVerificationUpdateResponse
{
    public $id;

    public $userID;

    public $userName;

    public $roles = [];

    public $createDate;

    public $verificationStatus;
}
