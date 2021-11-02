<?php

namespace App\Service;

use App\Manager\OrderManager;

class CaptainService
{
    private $orderManager;

    public function __construct(OrderManager $orderManager)
    {
        $this->orderManager = $orderManager;
    }

    public function countCaptainOrdersDelivered($captainId)
    {
        return $this->orderManager->countCaptainOrdersDelivered($captainId);
    }

 public function sumInvoiceAmountWithoutOrderTypeSendIt($captainId)
    {
        return $this->orderManager->sumInvoiceAmountWithoutOrderTypeSendIt($captainId);
    }

    public function sumFinancialAmount()
    {
        return $this->orderManager->sumFinancialAmount();
    }

    public function captainOrdersDelivered($captainId)
    {
        return $this->orderManager->captainOrdersDelivered($captainId);
    }

    public function countOrdersInMonthForCaptain($fromDate, $toDate, $captainId)
    {
        return $this->orderManager->countOrdersInMonthForCaptain($fromDate, $toDate, $captainId);
    }

    public function sumInvoiceAmountWithoutOrderTypeSendItInMonthForCaptain($fromDate, $toDate, $captainId)
    {
        return $this->orderManager->sumInvoiceAmountWithoutOrderTypeSendItInMonthForCaptain($fromDate, $toDate, $captainId);
    }

    public function getAcceptedOrderByCaptainIdInMonth($fromDate, $toDate, $captainId)
    {
        return $this->orderManager->getAcceptedOrderByCaptainIdInMonth($fromDate, $toDate, $captainId);
    }

    public function countCaptainOrdersInDay($captainID, $fromDate, $toDate)
    {
        return $this->orderManager->countCaptainOrdersInDay($captainID, $fromDate, $toDate);
    }

    public function countOrdersDeliveredInToday($captainID, $todayStart, $todayEnd)
    {
        return $this->orderManager->countOrdersDeliveredInToday($captainID, $todayStart, $todayEnd);
    }

    public function getOrderKilometers($captainId)
    {
        return $this->orderManager->getOrderKilometers($captainId);
    }

    public function getOrderKilometersInThisMonth($captainId, $fromDate, $toDate)
    {
        return $this->orderManager->getOrderKilometersInThisMonth($captainId, $fromDate, $toDate);
    }
}
