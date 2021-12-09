<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\MandobProfileEntity;
use App\Manager\UserManager;
use App\Repository\MandobProfileEntityRepository;
use App\Request\ActivateMandobAccountByAdminRequest;
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
        if (!$user) {
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

        if (!$mandobProfile) {
             $mandobProfile = $this->autoMapping->map(UserRegisterRequest::class, MandobProfileEntity::class, $request);
             $mandobProfile->setStatus('inactive');
             $mandobProfile->setMandobID($userRegister->getId());
             $mandobProfile->setMandobName($request->getUserName());

             $this->entityManager->persist($mandobProfile);
             $this->entityManager->flush();
            }
        return $userRegister;
    }

    public function createProfileWithUserFound($user, UserRegisterRequest $request)
    {
        $mandobProfile = $this->mandobProfileEntityRepository->getMandobProfileByMandobID($user['id']);

        if (!$mandobProfile) {
            $mandobProfile = $this->autoMapping->map(UserRegisterRequest::class, MandobProfileEntity::class, $request);

            $mandobProfile->setStatus('inactive');
            $mandobProfile->setMandobID($user['id']);
            $mandobProfile->setMandobName($request->getUserName());

            $this->entityManager->persist($mandobProfile);
            $this->entityManager->flush();
        }

        return 'user is found';
    }

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
