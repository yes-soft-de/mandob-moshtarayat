<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\RepresentativeDueEntity;
use App\Manager\RepresentativeDueManager;
use App\Request\RepresentativeDueCreateRequest;
use App\Response\RepresentativeDueCreateResponse;

class RepresentativeDueService
{
    private $autoMapping;
    private $representativeDueManager;

    public function __construct(AutoMapping $autoMapping, RepresentativeDueManager $representativeDueManager)
    {
        $this->autoMapping = $autoMapping;
        $this->representativeDueManager = $representativeDueManager;
    }

    public function createRepresentativeDue(RepresentativeDueCreateRequest $request)
    {
        $representativeDueEntity = $this->representativeDueManager->createRepresentativeDue($request);

        return $this->autoMapping->map(RepresentativeDueEntity::class, RepresentativeDueCreateResponse::class, $representativeDueEntity);
    }

    public function getSumRepresentativeDueByRepresentativeUserID($representativeUserID)
    {
        return $this->representativeDueManager->getSumRepresentativeDueByRepresentativeUserID($representativeUserID);
    }
}
