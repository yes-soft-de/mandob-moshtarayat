<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\MandobProfileEntity;
use App\Entity\UserEntity;
use App\Manager\UserManager;
use App\Repository\MandobProfileEntityRepository;
use App\Request\ActivateMandobAccountByAdminRequest;
use App\Request\MandobProfileUpdateRequest;
use App\Request\UserRegisterRequest;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;


class MandobProfileManager
{
    private $autoMapping;
    private $entityManager;
    private $mandobProfileEntityRepository;
    private $userManager;
    private $encoder;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager,UserPasswordEncoderInterface $encoder,
                                MandobProfileEntityRepository $mandobProfileEntityRepository, UserManager $userManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->mandobProfileEntityRepository = $mandobProfileEntityRepository;
        $this->userManager = $userManager;
        $this->encoder = $encoder;

    }

    public function mandobRegister(UserRegisterRequest $request)
    {
        $user = $this->userManager->getUserByUserID($request->getUserID());
        if ($user == null) {
            $request->setRoles(["ROLE_MANDOB"]);
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
            $mandobProfile->setMandobID($user['id']);
            $mandobProfile->setMandobName($request->getUserName());

            $this->entityManager->persist($mandobProfile);
            $this->entityManager->flush();
            $this->entityManager->clear();
        }

        return 'user is found';
    }
//this code is for backup (mandob Register).
//
//    public function mandobRegister1(UserRegisterRequest $request)
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
                $request->setMandobName($item->getMandobName());
            }

            $item = $this->autoMapping->mapToObject(MandobProfileUpdateRequest::class, MandobProfileEntity::class, $request, $item);
            $this->entityManager->flush();
            $this->entityManager->clear();

            return $item;
        }
        return "user is not found";
    }

    public function mandobFilterByStatus($status)
    {
        return $this->mandobProfileEntityRepository->mandobFilterByStatus($status);
    }

    public function activateMandobAccountByAdmin(ActivateMandobAccountByAdminRequest $request)
    {
        $item = $this->mandobProfileEntityRepository->find($request->getId());
        if ($item) {

            $item = $this->autoMapping->mapToObject(ActivateMandobAccountByAdminRequest::class, MandobProfileEntity::class, $request, $item);
            $this->entityManager->flush();
            $this->entityManager->clear();

            return $item;
        }

        return "user is not found";
    }
}
