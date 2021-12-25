<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\StoreOwnerBranchEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\UserEntity;
use App\Repository\StoreOwnerProfileEntityRepository;
use App\Repository\UserEntityRepository;
use App\Request\DeleteRequest;
use App\Request\UserRegisterRequest;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;
use App\Manager\OrderManager;

class StoreOwnerProfileManager
{
    private $autoMapping;
    private $entityManager;
    private $encoder;
    private $storeOwnerProfileEntityRepository;
    private $storeOwnerBranchManager;
    private $userManager;
    private $orderManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, UserPasswordEncoderInterface $encoder,
                                StoreOwnerProfileEntityRepository $storeOwnerProfileEntityRepository, StoreOwnerBranchManager $storeOwnerBranchManager, UserManager $userManager, OrderManager $orderManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->encoder = $encoder;
        $this->storeOwnerProfileEntityRepository = $storeOwnerProfileEntityRepository;
        $this->storeOwnerBranchManager = $storeOwnerBranchManager;
        $this->userManager = $userManager;
        $this->orderManager = $orderManager;
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

    public function getLast15Stores()
    {
        return $this->storeOwnerProfileEntityRepository->getLast15Stores();
    }
//TODO for remove
    public function getSumInvoicesForStore($storeOwnerProfileId)
    {
        return $this->orderManager->getSumInvoicesForStore($storeOwnerProfileId);
    }

    public function getInvoicesIDs($storeOwnerProfileId)
    {
        return $this->orderManager->getInvoicesIDsForStore($storeOwnerProfileId);
    }

    public function getSumInvoicesForStoreInSpecificDate($storeOwnerProfileId, $fromDate, $toDate)
    {
        return $this->orderManager->getSumInvoicesForStoreInSpecificDate($storeOwnerProfileId, $fromDate, $toDate);
    }

    public function getStoreOwnerProfileByCategoryID($storeCategoryID)
    {
        return $this->storeOwnerProfileEntityRepository->getStoreOwnerProfileByCategoryID($storeCategoryID);
    }

    public function getLast15StoresByCategoryID($storeCategoryID)
    {
        return $this->storeOwnerProfileEntityRepository->getLast15StoresByCategoryID($storeCategoryID);
    }

    public function getActiveStoresByName($name)
    {
        return $this->storeOwnerProfileEntityRepository->getActiveStoresByName($name);
    }

    public function getStoresByName($name)
    {
        return $this->storeOwnerProfileEntityRepository->getStoresByName($name);
    }

    public function getStoreOwnerProfileByID($id)
    {
        return $this->storeOwnerProfileEntityRepository->getStoreOwnerProfileByID($id);
    }

    public function getStoreNameById($id)
    {
        return $this->storeOwnerProfileEntityRepository->getStoreOwnerProfileByID($id);
    }

    public function getStoreProfileId($userID)
    {
        return $this->storeOwnerProfileEntityRepository->getStoreProfileId($userID);
    }
    public function countStores()
    {
        return $this->storeOwnerProfileEntityRepository->countStores();
    }

    public function storeIsActive($storeOwnerID)
    {
        return $this->storeOwnerProfileEntityRepository->storeIsActive($storeOwnerID);
    }

    public function getAllStoreOwners()
    {
        return $this->storeOwnerProfileEntityRepository->getAllStoreOwners();
    }

    public function getStoreOwnerByCategoryId($storeCategoryId)
    {
        return $this->storeOwnerProfileEntityRepository->getStoreOwnerByCategoryId($storeCategoryId);
    }

    public function getStoreOwnerByCategoryIdForAdmin($storeCategoryId)
    {
        return $this->storeOwnerProfileEntityRepository->getStoreOwnerByCategoryIdForAdmin($storeCategoryId);
    }

    public function getStoreOwnerBest()
    {
        return $this->storeOwnerProfileEntityRepository->getStoreOwnerBest();
    }

    public function getStoreOwnerInactive()
    {
        return $this->storeOwnerProfileEntityRepository->getStoreOwnerInactive();
    }

    public function getStoreOwnerInactiveFilterByName($name)
    {
        return $this->storeOwnerProfileEntityRepository->getStoreOwnerInactiveFilterByName($name);
    }

    public function deleteStoreOwnerProfile(DeleteRequest $request)
    {
        $storeOwnerProfileEntity = $this->storeOwnerProfileEntityRepository->find($request->getId());

        if(!$storeOwnerProfileEntity)
        {
            return 'storeOwnerProfileNotFound';
        }
        else
        {
            $this->entityManager->remove($storeOwnerProfileEntity);
            $this->entityManager->flush();

            return $storeOwnerProfileEntity;
        }
    }

    public function isItRelatedToProduct($id):string
    {
        $items = $this->storeOwnerProfileEntityRepository->isItRelatedToProduct($id);
        if($items) {
            return "related";
        }

        return "not related";
    }
}
