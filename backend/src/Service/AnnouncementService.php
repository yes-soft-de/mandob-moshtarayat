<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\AnnouncementEntity;
use App\Manager\AnnouncementManager;
use App\Request\AnnouncementCreateRequest;
use App\Response\AnnouncementResponse;

class AnnouncementService
{
    private $autoMapping;
    private $announcementManager;

    public function __construct(AutoMapping $autoMapping, AnnouncementManager $announcementManager)
    {
        $this->autoMapping = $autoMapping;
        $this->announcementManager = $announcementManager;
    }

    public function createAnnouncement(AnnouncementCreateRequest $request):object
    {
        $item = $this->announcementManager->createAnnouncement($request);

        return $this->autoMapping->map(AnnouncementEntity::class, AnnouncementResponse::class, $item);
    }

    public function updateAnnouncement($request):object
    {
        $result = $this->announcementManager->updateAnnouncement($request);

        return $this->autoMapping->map(AnnouncementEntity::class, AnnouncementResponse::class, $result);
    }

    public function  getAnnouncementById($id):object
    {
        $result = $this->announcementManager->getAnnouncementById($id);
        return $this->autoMapping->map(AnnouncementEntity::class, AnnouncementResponse::class, $result);
  
    }

    public function  getAnnouncements():array
    {
        $response=[];
        $results = $this->announcementManager->getAnnouncements();
       
        foreach ($results as  $result) {
           $response[]= $this->autoMapping->map('array', AnnouncementResponse::class, $result);
        }
        return $response;
       
    }
}
