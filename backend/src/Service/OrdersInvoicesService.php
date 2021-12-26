<?php

namespace App\Service;
use App\AutoMapping;
use App\Entity\OrdersInvoicesEntity;
use App\Request\OrderUpdateInvoiceByCaptainRequest;
use App\Response\OrderUpdateInvoiceByCaptainResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;
use App\Manager\OrdersInvoicesManager;

class OrdersInvoicesService
{
    private $autoMapping;

    public function __construct(AutoMapping $autoMapping, OrdersInvoicesManager $ordersInvoicesManager)
    {
        $this->autoMapping = $autoMapping;
        $this->ordersInvoicesManager = $ordersInvoicesManager;
    }

    public function orderUpdateInvoiceByCaptain(OrderUpdateInvoiceByCaptainRequest $request)
    {
        $item = $this->ordersInvoicesManager->orderUpdateInvoiceByCaptain($request);

        return $this->autoMapping->map(OrdersInvoicesEntity::class, OrderUpdateInvoiceByCaptainResponse::class, $item);
    }

    public function getInvoicesByOrderNumber($orderNumber)
    {
        return $this->ordersInvoicesManager->getInvoicesByOrderNumber($orderNumber);
    }

    public function sumInvoiceAmountWithoutOrderTypeSendIt($invoicesIDs)
    {
        return $this->ordersInvoicesManager->sumInvoiceAmountWithoutOrderTypeSendIt($invoicesIDs);
    }

}