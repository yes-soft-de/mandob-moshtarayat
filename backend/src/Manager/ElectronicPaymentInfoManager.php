<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\ElectronicPaymentInfoEntity;
use App\Request\ElectronicPaymentInfoCreateRequest;
use App\Request\OrderUpdateByOrderNumberRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Repository\ElectronicPaymentInfoEntityRepository;
use App\Manager\OrderManager;

class ElectronicPaymentInfoManager
{
    private $autoMapping;
    private $entityManager;
    private $electronicPaymentInfoEntityRepository;
    private $orderManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, ElectronicPaymentInfoEntityRepository $electronicPaymentInfoEntityRepository, OrderManager $orderManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->electronicPaymentInfoEntityRepository = $electronicPaymentInfoEntityRepository;
        $this->orderManager = $orderManager;
    }

    public function updateInfoPay(ElectronicPaymentInfoCreateRequest $request, $item)
    {
        $item = $this->autoMapping->mapToObject(ElectronicPaymentInfoCreateRequest::class, ElectronicPaymentInfoEntity::class, $request, $item);

        $this->entityManager->flush();
        $item->methods = "update";

        $this->orderUpdate($request->getOrderNumber(), $request->getPayStatus());

        return $item;

    }
    public function createInfoPay(ElectronicPaymentInfoCreateRequest $request)
    {
        $item = $this->autoMapping->map(ElectronicPaymentInfoCreateRequest::class, ElectronicPaymentInfoEntity::class, $request);

        $this->entityManager->persist($item);
        $this->entityManager->flush();

        $this->orderUpdate($request->getOrderNumber(), $request->getPayStatus());

        $item->methods = "create";

        return $item;
    }

    public function orderUpdate($orderNumber, $state)
    {
        $orderUpdate = new OrderUpdateByOrderNumberRequest();
        $orderUpdate->setOrderNumber($orderNumber);
        $orderUpdate->setState($state);

        return $this->orderManager->orderStateUpdateByPayInfo($orderUpdate);
    }

    public function addInfoPay(ElectronicPaymentInfoCreateRequest $request)
    {
        $item = $this->electronicPaymentInfoEntityRepository->findOneBy(['orderNumber' => $request->getOrderNumber()]);

        if ($item) {
           return $this->updateInfoPay($request, $item);
        }

        return $this->createInfoPay($request);
    }
}