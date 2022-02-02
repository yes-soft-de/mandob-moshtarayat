<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\ClientPaymentEntity;
use App\Repository\ClientPaymentEntityRepository;
use App\Request\ClientPaymentCreateRequest;
use Doctrine\ORM\EntityManagerInterface;
//TODO this class for future
class ClientPaymentManager
{
    private $autoMapping;
    private $entityManager;
    private $clientPaymentEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, ClientPaymentEntityRepository $clientPaymentEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->clientPaymentEntityRepository = $clientPaymentEntityRepository;
    }

    public function createClientPayment(ClientPaymentCreateRequest $request)
    {
        $entity = $this->autoMapping->map(ClientPaymentCreateRequest::class, ClientPaymentEntity::class, $request);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }
}
