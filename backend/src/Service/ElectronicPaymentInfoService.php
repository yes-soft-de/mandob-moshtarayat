<?php

namespace App\Service;

use App\AutoMapping;
use App\Constant\ResponseConstant;
use App\Entity\ElectronicPaymentInfoEntity;
use App\Request\ElectronicPaymentInfoCreateRequest;
use App\Response\AddInfoPayByClientResponse;
use App\Manager\ElectronicPaymentInfoManager;

class ElectronicPaymentInfoService
{

    public function __construct(AutoMapping $autoMapping, ElectronicPaymentInfoManager $electronicPaymentInfoManager)
    {
        $this->autoMapping = $autoMapping;
        $this->electronicPaymentInfoManager = $electronicPaymentInfoManager;
    }

    public function addInfoPay(ElectronicPaymentInfoCreateRequest $request)
    {
        $item = $this->electronicPaymentInfoManager->addInfoPay($request);

        return $this->autoMapping->map(ElectronicPaymentInfoEntity::class, AddInfoPayByClientResponse::class, $item);
    }
}