<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\MandobProfileEntity;
use App\Entity\UserEntity;
use App\Manager\UserManager;
use App\Repository\MandobProfileEntityRepository;
use App\Request\MandobProfileUpdateRequest;
use App\Request\UserRegisterRequest;
use Doctrine\ORM\EntityManagerInterface;

class MandobProfileManager
{
    private $autoMapping;
    private $entityManager;
    private $mandobProfileEntityRepository;
    private $userManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager,
                                MandobProfileEntityRepository $mandobProfileEntityRepository, UserManager $userManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->mandobProfileEntityRepository = $mandobProfileEntityRepository;
        $this->userManager = $userManager;
    }

    public function mandobRegister(UserRegisterRequest $request)
    {
        $user = $this->userManager->getUserByUserID($request->getUserID());
        if ($user == null) {
            $register = $this->userManager->createUser($request);
            if($register == "register"){
               return $this->createProfile($request);
            }
            else{
                return 'not created user';
            }
        }
        else {
            return $this->createProfileWithUserFound($user, $request);
         }
    }

    public function createProfile(UserRegisterRequest $request){

        $userRegister = $this->autoMapping->map(UserRegisterRequest::class, UserEntity::class, $request);

        $mandobProfile = $this->mandobProfileEntityRepository->getMandobProfileByMandobID($request->getUserID());

        if ($mandobProfile == null) {
             $mandobProfile = $this->autoMapping->map(UserRegisterRequest::class, MandobProfileEntity::class, $request);
             $mandobProfile->setStatus('inactive');
             $mandobProfile->setMandobID($userRegister->getId());
             $mandobProfile->setMandobName($request->getUserName());

             $this->entityManager->persist($mandobProfile);
             $this->entityManager->flush();
             $this->entityManager->clear();
            }
        return $userRegister;
    }

    public function createProfileWithUserFound($user, UserRegisterRequest $request)
    {
        $mandobProfile = $this->mandobProfileEntityRepository->getMandobProfileByMandobID($user['id']);

        if ($mandobProfile == null) {
            $mandobProfile = $this->autoMapping->map(UserRegisterRequest::class, MandobProfileEntity::class, $request);

            $mandobProfile->setStatus('inactive');
            $mandobProfile->setMandobID($mandobProfile->getId());
            $mandobProfile->setMandobName($request->getUserName());

            $this->entityManager->persist($mandobProfile);
            $this->entityManager->flush();
            $this->entityManager->clear();
        }

        return 'user is found';
    }
//    public function mandobRegister(UserRegisterRequest $request)
//    {
//        $user = $this->userManager->getUserByUserID($request->getUserID());
//        if ($user == null) {
//
//            $userRegister = $this->autoMapping->map(UserRegisterRequest::class, UserEntity::class, $request);
//
//            $user = new UserEntity($request->getUserID());
//
//            if ($request->getPassword()) {
//                $userRegister->setPassword($this->encoder->encodePassword($user, $request->getPassword()));
//            }
//
//            $userRegister->setRoles(["ROLE_MANDOB"]);
//
//            $this->entityManager->persist($userRegister);
//            $this->entityManager->flush();
//            $this->entityManager->clear();
//
//            // Second, create the mandob's profile
//            $mandobProfile = $this->mandobProfileEntityRepository->getMandobProfileByMandobID($request->getUserID());
//
//            if ($mandobProfile == null) {
//                $mandobProfile = $this->autoMapping->map(UserRegisterRequest::class, MandobProfileEntity::class, $request);
//
//                $mandobProfile->setStatus('inactive');
//                $mandobProfile->setMandobID($userRegister->getId());
//                $mandobProfile->setMandobName($request->getUserName());
//
//                $this->entityManager->persist($mandobProfile);
//                $this->entityManager->flush();
//                $this->entityManager->clear();
//            }
//            return $userRegister;
//        }
//        else
//        {
//            $mandobProfile = $this->mandobProfileEntityRepository->getMandobProfileByMandobID($user['id']);
//
//            if ($mandobProfile == null)
//            {
//                $mandobProfile = $this->autoMapping->map(UserRegisterRequest::class, MandobProfileEntity::class, $request);
//
//
//                $mandobProfile->setStatus('inactive');
//                $mandobProfile->setMandobID($mandobProfile->getId());
//                $mandobProfile->setMandobName($request->getUserName());
//
//                $this->entityManager->persist($mandobProfile);
//                $this->entityManager->flush();
//                $this->entityManager->clear();
//            }
//            return "user is found";
//        }
//    }

    public function updateMandobProfile(MandobProfileUpdateRequest $request)
    {
        $item = $this->mandobProfileEntityRepository->getMandobProfile($request->getUserID());
        if ($item) {
            if($request->getMandobName() == null) {
                $request->setMandobName($item->getCaptainName());
            }

            $item = $this->autoMapping->mapToObject(MandobProfileUpdateRequest::class, MandobProfileEntity::class, $request, $item);
            $this->entityManager->flush();
            $this->entityManager->clear();

            return $item;
        }
        return "user is not found";
    }
}
