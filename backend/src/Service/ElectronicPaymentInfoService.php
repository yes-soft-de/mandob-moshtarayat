<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\ElectronicPaymentInfoEntity;
use App\Request\ElectronicPaymentInfoCreateRequest;
use App\Manager\ElectronicPaymentInfoManager;
use App\Response\PayInfoResponse;

class ElectronicPaymentInfoService
{

    /**
     * @var ElectronicPaymentInfoManager
     */
    private $electronicPaymentInfoManager;

    /**
     * @var AutoMapping
     */
    private $autoMapping;

    public function __construct(ElectronicPaymentInfoManager $electronicPaymentInfoManager, AutoMapping $autoMapping )
    {
        $this->electronicPaymentInfoManager = $electronicPaymentInfoManager;
        $this->autoMapping = $autoMapping;
    }

    public function addInfoPay(ElectronicPaymentInfoCreateRequest $request)
    {
        return $this->electronicPaymentInfoManager->addInfoPay($request);
    }

    public function getPayInfoByOrderNumber($orderNumber)
    {
        $item = $this->electronicPaymentInfoManager->getPayInfoByOrderNumber($orderNumber);

        return $this->autoMapping->map(ElectronicPaymentInfoEntity ::class, PayInfoResponse::class, $item);
    }
}