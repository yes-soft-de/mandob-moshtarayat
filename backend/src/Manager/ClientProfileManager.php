<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\ClientProfileEntity;
use App\Repository\ClientProfileEntityRepository;
use App\Request\ClientProfileNeedSupportUpdateRequest;
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

    public function updateClientProfileNeedSupport(ClientProfileNeedSupportUpdateRequest $request)
    {
        $clientProfile = $this->clientProfileEntityRepository->getClientProfileEntityByClientID($request->getClientID());

        if (!$clientProfile)
        {
            return 'noClientProfileWasFound';
        }
        else
        {
            $clientProfile = $this->autoMapping->mapToObject(ClientProfileNeedSupportUpdateRequest::class, ClientProfileEntity::class, $request, $clientProfile);

            $this->entityManager->flush();

            return $clientProfile;
        }
    }

    public function getClientProfileWhoNeedSupport()
    {
        return $this->clientProfileEntityRepository->getClientProfileWhoNeedSupport();
    }

}