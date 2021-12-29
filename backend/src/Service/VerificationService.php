<?php

namespace App\Service;

use App\AutoMapping;
use App\Constant\UserVerificationStatusConstant;
use App\Entity\VerificationEntity;
use App\Manager\VerificationManager;
use App\Request\CheckStoreOwnerVerificationRequest;
use App\Request\ReSendNewVerificationCodeRequest;
use App\Request\UserVerificationStatusUpdateRequest;
use App\Request\VerificationCreateRequest;
use App\Request\VerifyCodeRequest;
use App\Response\CodeVerificationResponse;
use App\Response\NewVerificationCodeResponse;
use App\Response\StoreOwnerVerificationStatusGetResponse;
use App\Response\VerificationCreateResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class VerificationService
{
    private $autoMapping;
    private $verificationManager;
    private $malathSMSService;
    private $userService;
    private $params;

    public function __construct(AutoMapping $autoMapping, VerificationManager $verificationManager, MalathSMSService $malathSMSService, ParameterBagInterface $params,
     UserService $userService)
    {
        $this->autoMapping = $autoMapping;
        $this->verificationManager = $verificationManager;
        $this->malathSMSService = $malathSMSService;
        $this->userService = $userService;
        $this->params = $params;
    }

    public function createVerificationCode(VerificationCreateRequest $request)
    {
        $item = $this->verificationManager->createVerificationCode($request);

        if($item)
        {
            $result = $this->sendSMSMessage($request->getUserID(), $item->getCode());

            $response = $this->autoMapping->map(VerificationEntity::class, VerificationCreateResponse::class, $item);

            $response->smsMessageStatus = $result;

            return $response;
        }
    }

    public function sendSMSMessage($phone, $code)
    {
        $messageText = 'Please use this code to activate your account:'.' '.$code;

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

    public function checkVerificationCode(VerifyCodeRequest $request)
    {
        $result = $this->verificationManager->checkVerificationCode($request);

        if($result['resultMessage'] == 'activated')
        {
            // update the verification status of the user
            $this->updateVerificationStatusOfUser($request, UserVerificationStatusConstant::$VERIFIED_STATUS);
        }

        return $this->autoMapping->map('array', CodeVerificationResponse::class, $result);
    }

    public function updateVerificationStatusOfUser(VerifyCodeRequest $request, $verificationStatus)
    {
        $userVerificationUpdateRequest = $this->autoMapping->map(VerifyCodeRequest::class, UserVerificationStatusUpdateRequest::class, $request);

        $userVerificationUpdateRequest->setVerificationStatus($verificationStatus);

        $this->userService->updateUserVerificationStatus($userVerificationUpdateRequest);
    }

    public function reSendNewVerificationCode(ReSendNewVerificationCodeRequest $request)
    {
        $response = [];

        /**
         * First, check if the user which ask for new code is not verified yet.
         */
        $verificationStatus = $this->userService->getUserVerificationStatusByUserID($request->getUserID());

        if (!$verificationStatus['verificationStatus'])
        {
            // provided user isn't registered!
            $response['result'] = 'userIsNotRegistered';
        }
        else
        {
            if ($verificationStatus['verificationStatus'] != UserVerificationStatusConstant::$VERIFIED_STATUS)
            {
                // we can send new code
                // Now, delete previous sent codes for the same user
                $result = $this->verificationManager->deleteAllVerificationCodesForUser($request->getUserID());

                if ($result == 'noMoreCodeAreExist')
                {
                    // Finally, insert new code for the user
                    $newVerificationCodeRequest = $this->autoMapping->map(ReSendNewVerificationCodeRequest::class, VerificationCreateRequest::class, $request);

                    $this->createVerificationCode($newVerificationCodeRequest);

                    $response['result'] = 'newCodeWasSent';
                }
            }
            elseif ($verificationStatus['verificationStatus'] == UserVerificationStatusConstant::$VERIFIED_STATUS)
            {
                // user is verified. we can't send new code
                $response['result'] = 'userAlreadyVerified';
            }
        }

        return $this->autoMapping->map('array', NewVerificationCodeResponse::class, $response);
    }

    public function getUserVerificationStatusByUserID(CheckStoreOwnerVerificationRequest $request)
    {
        $result = $this->userService->getUserVerificationStatusByUserID($request->getUserID());

        if ($result['verificationStatus'])
        {
            return $this->autoMapping->map('array', StoreOwnerVerificationStatusGetResponse::class, $result);
        }
        else
        {
            $result['verificationStatus'] = 'notYet';

            return $this->autoMapping->map('array', StoreOwnerVerificationStatusGetResponse::class, $result);
        }
    }

    public function getVerificationCodeByUserID($userID)
    {
        return $this->verificationManager->getVerificationCodeByUserID($userID);
    }

    public function deleteByID($request)
    {
        $verificationEntity = $this->verificationManager->deleteByID($request);

        if($verificationEntity == 'notFound')
        {

        }
        else
        {
            return $this->autoMapping->map(VerificationEntity::class, VerificationCreateResponse::class, $verificationEntity);
        }

        return $verificationEntity;
    }

}