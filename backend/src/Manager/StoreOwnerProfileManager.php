<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\StoreOwnerBranchEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\UserEntity;
use App\Repository\StoreOwnerProfileEntityRepository;
use App\Repository\UserEntityRepository;
use App\Request\UserRegisterRequest;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;

class StoreOwnerProfileManager
{
    private $autoMapping;
    private $entityManager;
    private $encoder;
    private $storeOwnerProfileEntityRepository;
    private $storeOwnerBranchManager;
    private $userManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, UserPasswordEncoderInterface $encoder,
                                StoreOwnerProfileEntityRepository $storeOwnerProfileEntityRepository, StoreOwnerBranchManager $storeOwnerBranchManager, UserManager $userManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->encoder = $encoder;
        $this->storeOwnerProfileEntityRepository = $storeOwnerProfileEntityRepository;
        $this->storeOwnerBranchManager = $storeOwnerBranchManager;
        $this->userManager = $userManager;
    }

    public function storeOwnerRegister(UserRegisterRequest $request)
    {
        $userResult = $this->userManager->getUserByUserID($request->getUserID());

        if($userResult == null)
        {
            $userRegister = $this->autoMapping->map(UserRegisterRequest::class, UserEntity::class, $request);

            $user = new UserEntity($request->getUserID());

            if($request->getPassword())
            {
                $userRegister->setPassword($this->encoder->encodePassword($user, $request->getPassword()));
            }

            $userRegister->setRoles(['ROLE_OWNER']);

            $this->entityManager->persist($userRegister);
            $this->entityManager->flush();

            // Second, create the owner's profile
            $storeOwnerProfile = $this->storeOwnerProfileByStoreID($request->getUserID());

            if($storeOwnerProfile == null)
            {
                $storeOwnerProfile = $this->autoMapping->map(UserRegisterRequest::class, StoreOwnerProfileEntity::class, $request);

                $storeOwnerProfile->setStoreOwnerID($userRegister->getId());
                $storeOwnerProfile->setStoreOwnerName($request->getUserName());
                $storeOwnerProfile->setRoomID($request->getRoomID());
                $storeOwnerProfile->setStatus('inactive');
                $storeOwnerProfile->setFree(false);
                $storeOwnerProfile->setIs_best(false);

                $this->entityManager->persist($storeOwnerProfile);
                $this->entityManager->flush();

                //create branch
                $branch = $this->storeOwnerBranchManager->getBranchesByStoreOwnerProfileID($storeOwnerProfile->getId());

                if(count($branch) == 0)
                {
                    $branch = $this->autoMapping->map(UserRegisterRequest::class, StoreOwnerBranchEntity::class, $request);

                    $branch->setIsActive(1);
                    $branch->setStoreOwnerProfileID($storeOwnerProfile->getId());

                    if($request->getLocation())
                    {
                        $branch->setLocation($request->getLocation());
                    }

                    $branch->setBranchName("default");

                    $this->entityManager->persist($branch);
                    $this->entityManager->flush();
                }
            }

            return $userRegister;

//            return $found = 1;
        }
        else
        {
            $storeOwnerProfile = $this->storeOwnerProfileByStoreID($userResult['id']);

            if($storeOwnerProfile == null)
            {
                $storeOwnerProfile = $this->autoMapping->map(UserRegisterRequest::class, StoreOwnerProfileEntity::class, $request);

                $storeOwnerProfile->setStoreOwnerID($userResult['id']);
                $storeOwnerProfile->setStoreOwnerName($request->getUserName());
                $storeOwnerProfile->setRoomID($request->getRoomID());
                $storeOwnerProfile->setStatus('inactive');
                $storeOwnerProfile->setFree(false);
                $storeOwnerProfile->setIs_best(false);

                $this->entityManager->persist($storeOwnerProfile);
                $this->entityManager->flush();

                //create branch
                $branch = $this->storeOwnerBranchManager->getBranchesByStoreOwnerProfileID($storeOwnerProfile->getId());

                if(count($branch) == 0)
                {
                    $branch = $this->autoMapping->map(UserRegisterRequest::class, StoreOwnerBranchEntity::class, $request);

                    $branch->setIsActive(1);
                    $branch->setStoreOwnerProfileID($storeOwnerProfile->getId());

                    if($request->getLocation())
                    {
                        $branch->setLocation($request->getLocation());
                    }

                    $branch->setBranchName("default");

                    $this->entityManager->persist($branch);
                    $this->entityManager->flush();
                }
            }

            return $userResult;

//            return $found = 2;
        }
    }

    public function storeOwnerProfileByStoreID($storeID)
    {
        return $this->storeOwnerProfileEntityRepository->storeOwnerProfileByStoreID($storeID);
    }

    public function storeOwnerProfileByRoomID($roomID)
    {
        return $this->storeOwnerProfileEntityRepository->storeOwnerProfileByRoomID($roomID);
    }

}