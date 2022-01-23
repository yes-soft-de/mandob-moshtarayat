<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\ClientProfileEntity;
use App\Entity\UserEntity;
use App\Manager\ClientProfileManager;
use App\Manager\UserManager;
use App\Request\ClientByUserIdGetRequest;
use App\Request\ClientProfileNeedSupportUpdateRequest;
use App\Request\ClientUpdateFavouriteCategoriesRequest;
use App\Request\UserProfilePreferredLanguageUpdateRequest;
use App\Request\UserRegisterRequest;
use App\Request\ClientProfileUpdateRequest;
use App\Request\VerificationCreateRequest;
use App\Response\AnonymousUsersWhoNeedSupportResponse;
use App\Response\clientOrdersCountResponse;
use App\Response\ClientProfileByUserIdGetResponse;
use App\Response\ClientProfileNeedSupportUpdateResponse;
use App\Response\ClientProfilePreferredLanguageUpdateResponse;
use App\Response\ClientProfileResponse;
use App\Response\ClientProfileWithFavouriteCategoriesResponse;
use App\Response\ClientsProfileResponse;
use App\Response\ClientUpdateFavouriteCategoriesResponse;
use App\Response\UserRegisterResponse;
use App\Response\NotificationLocalResponse;
use App\Response\ClientFilterStoreResponse;
use App\Response\ClientFilterProductResponse;
use App\Service\RoomIdHelperService;
use App\Service\StoreOwnerProfileService;
use App\Service\ProductService;

use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;


class ClientProfileService
{
    private $autoMapping;
    private $userManager;
    private $clientProfileManager;
    private $roomIdHelperService;
    private $storeOwnerProfileService;
    private $productService;
    private $ratingService;
    private $verificationService;
    private $anonymousChatService;
    private $params;

    public function __construct(AutoMapping $autoMapping, UserManager $userManager,  RatingService $ratingService, ParameterBagInterface $params, RoomIdHelperService $roomIdHelperService,
                                ProductService $productService, StoreOwnerProfileService $storeOwnerProfileService, VerificationService $verificationService, ClientProfileManager $clientProfileManager,
     AnonymousChatService $anonymousChatService)
    {
        $this->autoMapping = $autoMapping;
        $this->userManager = $userManager;
        $this->clientProfileManager = $clientProfileManager;
        $this->ratingService = $ratingService;
        $this->roomIdHelperService = $roomIdHelperService;
        $this->productService = $productService;
        $this->storeOwnerProfileService = $storeOwnerProfileService;
        $this->verificationService = $verificationService;
        $this->anonymousChatService = $anonymousChatService;

        $this->params = $params->get('upload_base_url') . '/';
    }

    public function clientRegister(UserRegisterRequest $request)
    {
        $roomID = $this->roomIdHelperService->roomIdGenerate();
        $userRegister = $this->userManager->clientRegister($request, $roomID);
        if ($userRegister instanceof UserEntity)
        {
            $this->createVerificationCodeForClient($request);
            
            return $this->autoMapping->map(UserEntity::class, UserRegisterResponse::class, $userRegister);

        }
        if ($userRegister == true) {
          
            $user = $this->userManager->getUserByUserID($request->getUserID());
            $user['found']="yes";
            return $user;
        }
    }

    public function createVerificationCodeForClient(UserRegisterRequest $userEntity)
    {
        $createVerificationRequest = $this->autoMapping->map(UserRegisterRequest::class, VerificationCreateRequest::class, $userEntity);

        $this->verificationService->createVerificationCode($createVerificationRequest);
    }

    public function updateClientProfile(ClientProfileUpdateRequest $request)
    {
        $item = $this->userManager->updateClientProfile($request);
        
        return $this->autoMapping->map(ClientProfileEntity ::class, ClientProfileResponse::class, $item);
    }

    public function getClientProfileByClientID($clientID)
    {
        $item = $this->userManager->getClientProfileByClientID($clientID);  
            
        return $this->autoMapping->map('array', ClientProfileWithFavouriteCategoriesResponse::class, $item);
    }

    public function getClientByUserID($clientID)
    {
        $client = $this->clientProfileManager->getClientByUserID($clientID);

        $client['image'] = $this->params.$client['image'];

        return $this->autoMapping->map('array', ClientProfileByUserIdGetResponse::class, $client);
    }

    public function getClientProfileByID($id)
    {
        $item = $this->userManager->getClientProfileByID($id);
        $item['imageURL'] = $item['image'];
        $item['image'] = $this->params.$item['image'];
        $item['baseURL'] = $this->params;
        $item['statistics'] = $this->clientOrdersReport($item['clientID']);

        return $this->autoMapping->map('array', ClientProfileResponse::class, $item);
    }

