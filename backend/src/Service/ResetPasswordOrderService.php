<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\ResetPasswordOrderEntity;
use App\Manager\ResetPasswordOrderManager;
use App\Request\ResetPasswordOrderCreateRequest;
use App\Request\UserPasswordUpdateByCodeRequest;
use App\Request\UserPasswordUpdateRequest;
use App\Response\ResetPasswordOrderCreateResponse;
use App\Response\UpdatePasswordResponse;
use App\Response\UsersGetResponse;

class ResetPasswordOrderService
{
    private $autoMapping;
    private $resetPasswordOrderManager;
    private $userService;

    public function __construct(AutoMapping $autoMapping, ResetPasswordOrderManager $resetPasswordOrderManager, UserService $userService)
    {
        $this->autoMapping = $autoMapping;
        $this->resetPasswordOrderManager = $resetPasswordOrderManager;
        $this->userService = $userService;
    }

    public function createResetPasswordOrder(ResetPasswordOrderCreateRequest $request)
    {
        // First, check if user exist
        $user = $this->userService->getUserByUserID($request->getUserID());

        if ($user)
        {
            // while user exists, then make a new reset password order
            $resetPasswordOrder = $this->resetPasswordOrderManager->createResetPasswordOrder($request);

            if ($resetPasswordOrder)
            {
                // send code in SMS message
                $this->sendSMSMessage($resetPasswordOrder->getUserID(), $resetPasswordOrder->getCode());

                return $this->autoMapping->map(ResetPasswordOrderEntity::class, ResetPasswordOrderCreateResponse::class, $resetPasswordOrder);
            }
        }
        else
        {
            $response['status'] = 'noUserFound';

            return $this->autoMapping->map('array', ResetPasswordOrderCreateResponse::class, $response);
        }
    }

    public function authenticateUpdateUserPassword(UserPasswordUpdateByCodeRequest $request)
    {
        // First, check if code is still valid
        $codeValidation = $this->checkCodeValidation($request->getCode());

        if ($codeValidation == 'valid')
        {
            // then, check if password and its confirmation are matched
            if ($request->getPassword() != $request->getPasswordConfirmation())
            {
                $response['status'] = 'unmatchedPasswords';

                return $this->autoMapping->map('array', UpdatePasswordResponse::class, $response);
            }
            else
            {
                // finally, update the user's password
                $result = $this->updateUserPassword($request);

                if ($result == 'noUserFound')
                {
                    $response['status'] = 'noUserFound';

                    return $this->autoMapping->map('array', UpdatePasswordResponse::class, $response);
                }
                else
                {
                    return $this->autoMapping->map(UsersGetResponse::class, UpdatePasswordResponse::class, $result);
                }
            }
        }

        $response['status'] = $codeValidation;

        return $this->autoMapping->map('array', UpdatePasswordResponse::class, $response);
    }

    public function sendSMSMessage($phone, $code)
    {
        /*
         * To be used later
         */
    }

    public function checkCodeValidation($code)
    {
        $resetPasswordOrder = $this->resetPasswordOrderManager->getResetPasswordOrderByCode($code);

        if ($resetPasswordOrder)
        {
            $interval = date_diff(new \DateTime('now') , $resetPasswordOrder['createdAt']);

            $different_days = $interval->format('%d');

            if ($different_days == 0)
            {
                $different_hours = $interval->format('%h');

                if ($different_hours <= 1)
                {
                    return 'valid';
                }
                else
                {
                    return 'invalid';
                }
            }
            else
            {
                return 'invalid';
            }
        }
        else
        {
            return 'noCodeExist';
        }
    }

    public function updateUserPassword(UserPasswordUpdateByCodeRequest $request)
    {
        $userID = $this->resetPasswordOrderManager->getResetPasswordOrderByCode($request->getCode())['userID'];

        $updatePasswordRequest = $this->autoMapping->map(UserPasswordUpdateByCodeRequest::class, UserPasswordUpdateRequest::class, $request);

        $updatePasswordRequest->setUserID($userID);

        return $this->userService->updateUserPassword($updatePasswordRequest);
    }

}