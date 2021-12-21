<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\CaptainTermEntity;
use App\Manager\CaptainTermManager;
use App\Request\CaptainTermCreateRequest;
use App\Request\CaptainTermUpdateRequest;
use App\Response\CaptainTermCreateResponse;

class CaptainTermService
{
    private $autoMapping;
    private $captainTermManager;

    public function __construct(AutoMapping $autoMapping, CaptainTermManager $captainTermManager)
    {
        $this->autoMapping = $autoMapping;
        $this->captainTermManager = $captainTermManager;
    }

    public function createCaptainTerm(CaptainTermCreateRequest $request)
    {
        $item = $this->captainTermManager->createCaptainTerm($request);

        return $this->autoMapping->map(CaptainTermEntity::class, captainTermCreateResponse::class, $item);
    }

    public function getTermsCaptain() {
        $response = [];
        $items = $this->captainTermManager->getTermsCaptain();
      
        foreach ($items as $item) {
            $response[] =  $this->autoMapping->map('array', CaptainTermCreateResponse::class, $item);
            }
            return $response;
    }

    public function getTermsCaptainById($id) {
       
        $item = $this->captainTermManager->getTermsCaptainById($id);
        
        return $this->autoMapping->map(CaptainTermEntity::class, CaptainTermCreateResponse::class, $item);
            
    }

    public function update(CaptainTermUpdateRequest $request)
    {
        $item = $this->captainTermManager->update($request);

        return $this->autoMapping->map(CaptainTermEntity::class, CaptainTermCreateResponse::class, $item);
    }
}
