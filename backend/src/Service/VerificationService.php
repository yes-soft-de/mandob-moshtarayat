<?php

namespace App\Service;

use App\AutoMapping;
use App\Constant\StoreOwnerVerificationStatusConstant;
use App\Entity\VerificationEntity;
use App\Manager\VerificationManager;
use App\Request\StoreOwnerVerificationStatusUpdateRequest;
use App\Request\VerificationCreateRequest;
use App\Request\VerifyCodeRequest;
use App\Response\CodeVerificationResponse;
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
            $this->sendSMSMessage($request->getUserID());

            return $this->autoMapping->map(VerificationEntity::class, VerificationCreateResponse::class, $item);
        }
    }

    public function sendSMSMessage($phone)
    {
        $messageText = "شركة Yes Soft, رسالة تجريبية، الرجاء إعلامنا في حال وصول هذه الرسالة لكم.";

        // send SMS message
        $this->malathSMSService->setUserName($this->params->get('malath_username'));
        $this->malathSMSService->setPassword($this->params->get('malath_password'));

        $result = $this->malathSMSService->sendSMS("966550031000", "ACTIVE", $messageText);
        //dd($result);
        if($result)
        {
            if ($result['RESULT'] == 0)
            {
                // message sent successfully
            }
            elseif ($result['RESULT'] == 101)
            {
                // Parameter are missing
            }
            elseif ($result['RESULT'] == 104)
            {
                // either user name or password are missing or your Account is on hold
            }
            elseif ($result['RESULT'] == 105)
            {
                // Credit are not available
            }
        }
    }

    public function checkVerificationCode(VerifyCodeRequest $request)
    {
        $result = $this->verificationManager->checkVerificationCode($request);

        if($result['resultMessage'] = 'activated')
        {
            // update the verification status of the user
            $this->updateVerificationStatusOfUser($request, StoreOwnerVerificationStatusConstant::$VERIFIED_STATUS);
        }

        return $this->autoMapping->map('array', CodeVerificationResponse::class, $result);
    }

    public function updateVerificationStatusOfUser(VerifyCodeRequest $request, $verificationStatus)
    {
        $storeOwnerVerificationUpdateRequest = $this->autoMapping->map(VerifyCodeRequest::class, StoreOwnerVerificationStatusUpdateRequest::class, $request);

        $storeOwnerVerificationUpdateRequest->setVerificationStatus($verificationStatus);

        $this->userService->updateStoreOwnerVerificationStatus($storeOwnerVerificationUpdateRequest);
    }

}