<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\RepresentativeStoreLinkEntity;
use App\Manager\RepresentativeStoreLinkManager;
use App\Request\RepresentativeDueCreateRequest;
use App\Request\RepresentativeStoreLinkCreateRequest;
use App\Request\RepresentativeStoreLinkUpdateRequest;
use App\Response\RepresentativeStoreLinkCreateResponse;
use App\Response\RepresentativeStoreLinkGetByStoreIPResponse;
use App\Response\RepresentativeStoreLinkUpdateResponse;

class RepresentativeStoreLinkService
{
    private $autoMapping;
    private $representativeStoreLinkManager;
    private $representativeDueService;

    public function __construct(AutoMapping $autoMapping, RepresentativeStoreLinkManager $representativeStoreLinkManager, RepresentativeDueService $representativeDueService)
    {
        $this->autoMapping = $autoMapping;
        $this->representativeStoreLinkManager = $representativeStoreLinkManager;
        $this->representativeDueService = $representativeDueService;
    }

    public function createRepresentativeStoreLink(RepresentativeStoreLinkCreateRequest $request)
    {
        $request->setStoreOwnerIP(str_replace(array(":", "."), "", $_SERVER['REMOTE_ADDR']));

        // first, check if there is a previous link of the same (storeOwnerIP - representativeUserID) and linkStatus = notLinked
        $result = $this->representativeStoreLinkManager->getNotLinkedRepresentativeStoreLinkByStoreOwnerIpAndRepresentativeUserID($request->getStoreOwnerIP(), $request->getRepresentativeUserID());

        if (!$result) {

            $result = $this->representativeStoreLinkManager->createRepresentativeStoreLink($request);

            return $this->autoMapping->map(RepresentativeStoreLinkEntity::class, RepresentativeStoreLinkCreateResponse::class, $result);
        }
    }

    public function getRepresentativeStoreLinkByStoreOwnerIP($storeOwnerIP)
    {
        $representativeStoreLinkResult = $this->representativeStoreLinkManager->getRepresentativeStoreLinkByStoreOwnerIP($storeOwnerIP);

        return $this->autoMapping->map('array', RepresentativeStoreLinkGetByStoreIPResponse::class, $representativeStoreLinkResult);
    }

    public function updateRepresentativeStoreLink(RepresentativeStoreLinkUpdateRequest $request)
    {
        $representativeStoreLinkResult = $this->representativeStoreLinkManager->updateRepresentativeStoreLink($request);

        if ($representativeStoreLinkResult === 'noLinkFound') {

            return 'noLinkFound';

        } else {

            // then, insert due for the representative for linking the store
            $this->createDueForRepresentative($representativeStoreLinkResult);

            return $this->autoMapping->map(RepresentativeStoreLinkEntity::class, RepresentativeStoreLinkUpdateResponse::class, $representativeStoreLinkResult);
        }
    }

    public function createDueForRepresentative(RepresentativeStoreLinkEntity $representativeStoreLinkEntity)
    {
        $createRepresentativeDueRequest = $this->autoMapping->map(RepresentativeStoreLinkEntity::class, RepresentativeDueCreateRequest::class, $representativeStoreLinkEntity);

        $this->representativeDueService->createRepresentativeDue($createRepresentativeDueRequest);
    }

    public function getCountLinkedStoresByRepresentativeUserID($representativeUserID)
    {
        return $this->representativeStoreLinkManager->getCountLinkedStoresByRepresentativeUserID($representativeUserID);
    }

    public function getCountLinkedStoresByRepresentativeUserIdAndInSpecificDate($representativeUserID, $fromDate, $toDate)
    {
        return $this->representativeStoreLinkManager->getCountLinkedStoresByRepresentativeUserIdAndInSpecificDate($representativeUserID, $fromDate, $toDate);
    }

    public function getCountLinkedStores()
    {
        return $this->representativeStoreLinkManager->getCountLinkedStores();
    }
}
