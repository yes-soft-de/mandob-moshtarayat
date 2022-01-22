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
//        return $this->ordersInvoicesManager->getInvoicesByOrderNumber($orderNumber);
        $invoice =  $this->ordersInvoicesManager->getInvoicesByOrderNumber($orderNumber);

        $invoice[0]['invoiceAmount'] =  round($invoice[0]['invoiceAmount'], 1);

        return $invoice;
    }

    public function sumInvoiceAmountWithoutOrderTypeSendIt($invoicesIDs)
    {
        return $this->ordersInvoicesManager->sumInvoiceAmountWithoutOrderTypeSendIt($invoicesIDs);
    }

}