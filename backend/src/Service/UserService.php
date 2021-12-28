<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\UserEntity;
use App\Manager\UserManager;
use App\Request\StoreOwnerVerificationStatusUpdateRequest;
use App\Request\UserPasswordUpdateRequest;
use App\Response\AllStoreOwnerVerificationUpdateResponse;
use App\Response\StoreOwnerVerificationStatusUpdateResponse;
use App\Response\UsersGetResponse;


class UserService
{
    private $autoMapping;
    private $userManager;

    public function __construct(AutoMapping $autoMapping, UserManager $userManager)
    {
        $this->autoMapping = $autoMapping;
        $this->userManager = $userManager;
    }

    public function checkUserType($userType,$userID)
    {
        return $this->userManager->checkUserType($userType,$userID);
       
    }

    public function getStoreProfileId($userID)
    {
        return $this->userManager->getStoreProfileId($userID);

    }

    public function updateStoreOwnerVerificationStatus(StoreOwnerVerificationStatusUpdateRequest $request)
    {
        $userResult = $this->userManager->updateStoreOwnerVerificationStatus($request);

        if ($userResult == 'noUserWasFound')
        {

        }
        else
        {
            return $this->autoMapping->map(UserEntity::class, StoreOwnerVerificationStatusUpdateResponse::class, $userResult);
        }
    }

    public function getUserVerificationStatusByUserID($userID)
    {
        return $this->userManager->getUserVerificationStatusByUserID($userID);
    }

    public function updateAllStoreOwnersVerificationStatusByDeveloper()
    {
        $response = [];

        $result = $this->userManager->updateAllStoreOwnersVerificationStatusByDeveloper();

        if ($result == 'noUsers')
        {

        }
        else
        {
            foreach ($result as $user)
            {
                $response[] = $this->autoMapping->map(UserEntity::class, AllStoreOwnerVerificationUpdateResponse::class, $user);
            }

            return $response;
        }
    }

    public function getAllStoreOwners()
    {
        $response = [];

        $result = $this->userManager->getAllStoreOwners();

        foreach ($result as $user)
        {
            $response[] = $this->autoMapping->map(UserEntity::class, UsersGetResponse::class, $user);
        }

        return $response;
    }

    public function getUserByUserID($userID)
    {
        $user = $this->userManager->getUserByUserID($userID);

        if($user)
        {
            return $this->autoMapping->map('array', UsersGetResponse::class, $user);
        }
    }

    public function updateUserPassword(UserPasswordUpdateRequest $request)
    {
        $result = $this->userManager->updateUserPassword($request);

        if ($result == 'noUserFound')
        {
            return 'noUserFound';
        }
        else
        {
            return $this->autoMapping->map(UserEntity::class, UsersGetResponse::class, $result);
        }
    }

    public function deleteUserById($id)
    {
        return $this->userManager->deleteUserById($id);
    }
}
