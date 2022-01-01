<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\ElectronicPaymentInfoEntity;
use App\Request\ElectronicPaymentInfoCreateRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Repository\ElectronicPaymentInfoEntityRepository;

class ElectronicPaymentInfoManager
{
    private $autoMapping;
    private $entityManager;
    private $electronicPaymentInfoEntityRepository;


    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, ElectronicPaymentInfoEntityRepository $electronicPaymentInfoEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->electronicPaymentInfoEntityRepository = $electronicPaymentInfoEntityRepository;
    }

    public function updateInfoPay(ElectronicPaymentInfoCreateRequest $request, $item)
    {
        $item = $this->autoMapping->mapToObject(ElectronicPaymentInfoCreateRequest::class, ElectronicPaymentInfoEntity::class, $request, $item);

        $this->entityManager->flush();
        $item->methods = "update";

        return $item;

    }

    public function createInfoPay(ElectronicPaymentInfoCreateRequest $request)
    {
        $item = $this->autoMapping->map(ElectronicPaymentInfoCreateRequest::class, ElectronicPaymentInfoEntity::class, $request);

        $this->entityManager->persist($item);
        $this->entityManager->flush();

        $item->methods = "create";

        return $item;
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