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
        $adminCreate = $this->adminManager->createAdmin($request);

        $response = $this->autoMapping->map(UserEntity::class, AdminCreateResponse::class, $adminCreate);

        return $response;
    }
}
