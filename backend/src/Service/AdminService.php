<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\UserEntity;
use App\Manager\AdminManager;
use App\Request\AdminCreateRequest;
use App\Response\AdminCreateResponse;

class AdminService
{
    private $autoMapping;
    private $adminManager;

    public function __construct(AutoMapping $autoMapping, AdminManager $adminManager)
    {
        $this->autoMapping = $autoMapping;
        $this->adminManager = $adminManager;
    }

    public function createAdmin(AdminCreateRequest $request)
    {
        $user = $this->getUserByUserID($request->getUserID());
        if ($user == null) {
            $user = $this->adminManager->createAdmin($request);
            return $this->autoMapping->map(UserEntity::class, AdminCreateResponse::class, $user);
        }
        $user['found']="yes";
        return $user;
    }

    public function getUserByUserID($userID)
    {
        return $this->adminManager->getUserByUserID($userID);
    }
}
