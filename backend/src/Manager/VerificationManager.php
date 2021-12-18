<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\VerificationEntity;
use App\Repository\VerificationEntityRepository;
use App\Request\VerificationCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class VerificationManager
{
    private $autoMapping;
    private $entityManager;
    private $verificationEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, VerificationEntityRepository $verificationEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->verificationEntityRepository = $verificationEntityRepository;
    }

    public function createVerification(VerificationCreateRequest $request)
    {
        $request->setCode($this->generateVerificationCode());

        $verificationEntity = $this->autoMapping->map(VerificationCreateRequest::class, VerificationEntity::class, $request);

        $this->entityManager->persist($verificationEntity);
        $this->entityManager->flush();

        return $verificationEntity;
    }

    public function getVerificationCodeByCode($verificationCode)
    {
        return $this->verificationEntityRepository->getVerificationCodeByCode($verificationCode);
    }

    public function generateVerificationCode()
    {
        do
        {
            // keep generating verification code while it is exist
            $found = false;
            $verificationCode = "";
            $result = "";

            for ($i = 0; $i < 7; $i++)
            {
                $verificationCode .= random_int(0, 9);
            }

            // Check if it is exist
            $result = $this->verificationEntityRepository->getVerificationCodeByCode($verificationCode);

            if($result)
            {
                $found = true;
            }

        }
        while($found);

        return $verificationCode;
    }

}