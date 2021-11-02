<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\ClientProfileEntity;
use App\Entity\UserEntity;
use App\Manager\UserManager;
use App\Request\UserRegisterRequest;
use App\Request\ClientProfileUpdateRequest;
use App\Response\clientOrdersCountResponse;
use App\Response\ClientProfileResponse;
use App\Response\ClientsProfileResponse;
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
    private $roomIdHelperService;
    private $storeOwnerProfileService;
    private $productService;
    private $ratingService;
    private $params;

    public function __construct(AutoMapping $autoMapping, UserManager $userManager,  RatingService $ratingService, ParameterBagInterface $params, RoomIdHelperService $roomIdHelperService, ProductService $productService, StoreOwnerProfileService $storeOwnerProfileService)
    {
        $this->autoMapping = $autoMapping;
        $this->userManager = $userManager;
        $this->ratingService = $ratingService;
        $this->roomIdHelperService = $roomIdHelperService;
        $this->productService = $productService;
        $this->storeOwnerProfileService = $storeOwnerProfileService;

        $this->params = $params->get('upload_base_url') . '/';
    }

    public function clientRegister(UserRegisterRequest $request)
    {
        $roomID = $this->roomIdHelperService->roomIdGenerate();
        $userRegister = $this->userManager->clientRegister($request, $roomID);
        if ($userRegister instanceof UserEntity) {
            
        return $this->autoMapping->map(UserEntity::class, UserRegisterResponse::class, $userRegister);

        }
        if ($userRegister == true) {
          
            $user = $this->userManager->getUserByUserID($request->getUserID());
            $user['found']="yes";
            return $user;
        }
    }

    public function updateClientProfile(ClientProfileUpdateRequest $request)
    {
        $item = $this->userManager->updateClientProfile($request);
        
        return $this->autoMapping->map(ClientProfileEntity ::class, ClientProfileResponse::class, $item);
    }

    public function getClientProfileByClientID($clientID)
    {
        $item = $this->userManager->getClientProfileByClientID($clientID);  
            
        return $this->autoMapping->map('array', ClientProfileResponse::class, $item);
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

        $stores = $this->storeOwnerProfileService->getStoresByName($itemName);
        $products = $this->productService->getProductsByName($itemName);

        foreach ($stores as $store)
            {
                $store['rate'] = $this->ratingService->getAvgRating($stores[0]['id'], 'store');
                $response['stores'][]= $this->autoMapping->map('array', ClientFilterStoreResponse::class, $store);
            }
        foreach ($products as $product)
            {
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
}
