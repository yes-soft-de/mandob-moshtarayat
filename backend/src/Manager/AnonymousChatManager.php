<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\AnonymousChatEntity;
use App\Repository\AnonymousChatEntityRepository;
use App\Request\AnonymousChatCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class AnonymousChatManager
{
    private $autoMapping;
    private $entityManager;
    private $anonymousChatEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, AnonymousChatEntityRepository $anonymousChatEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->anonymousChatEntityRepository = $anonymousChatEntityRepository;
    }

    public function createAnonymousChat(AnonymousChatCreateRequest $request)
    {
        $anonymousChat = $this->autoMapping->map(AnonymousChatCreateRequest::class, AnonymousChatEntity::class, $request);

        $this->entityManager->persist($anonymousChat);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $anonymousChat;
    }

}