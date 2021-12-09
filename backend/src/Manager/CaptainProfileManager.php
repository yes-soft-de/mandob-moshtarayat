<?php

namespace App\Manager;

use App\AutoMapping;
use App\Request\UserRegisterRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Manager\UserManager;
use App\Repository\CaptainProfileEntityRepository;
use App\Entity\CaptainProfileEntity;

class CaptainProfileManager
{
    private $autoMapping;
    private $entityManager;
    private $captainProfileEntityRepository;
    private $userManager;


    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager,
                                CaptainProfileEntityRepository $captainProfileEntityRepository, UserManager $userManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->captainProfileEntityRepository = $captainProfileEntityRepository;
        $this->userManager = $userManager;
    }

    public function captainRegister(UserRegisterRequest $request)
    {
        $user = $this->userManager->getUserByUserID($request->getUserID());
        if (!$user) {
            $request->setRoles(["ROLE_CAPTAIN"]);

            $userRegister = $this->userManager->createUser($request);
            if($userRegister){
                return $this->createProfile($request, $userRegister);
            }
            else{
                return 'not created user';
            }
        }
        else {
            return $this->createProfileWithUserFound($user, $request);
        }
    }

    public function createProfile(UserRegisterRequest $request, $userRegister){

        $captainProfile = $this->captainProfileEntityRepository->getCaptainProfileByCaptainID($request->getUserID());

        if (!$captainProfile) {
            $captainProfile = $this->autoMapping->map(UserRegisterRequest::class, CaptainProfileEntity::class, $request);
            $captainProfile->setStatus('inactive');
            $captainProfile->setCaptainID($userRegister->getId());
            $captainProfile->setCaptainName($request->getUserName());

            $this->entityManager->persist($captainProfile);
            $this->entityManager->flush();
        }
        return $userRegister;
    }

    public function createProfileWithUserFound($user, UserRegisterRequest $request)
    {
        $captainProfile = $this->captainProfileEntityRepository->getCaptainProfileByCaptainID($user['id']);

        if (!$captainProfile) {
            $captainProfile = $this->autoMapping->map(UserRegisterRequest::class, CaptainProfileEntity::class, $request);

            $captainProfile->setStatus('inactive');
            $captainProfile->setCaptainID($user['id']);
            $captainProfile->setCaptainName($request->getUserName());

            $this->entityManager->persist($captainProfile);
            $this->entityManager->flush();
        }

        return 'user is found';
    }
}