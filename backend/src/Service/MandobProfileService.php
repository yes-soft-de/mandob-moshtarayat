<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\MandobProfileEntity;
use App\Entity\UserEntity;
use App\Request\ActivateMandobAccountByAdminRequest;
use App\Request\MandobProfileUpdateRequest;
use App\Request\UserRegisterRequest;
use App\Request\VerificationCreateRequest;
use App\Response\ActivateMandobAccountByAdminResponse;
use App\Response\MandobFilterByStatusResponse;
use App\Response\MandobProfileCreateResponse;
use App\Response\RepresentativeProfileForAdminGetResponse;
use App\Response\RepresentativeProfileGetResponse;
use App\Response\RepresentativeRemainingForItAmountResponse;
use App\Response\UserRegisterResponse ;
use App\Manager\MandobProfileManager;
use App\Response\RepresentativeFinancialAccountForAdminGetResponse;
use App\Response\RepresentativeFinancialAccountGetResponse;
use App\Response\StatisticsForRepresentativeGetResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class MandobProfileService
{
    private $autoMapping;
    private $params;
    private $roomIdHelperService;
    private $verificationService;
    private $deliveryCompanyPaymentToRepresentativeService;
    private $representativeStoreLinkService;
    private $representativeDueService;
    private $dateFactoryService;
    private $mandobProfileManager;

    public function __construct(AutoMapping $autoMapping, ParameterBagInterface $params, RoomIdHelperService $roomIdHelperService, MandobProfileManager $mandobProfileManager,
                                VerificationService $verificationService, DeliveryCompanyPaymentToRepresentativeService $deliveryCompanyPaymentToRepresentativeService, RepresentativeStoreLinkService $representativeStoreLinkService,
     RepresentativeDueService $representativeDueService, DateFactoryService $dateFactoryService)
    {
        $this->autoMapping = $autoMapping;
        $this->roomIdHelperService = $roomIdHelperService;
        $this->verificationService = $verificationService;
        $this->deliveryCompanyPaymentToRepresentativeService = $deliveryCompanyPaymentToRepresentativeService;
        $this->representativeStoreLinkService = $representativeStoreLinkService;
        $this->representativeDueService = $representativeDueService;
        $this->dateFactoryService = $dateFactoryService;
        $this->mandobProfileManager = $mandobProfileManager;

        $this->params = $params->get('upload_base_url') . '/';
    }

    public function mandobRegister(UserRegisterRequest $request)
    {
        $request->setRoomID($this->roomIdHelperService->roomIdGenerate());
        $userRegister = $this->mandobProfileManager->mandobRegister($request);
        if ($userRegister == "user is found") {
            $user['found']="yes";

            return $this->autoMapping->map("array", UserRegisterResponse::class, $user);
        }

        $this->createVerificationCodeForMandob($request);

        return $this->autoMapping->map(UserEntity::class, UserRegisterResponse::class, $userRegister);
    }

    public function createVerificationCodeForMandob(UserRegisterRequest $userEntity)
    {
        $createVerificationRequest = $this->autoMapping->map(UserRegisterRequest::class, VerificationCreateRequest::class, $userEntity);

        $this->verificationService->createVerificationCode($createVerificationRequest);
    }

    public function getProfileByMandobID($mandobID)
    {
        $mandobProfile = $this->mandobProfileManager->getProfileByMandobID($mandobID);

        $mandobProfile['image'] = $this->getImageParams($mandobProfile['image'], $this->params . $mandobProfile['image'], $this->params);

        return $this->autoMapping->map('array', RepresentativeProfileGetResponse::class, $mandobProfile);
    }

    public function getProfileIdForAdmin($id)
    {
        $mandobProfile = $this->mandobProfileManager->getProfileIdForAdmin($id);

        $mandobProfile['image'] = $this->getImageParams($mandobProfile['image'], $this->params . $mandobProfile['image'], $this->params);

        return $this->autoMapping->map('array', RepresentativeProfileForAdminGetResponse::class, $mandobProfile);
    }

    public function updateMandobProfile(MandobProfileUpdateRequest $request)
    {
        $item = $this->mandobProfileManager->updateMandobProfile($request);
        if ($item == "user is not found") {
           return $item;
        }
        return $this->autoMapping->map(MandobProfileEntity::class, MandobProfileCreateResponse::class, $item);
    }

    public function mandobFilterByStatus($status)
    {
        $response = [];

        $items = $this->mandobProfileManager->mandobFilterByStatus($status);

        foreach ($items as $item){
            $item['image'] = $this->getImageParams($item['image'], $this->params . $item['image'], $this->params);

            $response[] = $this->autoMapping->map('array', MandobFilterByStatusResponse::class, $item);
        }

        return $response;
    }

    public function getImageParams($imageURL, $image, $baseURL): array
    {
        $item['imageURL'] = $imageURL;
        $item['image'] = $image;
        $item['baseURL'] = $baseURL;

        return $item;
    }

    public function activateMandobAccountByAdmin(ActivateMandobAccountByAdminRequest $request)
    {
        $item = $this->mandobProfileManager->activateMandobAccountByAdmin($request);
        if ($item == "user is not found") {
            return $item;
        }
        return $this->autoMapping->map(MandobProfileEntity::class, ActivateMandobAccountByAdminResponse::class, $item);
    }

    public function getRepresentativeFinancialAccountForAdmin($representativeID)
    {
        $response = [];

        $response['paymentsToRepresentative'] = $this->deliveryCompanyPaymentToRepresentativeService->getDeliveryCompanyPaymentsToRepresentativeByRepresentativeID($representativeID);
        $response['sumPaymentsToRepresentative'] = (float)$this->deliveryCompanyPaymentToRepresentativeService->getDeliveryCompanySumPaymentsToRepresentative($representativeID);
        $response['countLinkedStores'] = (float)$this->representativeStoreLinkService->getCountLinkedStoresByRepresentativeUserID($representativeID);
        $response['sumRepresentativeDue'] = (float)$this->representativeDueService->getSumRepresentativeDueByRepresentativeUserID($representativeID);
        $response['totalRemainingPaymentsToRepresentative'] = $response['sumRepresentativeDue'] - $response['sumPaymentsToRepresentative'];

        return $this->autoMapping->map('array', RepresentativeFinancialAccountForAdminGetResponse::class, $response);
    }

    public function getRepresentativeFinancialAccountInLastMonthForAdmin($representativeID)
    {
        $response = [];

        $date = $this->dateFactoryService->returnLastMonthDate();

        $response['paymentsToRepresentative'] = $this->deliveryCompanyPaymentToRepresentativeService->getDeliveryCompanyPaymentsToRepresentativeByRepresentativeIdInSpecificDate($representativeID, $date[0], $date[1]);
        $response['sumPaymentsToRepresentative'] = (float)$this->deliveryCompanyPaymentToRepresentativeService->getDeliveryCompanySumPaymentsToRepresentativeInSpecificDate($representativeID, $date[0], $date[1]);
        $response['countLinkedStores'] = (float)$this->representativeStoreLinkService->getCountLinkedStoresByRepresentativeUserID($representativeID);
        $response['sumRepresentativeDue'] = (float)$this->representativeDueService->getSumRepresentativeDueByRepresentativeUserIdAndInSpecificDate($representativeID, $date[0], $date[1]);
        $response['totalRemainingPaymentsToRepresentative'] = $response['sumRepresentativeDue'] - $response['sumPaymentsToRepresentative'];

        return $this->autoMapping->map('array', RepresentativeFinancialAccountForAdminGetResponse::class, $response);
    }

    public function getRepresentativeFinancialAccountInSpecificDateForAdmin($representativeID, $fromDate, $toDate)
    {
        $response = [];

        $date = $this->dateFactoryService->returnSpecificDate($fromDate, $toDate);

        $response['paymentsToRepresentative'] = $this->deliveryCompanyPaymentToRepresentativeService->getDeliveryCompanyPaymentsToRepresentativeByRepresentativeIdInSpecificDate($representativeID, $date[0], $date[1]);
        $response['sumPaymentsToRepresentative'] = (float)$this->deliveryCompanyPaymentToRepresentativeService->getDeliveryCompanySumPaymentsToRepresentativeInSpecificDate($representativeID, $date[0], $date[1]);
        $response['countLinkedStores'] = (float)$this->representativeStoreLinkService->getCountLinkedStoresByRepresentativeUserID($representativeID);
        $response['sumRepresentativeDue'] = (float)$this->representativeDueService->getSumRepresentativeDueByRepresentativeUserIdAndInSpecificDate($representativeID, $date[0], $date[1]);
        $response['totalRemainingPaymentsToRepresentative'] = $response['sumRepresentativeDue'] - $response['sumPaymentsToRepresentative'];

        return $this->autoMapping->map('array', RepresentativeFinancialAccountForAdminGetResponse::class, $response);
    }

    public function getRepresentativeFinancialAccountInSpecificDate($representativeID, $fromDate, $toDate)
    {
        $response = [];

        $date = $this->dateFactoryService->returnSpecificDate($fromDate, $toDate);

        $response['paymentsToRepresentative'] = $this->deliveryCompanyPaymentToRepresentativeService->getDeliveryCompanyPaymentsToRepresentativeByRepresentativeIdInSpecificDate($representativeID, $date[0], $date[1]);
        $response['sumPaymentsToRepresentative'] = (float)$this->deliveryCompanyPaymentToRepresentativeService->getDeliveryCompanySumPaymentsToRepresentativeInSpecificDate($representativeID, $date[0], $date[1]);
        $response['countLinkedStores'] = (float)$this->representativeStoreLinkService->getCountLinkedStoresByRepresentativeUserID($representativeID);
        $response['sumRepresentativeDue'] = (float)$this->representativeDueService->getSumRepresentativeDueByRepresentativeUserIdAndInSpecificDate($representativeID, $date[0], $date[1]);
        $response['totalRemainingPaymentsToRepresentative'] = $response['sumRepresentativeDue'] - $response['sumPaymentsToRepresentative'];

        return $this->autoMapping->map('array', RepresentativeFinancialAccountGetResponse::class, $response);
    }

    public function getRemainingPaymentsForRepresentative(): array
    {
        $response = [];

        $representatives = $this->mandobProfileManager->getAllRepresentatives();

        foreach ($representatives as $representative) {

            $financialAccount = $this->getRepresentativeFinancialAccountForAdmin($representative['mandobID']);

            $representative['totalRemainingPaymentsToRepresentative'] = $financialAccount->totalRemainingPaymentsToRepresentative;

            if ($representative['totalRemainingPaymentsToRepresentative'] > 0 ) {

                $representative['image'] = $this->getImageParams($representative['image'], $this->params . $representative['image'], $this->params);

                $response[] =  $this->autoMapping->map('array', RepresentativeRemainingForItAmountResponse::class, $representative);
            }
        }

        return $response;
    }

    public function getStatisticsForRepresentative($representativeID)
    {
        $response = [];

        $date = $this->dateFactoryService->returnLastMonthDate();

        $response['totalLinkedStores'] = (float)$this->representativeStoreLinkService->getCountLinkedStores();
        $response['representativeTotalLinkedStores'] = (float)$this->representativeStoreLinkService->getCountLinkedStoresByRepresentativeUserID($representativeID);
        $response['representativeLinkedStoresLastMonth'] = (float)$this->representativeStoreLinkService->getCountLinkedStoresByRepresentativeUserIdAndInSpecificDate($representativeID, $date[0], $date[1]);
        
        return $this->autoMapping->map('array', StatisticsForRepresentativeGetResponse::class, $response);
    }
}
