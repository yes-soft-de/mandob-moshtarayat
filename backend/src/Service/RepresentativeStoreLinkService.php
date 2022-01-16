<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\RepresentativeStoreLinkEntity;
use App\Manager\RepresentativeStoreLinkManager;
use App\Request\RepresentativeStoreLinkCreateRequest;
use App\Response\RepresentativeStoreLinkCreateResponse;

class RepresentativeStoreLinkService
{
    private $autoMapping;
    private $representativeStoreLinkManager;

    public function __construct(AutoMapping $autoMapping, RepresentativeStoreLinkManager $representativeStoreLinkManager)
    {
        $this->autoMapping = $autoMapping;
        $this->representativeStoreLinkManager = $representativeStoreLinkManager;
    }

    public function createRepresentativeStoreLink(RepresentativeStoreLinkCreateRequest $request)
    {
        $result = $this->representativeStoreLinkManager->createRepresentativeStoreLink($request);

        return $this->autoMapping->map(RepresentativeStoreLinkEntity::class, RepresentativeStoreLinkCreateResponse::class, $result);
    }
}
