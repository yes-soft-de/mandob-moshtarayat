<?php


namespace App\Manager;

use App\AutoMapping;
use App\Entity\OrdersInvoicesEntity;
use App\Request\OrderUpdateInvoiceByCaptainRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Repository\OrdersInvoicesEntityRepository;
use Petstore30\Order;

class OrdersInvoicesManager
{
    private $autoMapping;
    private $entityManager;
    private $ordersInvoicesEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, OrdersInvoicesEntityRepository $ordersInvoicesEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->ordersInvoicesEntityRepository = $ordersInvoicesEntityRepository;
    }

    public function getInvoicesByOrderNumber($orderNumber)
    {
       return $this->ordersInvoicesEntityRepository->getInvoicesByOrderNumber($orderNumber);
    }

    public function sumInvoiceAmountWithoutOrderTypeSendIt($invoicesIDs)
    {
       return $this->ordersInvoicesEntityRepository->sumInvoiceAmountWithoutOrderTypeSendIt($invoicesIDs);
    }

    public function orderUpdateInvoiceByCaptain(OrderUpdateInvoiceByCaptainRequest $request)
    {
        $item = $this->autoMapping->map(OrderUpdateInvoiceByCaptainRequest::class, OrdersInvoicesEntity::class, $request);

        $this->entityManager->persist($item);
        $this->entityManager->flush();

        return $item;
    }

}