<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\DeliveryCompanyPaymentsToRepresentativeEntity;
use App\Manager\DeliveryCompanyPaymentToRepresentativeManager;
use App\Response\DeliveryCompanyPaymentToRepresentativeCreateResponse;
use App\Response\DeliveryCompanyPaymentToRepresentativeGetResponse;
use App\Service\UserService;

class DeliveryCompanyPaymentToRepresentativeService
{
    private $autoMapping;
    private $deliveryCompanyPaymentToRepresentativeManager;
    private $userService;

    public function __construct(AutoMapping $autoMapping, DeliveryCompanyPaymentToRepresentativeManager $deliveryCompanyPaymentToRepresentativeManager, UserService $userService)
    {
        $this->autoMapping = $autoMapping;
        $this->deliveryCompanyPaymentToRepresentativeManager = $deliveryCompanyPaymentToRepresentativeManager;
        $this->userService = $userService;
    }

    public function createDeliveryCompanyPaymentsToRepresentative($request)
    {
        $item = $this->deliveryCompanyPaymentToRepresentativeManager->createDeliveryCompanyPaymentsToRepresentative($request);

        return $this->autoMapping->map(DeliveryCompanyPaymentsToRepresentativeEntity::class, DeliveryCompanyPaymentToRepresentativeCreateResponse::class, $item);
    }

    public function getDeliveryCompanyPaymentsToRepresentativeByRepresentativeID($representativeID): ?array
    {
        $response = [];

        $payments = $this->deliveryCompanyPaymentToRepresentativeManager->getDeliveryCompanyPaymentsToRepresentativeByRepresentativeID($representativeID);

        if ($payments) {

            foreach ($payments as $payment) {

                $response[] = $this->autoMapping->map('array', DeliveryCompanyPaymentToRepresentativeGetResponse::class, $payment);
            }
        }

        return $response;
    }

    public function getDeliveryCompanyPaymentsToRepresentativeByRepresentativeIdInSpecificDate($representativeID, $fromDate, $toDate): ?array
    {
        $response = [];

        $payments = $this->deliveryCompanyPaymentToRepresentativeManager->getDeliveryCompanyPaymentsToRepresentativeByRepresentativeIdInSpecificDate($representativeID, $fromDate, $toDate);

        if ($payments) {

            foreach ($payments as $payment) {

                $response[] = $this->autoMapping->map('array', DeliveryCompanyPaymentToRepresentativeGetResponse::class, $payment);
            }
        }

        return $response;
    }

    public function getDeliveryCompanySumPaymentsToRepresentative($representativeID)
    {
        return $this->deliveryCompanyPaymentToRepresentativeManager->getDeliveryCompanySumPaymentsToRepresentative($representativeID);
    }

    public function getDeliveryCompanySumPaymentsToRepresentativeInSpecificDate($representativeID, $fromDate, $toDate)
    {
        return $this->deliveryCompanyPaymentToRepresentativeManager->getDeliveryCompanySumPaymentsToRepresentativeInSpecificDate($representativeID, $fromDate, $toDate);
    }

    public function deletePaymentToRepresentative($id)
    {
        return $this->deliveryCompanyPaymentToRepresentativeManager->deletePaymentToRepresentative($id);
    }
}
