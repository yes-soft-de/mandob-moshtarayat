<?php

namespace App\Manager;

use App\AutoMapping;
use App\Constant\RepresentativeStoreLinkTypeConstant;
use App\Entity\RepresentativeStoreLinkEntity;
use App\Repository\RepresentativeStoreLinkEntityRepository;
use App\Request\RepresentativeStoreLinkCreateRequest;
use App\Request\RepresentativeStoreLinkUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;

class RepresentativeStoreLinkManager
{
    private $autoMapping;
    private $entityManager;
    private $representativeStoreLinkEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, RepresentativeStoreLinkEntityRepository $representativeStoreLinkEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->representativeStoreLinkEntityRepository = $representativeStoreLinkEntityRepository;
    }

    public function createRepresentativeStoreLink(RepresentativeStoreLinkCreateRequest $request)
    {
        $representativeStoreLinkEntity = $this->autoMapping->map(RepresentativeStoreLinkCreateRequest::class, RepresentativeStoreLinkEntity::class, $request);

        $representativeStoreLinkEntity->setLinkStatus(RepresentativeStoreLinkTypeConstant::$REPRESENTATIVE_STORE_NOT_LINKED);
        $representativeStoreLinkEntity->setStoreOwnerIP(str_replace(array(":", "."), "", $_SERVER['REMOTE_ADDR']));

        $this->entityManager->persist($representativeStoreLinkEntity);
        $this->entityManager->flush();

        return $representativeStoreLinkEntity;
    }

    public function getRepresentativeStoreLinkByStoreOwnerIP($storeOwnerIP): ?array
    {
        return $this->representativeStoreLinkEntityRepository->getRepresentativeStoreLinkByStoreOwnerIP($storeOwnerIP);
    }

    public function updateRepresentativeStoreLink(RepresentativeStoreLinkUpdateRequest $request)
    {
        $representativeStoreLinkResult = $this->representativeStoreLinkEntityRepository->find($request->getId());

        if (!$representativeStoreLinkResult) {

            return 'noLinkFound';

        } else {

            $representativeStoreLinkResult = $this->autoMapping->mapToObject(RepresentativeStoreLinkUpdateRequest::class, RepresentativeStoreLinkEntity::class,
             $request, $representativeStoreLinkResult);

            $this->entityManager->flush();

            return $representativeStoreLinkResult;
        }
    }
}
