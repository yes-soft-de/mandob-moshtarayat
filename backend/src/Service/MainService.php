<?php

namespace App\Service;

use App\AutoMapping;
use App\Constant\UserConstant;
use App\Request\CaptainProfilePreferredLanguageUpdateRequest;
use App\Request\PreferredLanguageUpdateRequest;

class MainService
{
    private $autoMapping;
    private $captainProfileService;

    public function __construct(AutoMapping $autoMapping, CaptainProfileService $captainProfileService)
    {
        $this->autoMapping = $autoMapping;
        $this->captainProfileService = $captainProfileService;

    }

    public function updatePreferredLanguage(PreferredLanguageUpdateRequest $request)
    {
        if ($request->getUserType() == UserConstant::$CAPTAIN)
        {
            $captainPreferredLanguageRequest = $this->autoMapping->map(PreferredLanguageUpdateRequest::class, CaptainProfilePreferredLanguageUpdateRequest::class, $request);

            return $this->captainProfileService->updateCaptainProfilePreferredLanguage($captainPreferredLanguageRequest);
        }
        elseif ($request->getUserType() == UserConstant::$CLIENT)
        {
            // to be continued
        }
        elseif ($request->getUserType() == UserConstant::$STORE_OWNER)
        {
            // to be continued
        }
    }

}