<?php

namespace App\Manager;

use App\AutoMapping;
use App\Manager\OrderManager;
use App\Request\CaptainProfileUpdateByAdminRequest;
use App\Request\CaptainProfileUpdateLocationRequest;
use App\Request\CaptainProfileUpdateRequest;
use App\Request\CaptainVacationCreateRequest;
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
    private $orderManager;


    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, OrderManager $orderManager,
                                CaptainProfileEntityRepository $captainProfileEntityRepository, UserManager $userManager)
    {
        $this->orderManager = $orderManager;
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

    public function updateCaptainProfile(CaptainProfileUpdateRequest $request)
    {
        $item = $this->captainProfileEntityRepository->getByCaptainIDForUpdate($request->getUserID());
        if ($item) {
            if(!$request->getCaptainName()) {
                $request->setCaptainName($item->getCaptainName());
            }

            $item = $this->autoMapping->mapToObject(CaptainProfileUpdateRequest::class, CaptainProfileEntity::class, $request, $item);
            $this->entityManager->flush();

            return $item;
        }
    }

    public function captainProfileUpdateLocation(CaptainProfileUpdateLocationRequest $request)
    {
        $item = $this->captainProfileEntityRepository->getByCaptainIDForUpdate($request->getUserID());
        if ($item) {
            $item = $this->autoMapping->mapToObject(CaptainProfileUpdateLocationRequest::class, CaptainProfileEntity::class, $request, $item);

            $this->entityManager->flush();

            return $item;
        }
    }

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

    public function updateCaptainStateByAdmin(CaptainVacationCreateRequest $request)
    {
        $item = $this->captainProfileEntityRepository->getByCaptainIDForUpdate($request->getCaptainId());

        if ($item) {
            $item = $this->autoMapping->mapToObject(CaptainVacationCreateRequest::class, CaptainProfileEntity::class, $request, $item);

            $this->entityManager->flush();

            return $item;
        }
    }

    public function getCaptainProfileByCaptainID($captainID)
    {
        return $this->captainProfileEntityRepository->getCaptainProfileByCaptainID($captainID);
    }

    public function getCaptainsInactive()
    {
        return $this->captainProfileEntityRepository->getCaptainsInactive();
    }

    public function captainIsActive($captainID)
    {
        return $this->captainProfileEntityRepository->captainIsActive($captainID);
    }

    public function getCaptainsInVacation()
    {
        return $this->captainProfileEntityRepository->getCaptainsInVacation();
    }

    public function getCaptainAsArrayByCaptainId($captainID)
    {
        return $this->captainProfileEntityRepository->getCaptainAsArrayByCaptainId($captainID);
    }

    public function sumFinancialSumInvoiceAmount()
    {
        return $this->orderManager->sumFinancialSumInvoiceAmount();
    }

    public function countOrdersDeliveredInToday($captainID, $todayStart, $todayEnd)
    {
        return $this->orderManager->countOrdersDeliveredInToday($captainID, $todayStart, $todayEnd);
    }

    public function countCaptainOrdersDelivered($captainId)
    {
        return $this->orderManager->countCaptainOrdersDelivered($captainId);
    }

    public function getInvoicesIDs($captainId)
    {
        return $this->orderManager->getInvoicesIDs($captainId);
    }

    public function sumDeliveryCostAmount()
    {
        return $this->orderManager->sumDeliveryCostAmount();
    }

    public function getAllCaptains()
    {
        return $this->captainProfileEntityRepository->getAllCaptains();
    }

    public function getTop5Captains()
    {
        return $this->captainProfileEntityRepository->getTop5Captains();
    }

    public function getTopCaptainsInLastMonthDate($fromDate, $toDate)
    {
        return $this->captainProfileEntityRepository->getTopCaptainsInLastMonthDate($fromDate, $toDate);
    }

    public function countCaptains()
    {
        return $this->captainProfileEntityRepository->countCaptains();
    }

    public function captainFilter($name)
    {
        return $this->captainProfileEntityRepository->captainFilter($name);
    }

    public function sumInvoiceAmountWithoutOrderTypeSendIt($captainId)
    {
        return $this->orderManager->sumInvoiceAmountWithoutOrderTypeSendIt($captainId);
    }

    public function countOrdersInMonthForCaptain($fromDate, $toDate, $captainId)
    {
        return $this->orderManager->countOrdersInMonthForCaptain($fromDate, $toDate, $captainId);
    }

    public function sumInvoiceAmountWithoutOrderTypeSendItInMonthForCaptain($fromDate, $toDate, $captainId)
    {
        return $this->orderManager->sumInvoiceAmountWithoutOrderTypeSendItInMonthForCaptain($fromDate, $toDate, $captainId);
    }

    public function getOrderKilometers($captainId)
    {
        return $this->orderManager->getOrderKilometers($captainId);
    }

    public function getOrderKilometersInThisMonth($captainId, $fromDate, $toDate)
    {
        return $this->orderManager->getOrderKilometersInThisMonth($captainId, $fromDate, $toDate);
    }
}