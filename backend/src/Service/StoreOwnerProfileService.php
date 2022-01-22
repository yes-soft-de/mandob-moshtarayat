<?php

namespace App\Service;

use App\AutoMapping;
use App\Constant\RepresentativeStoreLinkTypeConstant;
use App\Entity\UserEntity;
use App\Manager\StoreOwnerProfileManager;
use App\Request\RepresentativeStoreLinkUpdateRequest;
use App\Request\storeOwnerProfileStatusUpdateByAdminRequest;
use App\Entity\StoreOwnerProfileEntity;
use App\Manager\UserManager;
use App\Request\StoreOwnerProfileCreateByAdminRequest;
use App\Request\StoreOwnerProfileUpdateRequest;
use App\Request\StoreOwnerUpdateByAdminRequest;
use App\Request\UserProfilePreferredLanguageUpdateRequest;
use App\Request\UserRegisterRequest;
use App\Request\VerificationCreateRequest;
use App\Response\CaptainIsActiveResponse;
use App\Response\RepresentativeStoreLinkGetByStoreIPResponse;
use App\Response\StoreFinancialAccountForStoreResponse;
use App\Response\StoreNameResponse;
use App\Response\StoreOwnerLast15Response;
use App\Response\StoreOwnerProfileByRepresentativeUserIdGetResponse;
use App\Response\StoreOwnerProfileByRepresentativeUserIdForAdminGetResponse;
use App\Response\StoreOwnerProfileCreateResponse;
use App\Response\StoreOwnerProfileDeleteResponse;
use App\Response\StoreOwnerProfilePreferredLanguageUpdateResponse;
use App\Response\StoreOwnerProfileResponse;
use App\Response\StoreOwnerByCategoryIdResponse;
use App\Response\StoresFilterByNameResponse;
use App\Response\UserRegisterResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class StoreOwnerProfileService
{
    private $autoMapping;
    private $userManager;
    private $storeOwnerProfileManager;
    private $storeOwnerBranchService;
    private $params;
    private $roomIdHelperService;
    private $ratingService;
    private $deliveryCompanyPaymentsToStoreService;
    private $verificationService;
    private $ordersInvoicesService;
    private $representativeStoreLinkService;

    public function __construct(AutoMapping $autoMapping, UserManager $userManager, RatingService $ratingService, StoreOwnerBranchService $storeOwnerBranchService,
                                ParameterBagInterface $params, RoomIdHelperService $roomIdHelperService, StoreOwnerProfileManager $storeOwnerProfileManager, DeliveryCompanyPaymentsToStoreService $deliveryCompanyPaymentsToStoreService,
     VerificationService $verificationService, OrdersInvoicesService $ordersInvoicesService, RepresentativeStoreLinkService $representativeStoreLinkService)
    {
        $this->autoMapping = $autoMapping;
        $this->userManager = $userManager;
        $this->storeOwnerProfileManager = $storeOwnerProfileManager;
        $this->ratingService = $ratingService;
        $this->storeOwnerBranchService = $storeOwnerBranchService;
        $this->roomIdHelperService = $roomIdHelperService;
        $this->deliveryCompanyPaymentsToStoreService = $deliveryCompanyPaymentsToStoreService;
        $this->verificationService = $verificationService;
        $this->representativeStoreLinkService = $representativeStoreLinkService;
        $this->params = $params->get('upload_base_url') . '/';
        $this->ordersInvoicesService = $ordersInvoicesService;

    }

    public function storeOwnerRegister(UserRegisterRequest $request)
    {
        $request->setRoomID($this->roomIdHelperService->roomIdGenerate());

        $userRegister = $this->storeOwnerProfileManager->storeOwnerRegister($request);

        if($userRegister instanceof UserEntity)
        {
            $this->createVerificationCodeForStoreOwner($request);

            // Check if the IP of the store owner device is linked with representative
            $this->checkIfStoreOwnerDeviceIsLinkedWithRepresentative($userRegister->getId());

            return $this->autoMapping->map(UserEntity::class, UserRegisterResponse::class, $userRegister);
        }
        elseif(is_array($userRegister))
        {
            $response = $this->autoMapping->map('array', UserRegisterResponse::class, $userRegister);

            $response->found = 1;

            return $response;
        }
    }

    public function storeOwnerRegisterByDeveloper(UserRegisterRequest $request)
    {
        $request->setRoomID($this->roomIdHelperService->roomIdGenerate());

        $userRegister = $this->storeOwnerProfileManager->storeOwnerRegisterByDeveloper($request);

        if($userRegister instanceof UserEntity)
        {
            return $this->autoMapping->map(UserEntity::class, UserRegisterResponse::class, $userRegister);
        }
        elseif(is_array($userRegister))
        {
            $response = $this->autoMapping->map('array', UserRegisterResponse::class, $userRegister);

            $response->found = 1;

            return $response;
        }
    }

    public function createVerificationCodeForStoreOwner(UserRegisterRequest $userEntity)
    {
        $createVerificationRequest = $this->autoMapping->map(UserRegisterRequest::class, VerificationCreateRequest::class, $userEntity);

        $this->verificationService->createVerificationCode($createVerificationRequest);
    }

    public function checkIfStoreOwnerDeviceIsLinkedWithRepresentative($storeOwnerUserID)
    {
        $representativeStoreLinkResult = $this->representativeStoreLinkService->getRepresentativeStoreLinkByStoreOwnerIP(str_replace(array(":", "."), "", $_SERVER['REMOTE_ADDR']));

        if ($representativeStoreLinkResult) {

            // there is a representative which bing this store owner
            // so update the founded status to 'linked'
            $updateRepresentativeStoreLinkRequest = $this->autoMapping->map(RepresentativeStoreLinkGetByStoreIPResponse::class, RepresentativeStoreLinkUpdateRequest::class, $representativeStoreLinkResult);

            $updateRepresentativeStoreLinkRequest->setLinkStatus(RepresentativeStoreLinkTypeConstant::$REPRESENTATIVE_STORE_LINKED);
            $updateRepresentativeStoreLinkRequest->setStoreOwnerUserID($storeOwnerUserID);

            $this->representativeStoreLinkService->updateRepresentativeStoreLink($updateRepresentativeStoreLinkRequest);
        }
    }

    public function storeOwnerProfileUpdate(StoreOwnerProfileUpdateRequest $request)
    {
        $item = $this->userManager->storeOwnerProfileUpdate($request);
        
        return $this->autoMapping->map(StoreOwnerProfileEntity::class, StoreOwnerProfileResponse::class, $item);
    }

    public function updateStoreOwnerByAdmin(StoreOwnerUpdateByAdminRequest $request)
    {
        $item = $this->userManager->updateStoreOwnerByAdmin($request);

        return $this->autoMapping->map(StoreOwnerProfileEntity::class, StoreOwnerProfileResponse::class, $item);
    }

    public function updateStoreOwnerProfilePreferredLanguage(UserProfilePreferredLanguageUpdateRequest $request)
    {
        $captainProfile = $this->storeOwnerProfileManager->updateStoreOwnerProfilePreferredLanguage($request);

        if ($captainProfile == 'noStoreOwnerProfileWasFound')
        {
            $response['status'] = 'noStoreOwnerProfileWasFound';

            return $this->autoMapping->map('array', StoreOwnerProfilePreferredLanguageUpdateResponse::class, $response);
        }
        else
        {
            return $this->autoMapping->map(StoreOwnerProfileEntity::class, StoreOwnerProfilePreferredLanguageUpdateResponse::class, $captainProfile);
        }
    }

    public function storeOwnerProfileStatusUpdateByAdmin(storeOwnerProfileStatusUpdateByAdminRequest $request)
    {
        $item = $this->userManager->storeOwnerProfileStatusUpdateByAdmin($request);

        return $this->autoMapping->map(StoreOwnerProfileEntity::class, StoreOwnerProfileResponse::class, $item);
    }

    public function getStoreOwnerProfileById($id)
    {
        $response = null;

        $item = $this->storeOwnerProfileManager->getStoreOwnerProfileByID($id);
        if($item){
            $item['image'] = $this->getImageParams($item['image'], $this->params.$item['image'], $this->params);

            $item['branches'] = $this->storeOwnerBranchService->getBranchesByStoreOwnerProfileID($item['id']);
            $item['rating'] = $this->ratingService->getAvgRating($id, 'store');

            $response = $this->autoMapping->map('array', StoreOwnerProfileCreateResponse::class, $item);
        }
        return $response;
    }

    public function getStoreNameById($id)
    {
        $item = $this->storeOwnerProfileManager->getStoreNameById($id);

        return $this->autoMapping->map('array', StoreNameResponse::class, $item);
    }

    public function getStoreInfoById($id)
    {
        return $this->storeOwnerProfileManager->getStoreNameById($id);
    }

    public function getStoreIdByProfileId($id)
    {
       return $this->storeOwnerProfileManager->getStoreIdByProfileId($id);
    }

    public function getStoreOwnerProfile($userID)
    {
        $response = null;

        $storeOwnerProfileId = $this->storeOwnerProfileManager->getStoreProfileId($userID);

        $item = $this->storeOwnerProfileManager->getStoreOwnerProfileByID($storeOwnerProfileId);

        if($item)
        {
            $item['image'] = $this->getImageParams($item['image'], $this->params.$item['image'], $this->params);

            $item['branches'] = $this->storeOwnerBranchService->getBranchesByStoreOwnerProfileID($item['id']);

            $item['rating'] = $this->ratingService->getAvgRating($storeOwnerProfileId, 'store');

            $response = $this->autoMapping->map('array', StoreOwnerProfileCreateResponse::class, $item);
        }

        return $response;
    }

    public function getAllStoreOwners(): array
    {
        $response = [];

        $items = $this->storeOwnerProfileManager->getAllStoreOwners();
        foreach ($items as $item) {
            $item['rating'] = $this->ratingService->getAvgRating($item['id'], 'store');

            $item['image'] = $this->getImageParams($item['image'], $this->params.$item['image'], $this->params);

            $response[] = $this->autoMapping->map('array', StoreOwnerByCategoryIdResponse::class, $item);

            }        

        return $response;
    }

    public function getStoreOwnerProfileByCategoryID($storeCategoryID)
    {
        return $this->storeOwnerProfileManager->getStoreOwnerProfileByCategoryID($storeCategoryID);
    }

    public function getStoreOwnerProfilesByIDsArray($storesIDsArray)
    {
        return $this->storeOwnerProfileManager->getStoreOwnerProfilesByIDsArray($storesIDsArray);
    }

    public function getLastFifteenStoreOwnerProfilesByIDsArray($storesIDsArray)
    {
        return $this->storeOwnerProfileManager->getLastFifteenStoreOwnerProfilesByIDsArray($storesIDsArray);
    }

    public function getLast15StoresByCategoryID($storeCategoryID)
    {
        return $this->storeOwnerProfileManager->getLast15StoresByCategoryID($storeCategoryID);
    }

    public function getStoreOwnerByCategoryId($storeCategoryId):array
    {
        $response = [];

        $items = $this->storeOwnerProfileManager->getStoreOwnerByCategoryId($storeCategoryId);
        foreach ($items as $item) {
            $item['rating'] = $this->ratingService->getAvgRating($item['id'], 'store');
            $item['image'] = $this->getImageParams($item['image'], $this->params.$item['image'], $this->params);

            $response[] = $this->autoMapping->map('array', StoreOwnerByCategoryIdResponse::class, $item);
       }

        return $response;
    }

    public function getStoreOwnerByCategoryIdForAdmin($storeCategoryId):array
    {
        $response = [];

        $items = $this->storeOwnerProfileManager->getStoreOwnerByCategoryIdForAdmin($storeCategoryId);

        foreach ($items as $item) {
            $item['image'] = $this->getImageParams($item['image'], $this->params.$item['image'], $this->params);
            $item['rating'] = $this->ratingService->getAvgRating($item['id'], 'store');

            $response[] = $this->autoMapping->map('array', StoreOwnerByCategoryIdResponse::class, $item);
        }

        return $response;
    }

    public function getStoreOwnerBest():array
    {
        $response = [];

        $items = $this->storeOwnerProfileManager->getStoreOwnerBest();

        foreach ($items as $item) {
            $item['image'] = $this->getImageParams($item['image'], $this->params.$item['image'], $this->params);
            $item['rating'] = $this->ratingService->getAvgRating($item['id'], 'store');
            $response[] = $this->autoMapping->map('array', StoreOwnerByCategoryIdResponse::class, $item);
        }

        return $response;
    }

    public function getStoreOwnerInactive():array
    {
        $response = [];

        $items = $this->storeOwnerProfileManager->getStoreOwnerInactive();

        foreach ($items as $item) {
            $item['imageURL'] = $item['image'];
            $item['image'] = $this->params.$item['image'];
            $item['baseURL'] = $this->params;

            $response[] = $this->autoMapping->map('array', StoreOwnerByCategoryIdResponse::class, $item);
            }

        return $response;
    }

    public function getStoreOwnerInactiveFilterByName($name):array
    {
        $response = [];

        $items = $this->storeOwnerProfileManager->getStoreOwnerInactiveFilterByName($name);

        foreach ($items as $item) {
            $item['imageURL'] = $item['image'];
            $item['image'] = $this->params.$item['image'];
            $item['baseURL'] = $this->params;
            //this for future
//              $item['image'] = $this->getImageParams($item['image'], $this->params.$item['image'], $this->params);

              $response[] = $this->autoMapping->map('array', StoreOwnerByCategoryIdResponse::class, $item);
            }

        return $response;
    }

    public function getImageParams($imageURL, $image, $baseURL):array
    {
        $item['imageURL'] = $imageURL;
        $item['image'] = $image;
        $item['baseURL'] = $baseURL;

        return $item;
    }

    public function createStoreOwnerProfileByAdmin(StoreOwnerProfileCreateByAdminRequest $request)
    {
        $userProfile = $this->userManager->createStoreOwnerProfileByAdmin($request);

        if ($userProfile instanceof StoreOwnerProfileEntity) {

            return $this->autoMapping->map(StoreOwnerProfileEntity::class,StoreOwnerProfileCreateResponse::class, $userProfile);
       }
    }

    public function countStores() {
        return $this->storeOwnerProfileManager->countStores();
    }

    public function getActiveStoresByName($name) {
       return $this->storeOwnerProfileManager->getActiveStoresByName($name);
    }

    public function getStoresFilterByName($name) {
        $response = [];

        $items = $this->storeOwnerProfileManager->getStoresByName($name);

        foreach ($items as $item) {
            $item['image'] = $this->getImageParams($item['image'], $this->params.$item['image'], $this->params);

            $response[] = $this->autoMapping->map('array', StoresFilterByNameResponse::class, $item);
        }

        return $response;
    }

    public function storeIsActive($userID)
    {
        $item = $this->storeOwnerProfileManager->storeIsActive($userID);

        return $this->autoMapping->map('array',CaptainIsActiveResponse::class, $item);
    }

    public function storeFinancialAccountForStore($userID)
    {
        $storeOwnerProfileId = $this->storeOwnerProfileManager->getStoreProfileId($userID);
        $invoicesIDs = $this->storeOwnerProfileManager->getInvoicesIDs($storeOwnerProfileId);
        $item['amountOwedToStore'] = (float)$this->ordersInvoicesService->sumInvoiceAmountWithoutOrderTypeSendIt($invoicesIDs);

        $item['sumPaymentsToStore'] = (float)$this->deliveryCompanyPaymentsToStoreService->deliveryCompanySumPaymentsToStore($storeOwnerProfileId);
        $item['total'] =  $item['amountOwedToStore'] -  $item['sumPaymentsToStore'];
        $item['paymentsToStore'] = $this->deliveryCompanyPaymentsToStoreService->deliveryCompanyPaymentsToStore($storeOwnerProfileId);

        return $this->autoMapping->map('array',StoreFinancialAccountForStoreResponse::class, $item);
    }

    public function storeFinancialAccountForStoreInSpecificDate($userID, $fromDate, $toDate)
    {
        $storeOwnerProfileId = $this->storeOwnerProfileManager->getStoreProfileId($userID);
        $invoicesIDs = $this->storeOwnerProfileManager->getInvoicesIDsForStoreInSpecificDate($storeOwnerProfileId['id'], $fromDate, $toDate);
        $item['amountOwedToStore'] = (float)$this->ordersInvoicesService->sumInvoiceAmountWithoutOrderTypeSendIt($invoicesIDs);

        $item['sumPaymentsToStore'] = (float)$this->deliveryCompanyPaymentsToStoreService->deliveryCompanySumPaymentsToStoreInSpecificDate($storeOwnerProfileId, $fromDate, $toDate);
        $item['total'] = $item['amountOwedToStore'] -  $item['sumPaymentsToStore'];
        $item['paymentsToStore'] = $this->deliveryCompanyPaymentsToStoreService->deliveryCompanyPaymentsToStoreInSpecificDate($storeOwnerProfileId, $fromDate, $toDate);

        return $this->autoMapping->map('array',StoreFinancialAccountForStoreResponse::class, $item);
    }

    public function storeFinancialAccountForAdmin($storeOwnerProfileId)
    {
        $invoicesIDs = $this->storeOwnerProfileManager->getInvoicesIDs($storeOwnerProfileId);

        $item['amountOwedToStore'] = (float)$this->ordersInvoicesService->sumInvoiceAmountWithoutOrderTypeSendIt($invoicesIDs);

        $item['sumPaymentsToStore'] = (float)$this->deliveryCompanyPaymentsToStoreService->deliveryCompanySumPaymentsToStore($storeOwnerProfileId);

        $total = $item['sumPaymentsToStore'] - $item['amountOwedToStore'];

        $item['total'] = round($total, 1);
        $item['paymentsToStore'] = $this->deliveryCompanyPaymentsToStoreService->deliveryCompanyPaymentsToStore($storeOwnerProfileId);

        return $this->autoMapping->map('array',StoreFinancialAccountForStoreResponse::class, $item);
    }

    public function getStoreOwnersByRepresentativeID($representativeUserID): ?array
    {
        $response = [];

        $storeOwnersProfiles = $this->storeOwnerProfileManager->getStoreOwnersByRepresentativeID($representativeUserID);
        
        if ($storeOwnersProfiles) {

            foreach ($storeOwnersProfiles as $storeOwnerProfile) {

                $storeOwnerProfile['image'] = $this->getImageParams($storeOwnerProfile['image'], $this->params.$storeOwnerProfile['image'], $this->params);

                $response[] = $this->autoMapping->map('array', StoreOwnerProfileByRepresentativeUserIdGetResponse::class, $storeOwnerProfile);
            }
        }

        return $response;
    }

    public function getStoreOwnersByRepresentativeIdForAdmin($representativeUserID): ?array
    {
        $response = [];

        $storeOwnersProfiles = $this->storeOwnerProfileManager->getStoreOwnersByRepresentativeIdForAdmin($representativeUserID);
        
        if ($storeOwnersProfiles) {

            foreach ($storeOwnersProfiles as $storeOwnerProfile) {

                $storeOwnerProfile['image'] = $this->getImageParams($storeOwnerProfile['image'], $this->params.$storeOwnerProfile['image'], $this->params);

                $response[] = $this->autoMapping->map('array', StoreOwnerProfileByRepresentativeUserIdForAdminGetResponse::class, $storeOwnerProfile);
            }
        }

        return $response;
    }

    public function getLast15Stores(): array
    {
        $response = [];

        $items = $this->storeOwnerProfileManager->getLast15Stores();

        foreach ($items as $item) {
            $item['image'] = $this->getImageParams($item['image'], $this->params.$item['image'], $this->params);
            $item['rating'] = $this->ratingService->getAvgRating( $item['id'], 'store');

            $response[] = $this->autoMapping->map('array', StoreOwnerLast15Response::class, $item);
        }

        return $response;
    }

    public function deleteStoreOwnerProfile($request)
    {
        $isRelated = $this->storeOwnerProfileManager->isItRelatedToProduct($request->getID());
        if($isRelated == "not related") {
            $result = $this->storeOwnerProfileManager->deleteStoreOwnerProfile($request);

            if ($result == 'storeOwnerProfileNotFound') {
                return $result;
            } else {
                return $this->autoMapping->map(StoreOwnerProfileEntity::class, StoreOwnerProfileDeleteResponse::class, $result);
            }
        }

        return $isRelated;
    }
}
