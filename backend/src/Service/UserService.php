<?php

namespace App\Service;

use App\Manager\UserManager;


class UserService
{
    private $userManager;

    public function __construct(UserManager $userManager)
    {
        $this->userManager = $userManager;
    }

    public function checkUserType($userType,$userID)
    {
        return $this->userManager->checkUserType($userType,$userID);
       
    }
}