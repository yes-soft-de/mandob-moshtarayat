<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\CaptainVacationEntity;
use App\Manager\CaptainVacationManager;
use App\Request\CaptainVacationCreateRequest;
use App\Response\CaptainVacationResponse;
use App\Service\CaptainService;

class CaptainVacationService
{
    private $autoMapping;
    private $captainVacationManager;
    private $captainProfileService;

    public function __construct(AutoMapping $autoMapping, CaptainVacationManager $captainVacationManager, CaptainProfileService $captainProfileService)
    {
        $this->autoMapping = $autoMapping;
        $this->captainProfileService = $captainProfileService;
        $this->captainVacationManager = $captainVacationManager;
    }

    public function createCaptainVacation(CaptainVacationCreateRequest $request)
    {
        $result = $this->captainVacationManager->createCaptainVacation($request);
        if ($result) {
           $this->captainProfileService->updateCaptainStateByAdmin($request); 
        }
        $respnose = $this->autoMapping->map(CaptainVacationEntity::class, CaptainVacationResponse::class, $result);
        
        return $respnose;
    }
}
