<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\MandobProfileEntity;
use App\Entity\UserEntity;
use App\Request\ActivateMandobAccountByAdminRequest;
use App\Request\MandobFilterByStatusRequest;
use App\Request\MandobProfileUpdateRequest;
use App\Request\UserRegisterRequest;
use App\Response\ActivateMandobAccountByAdminResponse;
use App\Response\MandobFilterByStatusResponse;
use App\Response\MandobProfileCreateResponse;
use App\Response\UserRegisterResponse ;
use App\Service\RoomIdHelperService;
use App\Manager\UserManager;
use App\Manager\MandobProfileManager;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

use DateTime;


class MandobProfileService
{
    private $autoMapping;
    private $userManager;
    private $params;
    private $roomIdHelperService;
    private $mandobRegister;
    private $mandobProfileManager;

    public function __construct(AutoMapping  $autoMapping, ParameterBagInterface $params, RoomIdHelperService $roomIdHelperService, UserManager $userManager
        , MandobProfileManager $mandobProfileManager
)
    {
        $this->autoMapping = $autoMapping;
        $this->roomIdHelperService = $roomIdHelperService;
        $this->userManager = $userManager;
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
        return $this->autoMapping->map(UserEntity::class, UserRegisterResponse::class, $userRegister);
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
