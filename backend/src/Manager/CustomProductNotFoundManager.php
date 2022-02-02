<?php

namespace App\Manager;
use App\AutoMapping;
use App\Entity\CustomProductNotFoundEntity;
use App\Repository\CustomProductNotFoundEntityRepository;
use App\Request\CustomProductNotFoundCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class CustomProductNotFoundManager
{
    private $autoMapping;
    private $entityManager;
    private $customProductNotFoundEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, CustomProductNotFoundEntityRepository $customProductNotFoundEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->customProductNotFoundEntityRepository = $customProductNotFoundEntityRepository;
    }

    public function createCustomProductNotFound(CustomProductNotFoundCreateRequest $request)
    {
        $entity = $this->autoMapping->map(CustomProductNotFoundCreateRequest::class, CustomProductNotFoundEntity::class, $request);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();

        return $entity;
    }

    public function getCustomProductsNotFound(): array
    {
        return $this->customProductNotFoundEntityRepository->getCustomProductsNotFound();
    }

    public function getCustomProductNotFound($id)
    {
//        return $this->customProductNotFoundEntityRepository->find($id);
        return $this->customProductNotFoundEntityRepository->getCustomProductNotFound($id);

    }

}