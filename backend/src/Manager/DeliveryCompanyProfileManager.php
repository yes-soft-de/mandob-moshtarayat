<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\DeliveryCompanyProfileEntity;
use App\Repository\DeliveryCompanyProfileEntityRepository;
use App\Request\DeliveryCompanyInfoRequest;
use App\Request\DeliveryCompanyInfoUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;


class DeliveryCompanyProfileManager
{
    private $autoMapping;
    private $entityManager;
    private $deliveryCompanyProfileEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, DeliveryCompanyProfileEntityRepository $deliveryCompanyProfileEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->deliveryCompanyProfileEntityRepository = $deliveryCompanyProfileEntityRepository;
    }

    public function createDeliveryCompanyInfo(DeliveryCompanyInfoRequest $request)
    {
       $isfound = $this->getcompanyinfoAll();
        if ($isfound == null) {
        $entity = $this->autoMapping->map(DeliveryCompanyInfoRequest::class, DeliveryCompanyProfileEntity::class, $request);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
        }
        else {
            return true;
        }
    }

    public function updateCompanyInfo(DeliveryCompanyInfoRequest $request)
    {
        // $entity = $this->deliveryCompanyProfileEntityRepository->find($request->getId());
        $profile = $this->getcompanyinfoAll();
        $entity = $this->deliveryCompanyProfileEntityRepository->find($profile[0]['id']);
        if (!$entity) {
            return null;
        }
        $entity = $this->autoMapping->mapToObject(DeliveryCompanyInfoRequest::class, DeliveryCompanyProfileEntity::class, $request, $entity);

        $this->entityManager->flush();

        return $entity;
    } 

    public function getcompanyinfoById($id)
    {
        return $this->deliveryCompanyProfileEntityRepository->getcompanyinfoById($id);
    }

    public function getcompanyinfoAll()
    {
       return $this->deliveryCompanyProfileEntityRepository->getcompanyinfoAll();
    }

    public function getAllCompanyInfoForStoreOwner($userId)
    {
       return $this->deliveryCompanyProfileEntityRepository->getAllCompanyInfoForStoreOwner($userId);
    }

    public function getAllCompanyInfoForCaptain($userId)
    {
       return $this->deliveryCompanyProfileEntityRepository->getAllCompanyInfoForCaptain($userId);
    }
}
