<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\VerificationEntity;
use App\Manager\VerificationManager;
use App\Request\VerificationCreateRequest;
use App\Request\VerifyCodeRequest;
use App\Response\CodeVerificationResponse;
use App\Response\VerificationCreateResponse;

class VerificationService
{
    private $autoMapping;
    private $verificationManager;

    public function __construct(AutoMapping $autoMapping, VerificationManager $verificationManager)
    {
        $this->autoMapping = $autoMapping;
        $this->verificationManager = $verificationManager;
    }

    public function createVerificationCode(VerificationCreateRequest $request)
    {
        $item = $this->verificationManager->createVerificationCode($request);

        return $this->autoMapping->map(VerificationEntity::class, VerificationCreateResponse::class, $item);
    }

    public function checkVerificationCode(VerifyCodeRequest $request)
    {
        $result = $this->verificationManager->checkVerificationCode($request);

        return $this->autoMapping->map('array', CodeVerificationResponse::class, $result);
    }

}