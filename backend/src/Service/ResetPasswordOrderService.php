<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\ResetPasswordOrderEntity;
use App\Manager\ResetPasswordOrderManager;
use App\Request\ResetPasswordOrderCreateRequest;
use App\Request\VerifyResetPasswordCodeRequest;
use App\Request\UserPasswordUpdateRequest;
use App\Response\ResetPasswordOrderCreateResponse;
use App\Response\ResetPasswordOrdersGetResponse;
use App\Response\UserPasswordUpdateResponse;
use App\Response\VerifyResetPasswordCodeResponse;
use App\Response\UsersGetResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class ResetPasswordOrderService
{
    private $autoMapping;
    private $resetPasswordOrderManager;
    private $userService;
    private $params;
    private $malathSMSService;

    public function __construct(AutoMapping $autoMapping, ResetPasswordOrderManager $resetPasswordOrderManager, UserService $userService, ParameterBagInterface $params,
     MalathSMSService $malathSMSService)
    {
        $this->autoMapping = $autoMapping;
        $this->resetPasswordOrderManager = $resetPasswordOrderManager;
        $this->userService = $userService;
        $this->params = $params;
        $this->malathSMSService = $malathSMSService;
    }

    public function createResetPasswordOrder(ResetPasswordOrderCreateRequest $request)
    {
        // First, check if user exist
        if ($request->getRole()) {

            $user = $this->userService->getUserByUserIdAndRole($request->getUserID(), $request->getRole());

        } else {

            $user = $this->userService->getUserByUserID($request->getUserID());

        }

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

    public function verifyResetPasswordCode(VerifyResetPasswordCodeRequest $request)
    {
        $resetPasswordOrder = $this->resetPasswordOrderManager->getResetPasswordOrderByCode($request->getCode());

        if ($resetPasswordOrder)
        {
            $interval = date_diff(new \DateTime('now') , $resetPasswordOrder['createdAt']);

            $different_days = $interval->format('%d');

            if ($different_days == 0)
            {
                $different_hours = $interval->format('%h');

                if ($different_hours <= 1)
                {
                    $response['status'] = 'valid';
                }
                else
                {
                    $response['status'] = 'invalid';
                }
            }
            else
            {
                $response['status'] = 'invalid';
            }
        }
        else
        {
            $response['status'] = 'noCodeExist';
        }

        return $this->autoMapping->map('array', VerifyResetPasswordCodeResponse::class, $response);
    }

    public function sendSMSMessage($phone, $code)
    {
        $messageText = 'Please use this code to reset your password:'.' '.$code;

        // send SMS message
        $this->malathSMSService->setUserName($this->params->get('malath_username'));
        $this->malathSMSService->setPassword($this->params->get('malath_password'));

        $result = $this->malathSMSService->sendSMS($phone, "MANDOB-AD", $messageText);

        if($result)
        {
            if ($result['RESULT'] == 0)
            {
                // message sent successfully
                return 'sentSuccessfully';
            }
            elseif ($result['RESULT'] == 101)
            {
                // Parameter are missing
                return 'parameterAreMissing';
            }
            elseif ($result['RESULT'] == 104)
            {
                // either user name or password are missing or your Account is on hold
                return 'userNameOrPasswordAreMissingOrYourAccountIsOnHold';
            }
            elseif ($result['RESULT'] == 105)
            {
                // Credit are not available
                return 'creditAreNotAvailable';
            }
        }
    }

    public function updateUserPassword(UserPasswordUpdateRequest $request)
    {
        $result = $this->userService->updateUserPassword($request);

        if ($result == 'noUserFound')
        {
            $response['status'] = 'noUserFound';

            return $this->autoMapping->map('array', UserPasswordUpdateResponse::class, $response);
        }

        return $this->autoMapping->map(UsersGetResponse::class, UserPasswordUpdateResponse::class, $result);
    }

    public function getAllResetPasswordOrders()
    {
        $response = [];

        $resetPasswordOrders = $this->resetPasswordOrderManager->getAllResetPasswordOrders();

        foreach ($resetPasswordOrders as $resetPasswordOrder)
        {
            $response[] = $this->autoMapping->map('array', ResetPasswordOrdersGetResponse::class, $resetPasswordOrder);
        }

        return $response;
    }

}