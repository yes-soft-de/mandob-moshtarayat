<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\AnonymousChatEntity;
use App\Manager\AnonymousChatManager;
use App\Request\AnonymousChatCreateRequest;
use App\Response\AnonymousChatCreateResponse;

class AnonymousChatService
{
    private $autoMapping;
    private $anonymousChatManager;

    public function __construct(AutoMapping $autoMapping, AnonymousChatManager $anonymousChatManager)
    {
        $this->autoMapping = $autoMapping;
        $this->anonymousChatManager = $anonymousChatManager;
    }

    public function createAnonymousChat(AnonymousChatCreateRequest $request)
    {
        $item = $this->anonymousChatManager->createAnonymousChat($request);

        return $this->autoMapping->map(AnonymousChatEntity::class, AnonymousChatCreateResponse::class, $item);
    }

    public function getAnonymousUsersWhoNeedSupport()
    {
        return $this->anonymousChatManager->getAnonymousUsersWhoNeedSupport();
    }

}