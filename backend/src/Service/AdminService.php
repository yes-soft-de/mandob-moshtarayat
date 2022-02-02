<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\UserEntity;
use App\Manager\AdminManager;
use App\Request\AdminCreateRequest;
use App\Request\UserRegisterRequest;
use App\Response\AdminCreateResponse;
use App\Response\UserRegisterResponse;
use App\Service\RoomIdHelperService;

class AdminService
{
    private $autoMapping;
    private $adminManager;
    private $roomIdHelperService;

    public function __construct(AutoMapping $autoMapping, AdminManager $adminManager, RoomIdHelperService $roomIdHelperService)
    {
        $this->autoMapping = $autoMapping;
        $this->adminManager = $adminManager;
        $this->roomIdHelperService = $roomIdHelperService;
    }
//TODO this for remove

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

    public function adminRegister(UserRegisterRequest $request)
    {
        $request->setRoomID($this->roomIdHelperService->roomIdGenerate());

        $userRegister = $this->adminManager->adminRegister($request);
        if ($userRegister == "user is found")
        {
            $user['found']="yes";

            return $this->autoMapping->map("array", UserRegisterResponse::class, $user);
        }

        return $this->autoMapping->map(UserEntity::class, UserRegisterResponse::class, $userRegister);
    }

    public function getUserByUserID($userID)
    {
        return $this->adminManager->getUserByUserID($userID);
    }
}
