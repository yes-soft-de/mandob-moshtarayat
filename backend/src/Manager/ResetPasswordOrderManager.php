<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\ResetPasswordOrderEntity;
use App\Repository\ResetPasswordOrderEntityRepository;
use App\Request\ResetPasswordOrderCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class ResetPasswordOrderManager
{
    private $autoMapping;
    private $entityManager;
    private $resetPasswordOrderEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, ResetPasswordOrderEntityRepository $resetPasswordOrderEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->resetPasswordOrderEntityRepository = $resetPasswordOrderEntityRepository;
    }

    public function createResetPasswordOrder(ResetPasswordOrderCreateRequest $request)
    {
        $request->setCode($this->generateCode());

        $resetPasswordOrderEntity = $this->autoMapping->map(ResetPasswordOrderCreateRequest::class, ResetPasswordOrderEntity::class, $request);

        $this->entityManager->persist($resetPasswordOrderEntity);
        $this->entityManager->flush();

        return $resetPasswordOrderEntity;
    }

    public function getResetPasswordOrderByCode($code)
    {
        return $this->resetPasswordOrderEntityRepository->getResetPasswordOrderByCode($code);
    }

    public function generateCode()
    {
        do
        {
            // keep generating code while it is exist
            $found = false;
            $code = "";
            $result = "";

            for ($i = 0; $i < 6; $i++)
            {
                $code .= random_int(0, 9);
            }

            // Check if it is exist
            $result = $this->getResetPasswordOrderByCode($code);

            if($result)
            {
                $found = true;
            }

        }
        while($found);

        return $code;
    }

}