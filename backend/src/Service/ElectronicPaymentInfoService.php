<?php

namespace App\Service;

use App\Request\ElectronicPaymentInfoCreateRequest;
use App\Manager\ElectronicPaymentInfoManager;

class ElectronicPaymentInfoService
{

    /**
     * @var ElectronicPaymentInfoManager
     */
    private $electronicPaymentInfoManager;

    public function __construct(ElectronicPaymentInfoManager $electronicPaymentInfoManager)
    {
        $this->electronicPaymentInfoManager = $electronicPaymentInfoManager;
    }

    public function addInfoPay(ElectronicPaymentInfoCreateRequest $request)
    {
        return $this->electronicPaymentInfoManager->addInfoPay($request);
    }
}