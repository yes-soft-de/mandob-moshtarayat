<?php

namespace App\Manager;

use App\AutoMapping;
use App\Constant\StoreOwnerVerificationStatusConstant;
use App\Request\ClientUpdateFavouriteCategoriesRequest;
use App\Request\storeOwnerProfileStatusUpdateByAdminRequest;
use App\Entity\UserEntity;
use App\Entity\ClientProfileEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\CaptainProfileEntity;
use App\Entity\StoreOwnerBranchEntity;
use App\Repository\UserEntityRepository;
use App\Repository\StoreOwnerProfileEntityRepository;
use App\Repository\CaptainProfileEntityRepository;
use App\Repository\ClientProfileEntityRepository;
use App\Request\StoreOwnerProfileCreateRequest;
use App\Request\StoreOwnerProfileCreateByAdminRequest;
use App\Request\StoreOwnerUpdateByAdminRequest;
use App\Request\CaptainProfileCreateRequest;
use App\Request\CaptainProfileUpdateLocationRequest;
use App\Request\CaptainVacationCreateRequest;
use App\Request\StoreOwnerProfileUpdateRequest;
use App\Request\CaptainProfileUpdateByAdminRequest;
use App\Request\CaptainProfileUpdateRequest;
use App\Request\ClientProfileUpdateRequest;
use App\Request\StoreOwnerVerificationStatusUpdateRequest;
use App\Request\UserRegisterRequest;
use App\Manager\StoreOwnerBranchManager;
use App\Manager\OrderManager;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;


class UserManager
{
    private $autoMapping;
    private $entityManager;
    private $encoder;
    private $userRepository;
    private $captainProfileEntityRepository;
    private $storeOwnerProfileEntityRepository;
    private $clientProfileEntityRepository;
    private $storeOwnerBranchManager;
    private $orderManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, UserPasswordEncoderInterface $encoder, UserEntityRepository $userRepository, CaptainProfileEntityRepository $captainProfileEntityRepository, StoreOwnerProfileEntityRepository $storeOwnerProfileEntityRepository, ClientProfileEntityRepository $clientProfileEntityRepository,StoreOwnerBranchManager $storeOwnerBranchManager,OrderManager $orderManager
    )
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->encoder = $encoder;
        $this->userRepository = $userRepository;
        $this->captainProfileEntityRepository = $captainProfileEntityRepository;
        $this->storeOwnerProfileEntityRepository = $storeOwnerProfileEntityRepository;
        $this->clientProfileEntityRepository = $clientProfileEntityRepository;
        $this->storeOwnerBranchManager = $storeOwnerBranchManager;
        $this->orderManager = $orderManager;
    }

    public function clientRegister(UserRegisterRequest $request, $roomID)
    {
        $user = $this->getUserByUserID($request->getUserID());

        if ($user == null) {

            $userRegister = $this->autoMapping->map(UserRegisterRequest::class, UserEntity::class, $request);

            $user = new UserEntity($request->getUserID());

            if ($request->getPassword()) {
                $userRegister->setPassword($this->encoder->encodePassword($user, $request->getPassword()));
            }

            $userRegister->setRoles(["ROLE_CLIENT"]);

            $this->entityManager->persist($userRegister);
            $this->entityManager->flush();
            $this->entityManager->clear();

            // Second, create the client's profile
            $clientProfile = $this->getClientProfileByClientID($request->getUserID());
            
            if ($clientProfile == null) {
                $clientProfile = $this->autoMapping->map(UserRegisterRequest::class, ClientProfileEntity::class, $request);

                $clientProfile->setClientID($userRegister->getId());
                $clientProfile->setClientName($request->getUserName());
                $clientProfile->setRoomID($roomID);
                $this->entityManager->persist($clientProfile);
                $this->entityManager->flush();
                $this->entityManager->clear();
            }
            return $userRegister;
        }
        else
        {
            $clientProfile = $this->getClientProfileByClientID($user['id']);

            if ($clientProfile == null)
            {
                $clientProfile = $this->autoMapping->map(UserRegisterRequest::class, ClientProfileEntity::class, $request);
                $clientProfile->setClientID($user['id']);
                $clientProfile->setClientName($request->getUserName());
                $clientProfile->setRoomID($roomID);
                $this->entityManager->persist($clientProfile);
                $this->entityManager->flush();
                $this->entityManager->clear();
            }

            return true;
        }
    }

    public function getUserByUserID($userID)
    {
        return $this->userRepository->getUserByUserID($userID);
    }

    public function storeOwnerProfileUpdate(StoreOwnerProfileUpdateRequest $request)
    {
        $item = $this->storeOwnerProfileEntityRepository->getUserProfile($request->getUserID());

        if ($item) {
            if($request->getStoreOwnerName() == null) {
                $request->setStoreOwnerName($item->getStoreOwnerName());
            }

            $item = $this->autoMapping->mapToObject(StoreOwnerProfileUpdateRequest::class, StoreOwnerProfileEntity::class, $request, $item);
            $item->setOpeningTime( $item->getOpeningTime());
            $item->setClosingTime( $item->getClosingTime());

            $this->entityManager->flush();
            $this->entityManager->clear();

            //update branch
            $branch = $this->storeOwnerBranchManager->update($item->getId(), $request->getLocation(), $request->getBranchName());

            return $item;
        }
    }

    public function updateStoreOwnerByAdmin(StoreOwnerUpdateByAdminRequest $request)
    {
        $item = $this->storeOwnerProfileEntityRepository->find($request->getId());

        if ($item) {
            $item = $this->autoMapping->mapToObject(StoreOwnerUpdateByAdminRequest::class, StoreOwnerProfileEntity::class, $request, $item);
            $item->setOpeningTime( $request->getOpeningTime());
            $item->setClosingTime( $request->getClosingTime());

            $this->entityManager->flush();
            $this->entityManager->clear();

            return $item;
        }
    }

    public function storeOwnerProfileStatusUpdateByAdmin(storeOwnerProfileStatusUpdateByAdminRequest $request)
    {
        $item = $this->storeOwnerProfileEntityRepository->find($request->getId());

        if ($item) {
            $item = $this->autoMapping->mapToObject(storeOwnerProfileStatusUpdateByAdminRequest::class, StoreOwnerProfileEntity::class, $request, $item);

            $this->entityManager->flush();
            $this->entityManager->clear();

            return $item;
        }
    }

    public function getremainingOrders($userID)
    {
        return $this->storeOwnerProfileEntityRepository->getremainingOrders($userID);
    }
