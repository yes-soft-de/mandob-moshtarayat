<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\DeliveryCompanyProfileEntity;
use App\Manager\DeliveryCompanyProfileManager;
use App\Request\DeliveryCompanyInfoRequest;
use App\Response\DeliveryCompanyInfoResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class DeliveryCompanyProfileService
{
    private $autoMapping;
    private $deliveryCompanyProfileManager;
    private $params;

    public function __construct(AutoMapping $autoMapping, DeliveryCompanyProfileManager $deliveryCompanyProfileManager, ParameterBagInterface $params)
    {
        $this->autoMapping = $autoMapping;
        $this->deliveryCompanyProfileManager = $deliveryCompanyProfileManager;
        $this->params = $params->get('upload_base_url') . '/';
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
        $response=[];

        $results = $this->deliveryCompanyProfileManager->getcompanyinfoAll();
       
        foreach ($results as  $result) {

            $result['qrCode'] = $this->params.$result['qrCode'];
            $result['qrCodeBase64'] = base64_encode($this->params.$result['qrCode']);
            $response[]= $this->autoMapping->map('array', DeliveryCompanyInfoResponse::class, $result);

        }

        return $response;
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
