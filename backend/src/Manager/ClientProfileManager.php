<?php

namespace App\Manager;

use App\AutoMapping;
use App\Repository\ClientProfileEntityRepository;
use Doctrine\ORM\EntityManagerInterface;

class ClientProfileManager
{
    private $autoMapping;
    private $entityManager;
    private $clientProfileEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, ClientProfileEntityRepository $clientProfileEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->clientProfileEntityRepository = $clientProfileEntityRepository;
    }

    public function getClientByUserID($userID)
    {
        return $this->clientProfileEntityRepository->getClientByUserID($userID);
    }
}