//TODO
// for remove
    public function captainFilter($name)
    {
        return $this->captainProfileEntityRepository->captainFilter($name);
    }

    public function clientsByName($name)
    {
        return $this->clientProfileEntityRepository->clientsByName($name);
    }
//TODO
// for remove
    public function updateCaptainProfile(CaptainProfileUpdateRequest $request)
    {
        $item = $this->captainProfileEntityRepository->getByCaptainIDForUpdate($request->getUserID());
        if ($item) {
            if($request->getCaptainName() == null) {
                $request->setCaptainName($item->getCaptainName());
            }

            $item = $this->autoMapping->mapToObject(CaptainProfileUpdateRequest::class, CaptainProfileEntity::class, $request, $item);
            $this->entityManager->flush();
            $this->entityManager->clear();

            return $item;
        }
    }
//TODO
// for remove
    public function captainProfileUpdateLocation(CaptainProfileUpdateLocationRequest $request)
    {
        $item = $this->captainProfileEntityRepository->getByCaptainIDForUpdate($request->getUserID());
        if ($item) {
            $item = $this->autoMapping->mapToObject(CaptainProfileUpdateLocationRequest::class, CaptainProfileEntity::class, $request, $item);

            $this->entityManager->flush();
            $this->entityManager->clear();

            return $item;
        }
    }
//TODO
// for remove
    public function updateCaptainProfileByAdmin(CaptainProfileUpdateByAdminRequest $request)
    {
        $item = $this->captainProfileEntityRepository->getByCaptainIDForUpdate($request->getCaptainID());
        if ($item) {
            $item = $this->autoMapping->mapToObject(CaptainProfileUpdateByAdminRequest::class, CaptainProfileEntity::class, $request, $item);

            $this->entityManager->flush();
            $this->entityManager->clear();

            return $item;
        }
    }
//TODO
// for remove
    public function updateCaptainStateByAdmin(CaptainVacationCreateRequest $request)
    {  
        $item = $this->captainProfileEntityRepository->getByCaptainIDForUpdate($request->getCaptainId());
        
        if ($item) {
            $item = $this->autoMapping->mapToObject(CaptainVacationCreateRequest::class, CaptainProfileEntity::class, $request, $item);

            $this->entityManager->flush();
            $this->entityManager->clear();

            return $item;
        }
    }
//TODO
// for remove
    public function getCaptainProfileByCaptainID($captainID)
    {
        return $this->captainProfileEntityRepository->getCaptainProfileByCaptainID($captainID);
    }
