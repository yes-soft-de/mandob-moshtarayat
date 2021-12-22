<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\StoreOwnerBranchEntity;
use App\Manager\StoreOwnerBranchManager;
use App\Request\StoreOwnerBranchCreateRequest;
use App\Response\StoreOwnerBranchResponse;


class StoreOwnerBranchService
{
    private $autoMapping;
    private $storeOwnerBranchManager;

    public function __construct(AutoMapping $autoMapping, StoreOwnerBranchManager $storeOwnerBranchManager)
    {
        $this->autoMapping = $autoMapping;
        $this->storeOwnerBranchManager = $storeOwnerBranchManager;
    }

    public function createBranches(StoreOwnerBranchCreateRequest $request)
    {
        $branch = $this->storeOwnerBranchManager->createBranches($request);

        return $this->autoMapping->map(StoreOwnerBranchEntity::class, StoreOwnerBranchResponse::class, $branch);
    }

    public function updateBranche($request)
    {
        $result = $this->storeOwnerBranchManager->updateBranche($request);

        return $this->autoMapping->map(StoreOwnerBranchEntity::class, StoreOwnerBranchResponse::class, $result);
    }

    public function getBranchesByStoreOwnerProfileID($storeOwnerProfileID):array
    {
        $response = [];
        $items = $this->storeOwnerBranchManager->getBranchesByStoreOwnerProfileID($storeOwnerProfileID);
        foreach ($items as $item) {
        $response[] =  $this->autoMapping->map('array', StoreOwnerBranchResponse::class, $item);
        }
        return $response;
    }

    public function branchesByStoreOwnerProfileID($storeOwnerProfileID)
    {
        return $this->storeOwnerBranchManager->branchesByStoreOwnerProfileID($storeOwnerProfileID);
    }

    public function getBrancheById($Id)
    {
        return $this->storeOwnerBranchManager->getBrancheById($Id);
    }
    
    public function updateBranchAvailability($request)
    {
        $result = $this->storeOwnerBranchManager->updateBranchAvailability($request);

        return $this->autoMapping->map(StoreOwnerBranchEntity::class, StoreOwnerBranchResponse::class, $result);
    }

    public function createBranchesByAdmin(StoreOwnerBranchCreateRequest $request)
    {
        $branch = $this->storeOwnerBranchManager->createBranchesByAdmin($request);

        return $this->autoMapping->map(StoreOwnerBranchEntity::class, StoreOwnerBranchResponse::class, $branch);
    }
}
