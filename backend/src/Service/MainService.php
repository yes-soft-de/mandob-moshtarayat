<?php

namespace App\Service;

use App\AutoMapping;
use App\Constant\UserConstant;
use App\Request\UserProfilePreferredLanguageUpdateRequest;
use App\Request\PreferredLanguageUpdateRequest;

class MainService
{
    private $autoMapping;
    private $captainProfileService;
    private $clientProfileService;
    private $storeOwnerProfileService;

    public function __construct(AutoMapping $autoMapping, CaptainProfileService $captainProfileService, ClientProfileService $clientProfileService,
     StoreOwnerProfileService $storeOwnerProfileService)
    {
        $this->autoMapping = $autoMapping;
        $this->captainProfileService = $captainProfileService;
        $this->clientProfileService = $clientProfileService;
        $this->storeOwnerProfileService = $storeOwnerProfileService;
    }

    public function updatePreferredLanguage(UserProfilePreferredLanguageUpdateRequest $request)
    {
        if ($request->getUserType() == UserConstant::$CAPTAIN)
        {
//            $captainPreferredLanguageRequest = $this->autoMapping->map(PreferredLanguageUpdateRequest::class, UserProfilePreferredLanguageUpdateRequest::class, $request);

            return $this->captainProfileService->updateCaptainProfilePreferredLanguage($request);
        }
        elseif ($request->getUserType() == UserConstant::$CLIENT)
        {
            return $this->clientProfileService->updateClientProfilePreferredLanguage($request);
        }
        elseif ($request->getUserType() == UserConstant::$STORE_OWNER)
        {
            return $this->storeOwnerProfileService->updateStoreOwnerProfilePreferredLanguage($request);
        }
    }

}