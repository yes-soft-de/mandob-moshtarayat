<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\ResetPasswordOrderEntity;
use App\Manager\ResetPasswordOrderManager;
use App\Request\ResetPasswordOrderCreateRequest;
use App\Response\ResetPasswordOrderCreateResponse;

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

    public function sendSMSMessage($phone, $code)
    {
        /*
         * To be used later
         */
    }

}