//TODO
// for remove
    public function getCaptainProfileByID($captainProfileId)
    {
        return $this->captainProfileEntityRepository->getCaptainProfileByID($captainProfileId);
    }
//TODO
// for remove
    public function getCaptainsInactive()
    {
        return $this->captainProfileEntityRepository->getCaptainsInactive();
    }
//TODO
// for remove
    public function captainIsActive($captainID)
    {
        return $this->captainProfileEntityRepository->captainIsActive($captainID);
    }

    public function getCaptainsState($state)
    {
        return $this->captainProfileEntityRepository->getCaptainsState($state);
    }

    public function countpendingCaptains()
    {
        return $this->captainProfileEntityRepository->countpendingCaptains();
    }
   
    public function countOngoingCaptains()
    {
        return $this->captainProfileEntityRepository->countOngoingCaptains();
    }
   
    public function countDayOfCaptains()
    {
        return $this->captainProfileEntityRepository->countDayOfCaptains();
    }
    //TODO
   // for remove
    public function getCaptainsInVacation()
    {
        return $this->captainProfileEntityRepository->getCaptainsInVacation();
    }

    public function getCaptainAsArray($id)
    {
        return $this->captainProfileEntityRepository->getCaptainAsArray($id);
    }
    //TODO
    // for remove
    public function getCaptainAsArrayByCaptainId($captainID)
    {
        return $this->captainProfileEntityRepository->getCaptainAsArrayByCaptainId($captainID);
    }
