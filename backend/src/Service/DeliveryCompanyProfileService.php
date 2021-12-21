<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\DeliveryCompanyProfileEntity;
use App\Manager\DeliveryCompanyProfileManager;
use App\Request\DeliveryCompanyInfoRequest;
use App\Response\DeliveryCompanyInfoResponse;

class DeliveryCompanyProfileService
{
    private $autoMapping;
    private $deliveryCompanyProfileManager;

    public function __construct(AutoMapping $autoMapping, DeliveryCompanyProfileManager $deliveryCompanyProfileManager)
    {
        $this->autoMapping = $autoMapping;
        $this->deliveryCompanyProfileManager = $deliveryCompanyProfileManager;
    }

    public function createDeliveryCompanyInfo(DeliveryCompanyInfoRequest $request)
    {
        $item = $this->deliveryCompanyProfileManager->createDeliveryCompanyInfo($request);
        if ($item instanceof DeliveryCompanyProfileEntity) {
        return $this->autoMapping->map(DeliveryCompanyProfileEntity::class, DeliveryCompanyInfoResponse::class, $item);
        }
        if ($item == true) {
          
            return $this->getcompanyinfoAll();
        }
    }

    public function updateCompanyInfo($request)
    {
        $result = $this->deliveryCompanyProfileManager->updateCompanyInfo($request);

        return $this->autoMapping->map(DeliveryCompanyProfileEntity::class, DeliveryCompanyInfoResponse::class, $result);
    }

    public function  getcompanyinfoById($id)
    {
        $result = $this->deliveryCompanyProfileManager->getcompanyinfoById($id);

        return $this->autoMapping->map(DeliveryCompanyProfileEntity::class, DeliveryCompanyInfoResponse::class, $result);
  
    }

    public function  getcompanyinfoAll()
    {
        $respons=[];
        $results = $this->deliveryCompanyProfileManager->getcompanyinfoAll();
       
        foreach ($results as  $result) {
           $respons[]= $this->autoMapping->map('array', DeliveryCompanyInfoResponse::class, $result);
        }
        return $respons;
       
    }

     public function  getAllCompanyInfoForStoreOwner($userId)
    {
        $respons=[];
        $results = $this->deliveryCompanyProfileManager->getAllCompanyInfoForStoreOwner($userId);
       
        foreach ($results as  $result) {
           $respons[]= $this->autoMapping->map('array', DeliveryCompanyInfoResponse::class, $result);
        }
        return $respons;
       
    }

    public function  getAllCompanyInfoForCaptain($userId)
    {
        $respons=[];
        $results = $this->deliveryCompanyProfileManager->getAllCompanyInfoForCaptain($userId);
       
        foreach ($results as  $result) {
           $respons[]= $this->autoMapping->map('array', DeliveryCompanyInfoResponse::class, $result);
        }
        return $respons;
    }
}