    public function getClientsProfile(): array
    {
        $response = [];
        $items = $this->userManager->getClientsProfile();

        foreach ($items as $item) {
            $item['imageURL'] = $item['image'];
            $item['image'] = $this->params.$item['image'];
            $item['baseURL'] = $this->params;

            $response[] = $this->autoMapping->map('array', ClientsProfileResponse::class, $item);
        }
        return $response;
    }

    public function clientOrdersReport($clientID) {

        $item['clientOrdersCount'] = $this->userManager->clientOrdersCount($clientID);
        $item['clientOrdersCancel'] = $this->userManager->clientOrdersCancel($clientID);
        $item['clientOrdersDelivered'] = $this->userManager->clientOrdersDelivered($clientID);

        return $this->autoMapping->map('array', clientOrdersCountResponse::class, $item);
    }

    public function countClients() {

        return $this->userManager->countClients();
    }

    public function clientFilter($itemName): array
    {
        $response = [];

        $stores = $this->storeOwnerProfileService->getActiveStoresByName($itemName);

        $products = $this->productService->getProductsByName($itemName);

        foreach($stores as $store)
        {
            $store['rate'] = $this->ratingService->getAvgRating($stores[0]['id'], 'store');

            if($store['image'])
            {
                $store['image'] = $this->params . $store['image'];
            }

            $response['stores'][] = $this->autoMapping->map('array', ClientFilterStoreResponse::class, $store);
        }

        foreach($products as $product)
        {
            $product['costDetails'] = $this->productService->costDetails($product['isCommission'], $product['productPrice'], $product['commission'], $product['storeCommission'], $product['discount']);

            if($product['productImage'])
            {
                $product['productImage'] = $this->params . $product['productImage'];
            }

            if($product['storeImage'])
            {
                $product['storeImage'] = $this->params . $product['storeImage'];
            }

            $response['products'][] = $this->autoMapping->map('array', ClientFilterProductResponse::class, $product);
        }

        return $response;
    }

   public function clientsByName($name): array
   {
       $response = [];

       $clients = $this->userManager->clientsByName($name);

       foreach ($clients as $client)
        {
            $client['imageURL'] = $client['image'];
            $client['image'] = $this->params.$client['image'];
            $client['baseURL'] = $this->params;
            $response[]= $this->autoMapping->map('array', ClientsProfileResponse::class, $client);
        }
       return $response;
   }

    public function updateClientFavouriteCategories(ClientUpdateFavouriteCategoriesRequest $request)
    {
        $item = $this->userManager->updateClientFavouriteCategories($request);

        return $this->autoMapping->map(ClientProfileEntity ::class, ClientUpdateFavouriteCategoriesResponse::class, $item);
    }

    public function updateClientProfileNeedSupport(ClientProfileNeedSupportUpdateRequest $request)
    {
        $result = $this->clientProfileManager->updateClientProfileNeedSupport($request);

        if ($result == 'noClientProfileWasFound')
        {
            $response['status'] = 'noClientProfileWasFound';

            return $this->autoMapping->map('array', ClientProfileNeedSupportUpdateResponse::class, $response);
        }
        else
        {
            return $this->autoMapping->map(ClientProfileEntity ::class, ClientProfileNeedSupportUpdateResponse::class, $result);
        }
    }

    public function updateClientProfilePreferredLanguage(UserProfilePreferredLanguageUpdateRequest $request)
    {
        $clientProfile = $this->clientProfileManager->updateClientProfilePreferredLanguage($request);

        if ($clientProfile == 'noClientProfileWasFound')
        {
            $response['status'] = 'noClientProfileWasFound';

            return $this->autoMapping->map('array', ClientProfilePreferredLanguageUpdateResponse::class, $response);
        }
        else
        {
            return $this->autoMapping->map(ClientProfileEntity::class, ClientProfilePreferredLanguageUpdateResponse::class, $clientProfile);
        }
    }

    public function getClientProfileWhoNeedSupport()
    {
        $response = [];

        $clientsProfiles = $this->clientProfileManager->getClientProfileWhoNeedSupport();

        foreach ($clientsProfiles as $clientProfile)
        {
            if ($clientProfile['image'])
            {
                $clientProfile['image'] = $this->params.$clientProfile['image'];
            }

            $response[] = $this->autoMapping->map('array', ClientProfileByUserIdGetResponse::class, $clientProfile);
        }

        // Also, get anonymous users who need support
        $anonymousChats = $this->anonymousChatService->getAnonymousUsersWhoNeedSupport();

        foreach ($anonymousChats as $anonymousChat)
        {
            if (!$anonymousChat['clientName'])
            {
                $anonymousChat['clientName'] = (string)($anonymousChat['createdAt'])->format('Y-m-d H:i:s');
            }
            $response[] = $this->autoMapping->map('array', AnonymousUsersWhoNeedSupportResponse::class, $anonymousChat);
        }

        return $response;
    }
}