//TODO
    // for remove
    public function getAllCaptains()
    {
        return $this->captainProfileEntityRepository->getAllCaptains();
    }
    //TODO
    // for remove
    public function countCaptains()
    {
        return $this->captainProfileEntityRepository->countCaptains();
    }

    public function getcaptainByRoomID($roomID)
    {
        return $this->captainProfileEntityRepository->getcaptainByRoomID($roomID);
    }

    public function updateCaptainNewMessageStatus($request, $NewMessageStatus)
    {
        if ($request) {
            $entity = $this->captainProfileEntityRepository->find($request->getId());
            if (!$entity) {
                return null;
            }

            $entity->setNewMessageStatus($NewMessageStatus);
            $entity = $this->autoMapping->mapToObject(CaptainProfileEntity::class, CaptainProfileEntity::class, $entity, $entity);
          
            $this->entityManager->flush();

            return $entity;
        }

        return null;
    }
    //TODO
    // for remove
    public function getTop5Captains()
    {        
        return $this->captainProfileEntityRepository->getTop5Captains();
    }
    //TODO
    // for remove
    public function getTopCaptainsInLastMonthDate($fromDate, $toDate)
    {
        return $this->captainProfileEntityRepository->getTopCaptainsInLastMonthDate($fromDate, $toDate);
    }

    public function getClientProfileByClientID($clientID)
    {
        return $this->clientProfileEntityRepository->getClientProfileByClientID($clientID);
    }

    public function updateClientProfile(ClientProfileUpdateRequest $request)
    {
        $item = $this->clientProfileEntityRepository->findOneBy(['clientID'=>$request->getClientID()]);
       
        if ($item) {
            $item = $this->autoMapping->mapToObject(ClientProfileUpdateRequest::class, ClientProfileEntity::class, $request, $item);

            $this->entityManager->flush();
            $this->entityManager->clear();

            return $item;
        }
    }

    public function getClientProfileByID($id)
    {
        return $this->clientProfileEntityRepository->getClientProfileByID($id);
    }

    public function getClientsProfile()
    {
        return $this->clientProfileEntityRepository->getClientsProfile();
    }
    
    public function countClients()
    {
        return $this->clientProfileEntityRepository->countClients();
    }
    
    public function getStoreOwnerByCategoryId($storeCategoryId)
    {
        return $this->storeOwnerProfileEntityRepository->getStoreOwnerByCategoryId($storeCategoryId);
    }

    public function getStoreOwnerByCategoryIdForAdmin($storeCategoryId)
    {
        return $this->storeOwnerProfileEntityRepository->getStoreOwnerByCategoryIdForAdmin($storeCategoryId);
    }

    public function createStoreOwnerProfileByAdmin(StoreOwnerProfileCreateByAdminRequest $request)
    {
            $userProfile = $this->autoMapping->map(StoreOwnerProfileCreateByAdminRequest::class, StoreOwnerProfileEntity::class, $request);

            $userProfile->setStatus('active');
            $userProfile->setFree(false);
            $userProfile->setIs_best(false);
            $userProfile->setOpeningTime( $userProfile->getOpeningTime());
            $userProfile->setClosingTime( $userProfile->getClosingTime());

            $this->entityManager->persist($userProfile);
            $this->entityManager->flush();
            $this->entityManager->clear();

            //create branch
           $branch = $this->storeOwnerBranchManager->getBranchesByStoreOwnerProfileID($userProfile->getId());
           if(!$branch){
                $branch = $this->autoMapping->map(StoreOwnerProfileCreateByAdminRequest::class, StoreOwnerBranchEntity::class, $request);
                $branch->setIsActive(1);
                $branch->setStoreOwnerProfileID($userProfile->getId());
                $branch->setLocation($request->getLocation());
                if($request->getBranchName() == null) {
                    $branch->setBranchName("default");
                }
                else {
                    $branch->setBranchName($request->getBranchName());
                }
                
                $this->entityManager->persist($branch);
                $this->entityManager->flush();
                $this->entityManager->clear();
           }

        return $userProfile;
    }
    
    public function checkUserType($userType,$userID): string
    {
        $user = $this->userRepository->find($userID);

        if ($user->getRoles()[0] != $userType){
            return "no";
        }

        return "yes";
    }

    public function getStoreProfileId($userID)
    {
        return $this->userRepository->getStoreProfileId($userID);
    }

    public function getOrdersForSpecificClient($clientID)
    {
        return $this->orderManager->getOrdersForSpecificClient($clientID);
    }

    public function clientOrdersCount($clientID)
    {
        return $this->orderManager->clientOrdersCount($clientID);
    }

    public function clientOrdersCancel($clientID)
    {
        return $this->orderManager->clientOrdersCancel($clientID);
    }

    public function clientOrdersDelivered($clientID)
    {
        return $this->orderManager->clientOrdersDelivered($clientID);
    }

    public function createUser(UserRegisterRequest $request)
    {
        $userRegister = $this->autoMapping->map(UserRegisterRequest::class, UserEntity::class, $request);

        $user = new UserEntity($request->getUserID());

        if ($request->getPassword()) {
            $userRegister->setPassword($this->encoder->encodePassword($user, $request->getPassword()));
        }

//        $userRegister->setRoles(["ROLE_MANDOB"]);
        $this->entityManager->persist($userRegister);
        $this->entityManager->flush();

        return $userRegister;
    }

    public function updateClientFavouriteCategories(ClientUpdateFavouriteCategoriesRequest $request)
    {
        $item = $this->clientProfileEntityRepository->findOneBy(['clientID'=>$request->getClientID()]);

        if ($item) {
            $item = $this->autoMapping->mapToObject(ClientUpdateFavouriteCategoriesRequest::class, ClientProfileEntity::class, $request, $item);

            $this->entityManager->flush();
            $this->entityManager->clear();

            return $item;
        }
    }

    public function getFavouriteCategoriesIDsByClientID($clientID)
    {
        return $this->clientProfileEntityRepository->getFavouriteCategoriesIDsByClientID($clientID);
    }

    public function updateStoreOwnerVerificationStatus(StoreOwnerVerificationStatusUpdateRequest $request)
    {
        $item = $this->userRepository->getStoreOwnerEntityByUserID($request->getUserID());

        if (!$item)
        {
            // no store owner with the provided userID was found!
            return 'noUserWasFound';
        }
        else
        {
            $item = $this->autoMapping->mapToObject(StoreOwnerVerificationStatusUpdateRequest::class, UserEntity::class, $request, $item);

            $this->entityManager->flush();
            $this->entityManager->clear();

            return $item;
        }
    }

    public function getStoreOwnerVerificationStatusByUserID($userID)
    {
        return $this->userRepository->getStoreOwnerVerificationStatusByUserID($userID);
    }

    public function updateAllStoreOwnersVerificationStatusByDeveloper()
    {
        $users = $this->userRepository->getAllStoreOwners();

        if (!$users)
        {
            return 'noUsers';
        }
        else
        {
            foreach ($users as $user)
            {
                $user->setVerificationStatus(StoreOwnerVerificationStatusConstant::$VERIFIED_STATUS);

                $this->entityManager->flush();
            }

            return $users;
        }
    }

    public function getAllStoreOwners()
    {
        return $this->userRepository->getAllStoreOwners();
    }

    public function deleteUserById($id)
    {
        $result = $this->userRepository->find($id);

        if(!$result)
        {

        }
        else
        {
            $this->entityManager->remove($result);
            $this->entityManager->flush();

            return $result;
        }
    }
}
