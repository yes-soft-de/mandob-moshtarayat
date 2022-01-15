<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\MandobProfileEntity;
use App\Entity\UserEntity;
use App\Request\ActivateMandobAccountByAdminRequest;
use App\Request\MandobProfileUpdateRequest;
use App\Request\UserRegisterRequest;
use App\Request\VerificationCreateRequest;
use App\Response\ActivateMandobAccountByAdminResponse;
use App\Response\MandobFilterByStatusResponse;
use App\Response\MandobProfileCreateResponse;
use App\Response\RepresentativeProfileForAdminGetResponse;
use App\Response\RepresentativeProfileGetResponse;
use App\Response\UserRegisterResponse ;
use App\Manager\MandobProfileManager;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class MandobProfileService
{
    private $autoMapping;
    private $params;
    private $roomIdHelperService;
    private $verificationService;
    private $mandobProfileManager;

    public function __construct(AutoMapping $autoMapping, ParameterBagInterface $params, RoomIdHelperService $roomIdHelperService, MandobProfileManager $mandobProfileManager,
                                VerificationService $verificationService)
    {
        $this->autoMapping = $autoMapping;
        $this->roomIdHelperService = $roomIdHelperService;
        $this->verificationService = $verificationService;
        $this->mandobProfileManager = $mandobProfileManager;

        $this->params = $params->get('upload_base_url') . '/';
    }

    public function mandobRegister(UserRegisterRequest $request)
    {
        $request->setRoomID($this->roomIdHelperService->roomIdGenerate());
        $userRegister = $this->mandobProfileManager->mandobRegister($request);
        if ($userRegister == "user is found") {
            $user['found']="yes";

            return $this->autoMapping->map("array", UserRegisterResponse::class, $user);
        }

        $this->createVerificationCodeForMandob($request);

        return $this->autoMapping->map(UserEntity::class, UserRegisterResponse::class, $userRegister);
    }

    public function createVerificationCodeForMandob(UserRegisterRequest $userEntity)
    {
        $createVerificationRequest = $this->autoMapping->map(UserRegisterRequest::class, VerificationCreateRequest::class, $userEntity);

        $this->verificationService->createVerificationCode($createVerificationRequest);
    }

    public function getProfileByMandobID($mandobID)
    {
        $mandobProfile = $this->mandobProfileManager->getProfileByMandobID($mandobID);

        $mandobProfile['image'] = $this->getImageParams($mandobProfile['image'], $this->params . $mandobProfile['image'], $this->params);

        return $this->autoMapping->map('array', RepresentativeProfileGetResponse::class, $mandobProfile);
    }

    public function getProfileIdForAdmin($id)
    {
        $mandobProfile = $this->mandobProfileManager->getProfileIdForAdmin($id);

        $mandobProfile['image'] = $this->getImageParams($mandobProfile['image'], $this->params . $mandobProfile['image'], $this->params);

        return $this->autoMapping->map('array', RepresentativeProfileForAdminGetResponse::class, $mandobProfile);
    }

    public function updateMandobProfile(MandobProfileUpdateRequest $request)
    {
        $item = $this->mandobProfileManager->updateMandobProfile($request);
        if ($item == "user is not found") {
           return $item;
        }
        return $this->autoMapping->map(MandobProfileEntity::class, MandobProfileCreateResponse::class, $item);
    }

    public function mandobFilterByStatus($status)
    {
        $response = [];

        $items = $this->mandobProfileManager->mandobFilterByStatus($status);

        foreach ($items as $item){
            $item['image'] = $this->getImageParams($item['image'], $this->params . $item['image'], $this->params);

            $response[] = $this->autoMapping->map('array', MandobFilterByStatusResponse::class, $item);
        }

        return $response;
    }

    public function getImageParams($imageURL, $image, $baseURL): array
    {
        $item['imageURL'] = $imageURL;
        $item['image'] = $image;
        $item['baseURL'] = $baseURL;

        return $item;
    }

    public function activateMandobAccountByAdmin(ActivateMandobAccountByAdminRequest $request)
    {
        $item = $this->mandobProfileManager->activateMandobAccountByAdmin($request);
        if ($item == "user is not found") {
            return $item;
        }
        return $this->autoMapping->map(MandobProfileEntity::class, ActivateMandobAccountByAdminResponse::class, $item);
    }
}
