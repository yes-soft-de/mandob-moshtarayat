<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\VerificationEntity;
use App\Manager\VerificationManager;
use App\Request\VerificationCreateRequest;
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

    public function createVerification(VerificationCreateRequest $request)
    {
        $item = $this->verificationManager->createVerification($request);

        return $this->autoMapping->map(VerificationEntity::class, VerificationCreateResponse::class, $item);
    }

}