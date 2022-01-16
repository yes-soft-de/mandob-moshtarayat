<?php

namespace App\Manager;

use App\AutoMapping;
use App\Constant\RepresentativeStoreLinkTypeConstant;
use App\Entity\RepresentativeStoreLinkEntity;
use App\Request\RepresentativeStoreLinkCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class RepresentativeStoreLinkManager
{
    private $autoMapping;
    private $entityManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
    }

    public function createRepresentativeStoreLink(RepresentativeStoreLinkCreateRequest $request)
    {
        $representativeStoreLinkEntity = $this->autoMapping->map(RepresentativeStoreLinkCreateRequest::class, RepresentativeStoreLinkEntity::class, $request);

        $representativeStoreLinkEntity->setLinkStatus(RepresentativeStoreLinkTypeConstant::$REPRESENTATIVE_STORE_NOT_LINKED);

        $this->entityManager->persist($representativeStoreLinkEntity);
        $this->entityManager->flush();

        return $representativeStoreLinkEntity;
    }
}
