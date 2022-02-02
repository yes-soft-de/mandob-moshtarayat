<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\StaffProfileEntity;
use App\Entity\UserEntity;
use App\Request\AdminCreateRequest;
use App\Request\UserRegisterRequest;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;
use App\Manager\UserManager;
use App\Repository\StaffProfileEntityRepository;


class AdminManager
{
    private $autoMapping;
    private $entityManager;
    private $encoder;
    private $userManager;
    private $staffProfileEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, UserPasswordEncoderInterface $encoder, UserManager $userManager, StaffProfileEntityRepository $staffProfileEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->encoder = $encoder;
        $this->userManager = $userManager;
        $this->staffProfileEntityRepository = $staffProfileEntityRepository;
    }
//TODO this for remove
    public function createAdmin(AdminCreateRequest $request)
    {
        $createAdmin = $this->autoMapping->map(AdminCreateRequest::class, UserEntity::class, $request);

        $user = new UserEntity($request->getUserID());

        if ($request->getPassword()) {
               $createAdmin->setPassword($this->encoder->encodePassword($user, $request->getPassword()));
        }

        $createAdmin->setCreateDate(new \DateTime('now'));

        if ($request->getRoles() == null) {
              $request->setRoles(['ROLE_ADMIN']);
         }
        $createAdmin->setRoles($request->getRoles());

        $this->entityManager->persist($createAdmin);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $createAdmin;
    }

    public function getUserByUserID($userID)
    {
        return $this->userManager->getUserByUserID($userID);
    }

    public function adminRegister(UserRegisterRequest $request)
    {
        $user = $this->userManager->getUserByUserID($request->getUserID());
        if (!$user) {
            $request->setRoles(["ROLE_ADMIN"]);

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

        $adminProfile = $this->staffProfileEntityRepository->getCaptainProfileByCaptainID($request->getUserID());

        if (!$adminProfile) {
            $adminProfile = $this->autoMapping->map(UserRegisterRequest::class, StaffProfileEntity::class, $request);
            $adminProfile->setAdminID($userRegister->getId());

            $this->entityManager->persist($adminProfile);
            $this->entityManager->flush();
        }

        return $userRegister;
    }

    public function createProfileWithUserFound($user, UserRegisterRequest $request)
    {
        $captainProfile = $this->staffProfileEntityRepository->getCaptainProfileByCaptainID($user['id']);

        if (!$captainProfile) {
            $captainProfile = $this->autoMapping->map(UserRegisterRequest::class, StaffProfileEntity::class, $request);

            $captainProfile->setAdminID($user['id']);

            $this->entityManager->persist($captainProfile);
            $this->entityManager->flush();
        }

        return 'user is found';
    }
}
