<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\RoomIdHelperEntity;
use App\Manager\RoomIdHelperManager;
use App\Response\RoomIdHelperResponse;

class RoomIdHelperService
{
    private $autoMapping;
    private $roomIdHelperManager;

    public function __construct(AutoMapping $autoMapping, RoomIdHelperManager $roomIdHelperManager)
    {
        $this->autoMapping = $autoMapping;
        $this->roomIdHelperManager = $roomIdHelperManager;
    }

    public function createRoomIdHelper($request)
    {   
        $item = $this->roomIdHelperManager->createRoomIdHelper($request);
        return $this->autoMapping->map(RoomIdHelperEntity::class, RoomIdHelperResponse::class, $item);
    }

    public function getByRoomID($roomID)
    {
        return $this->roomIdHelperManager->getByRoomID($roomID);
    }

    public function roomIdGenerate()
    {
       $data = random_bytes(16);

       $data[0] = chr(ord('c') ); 
       $data[1] = chr(ord('4') ); 
       $data[2] = chr(ord('d') ); 
       $data[6] = chr(ord($data[6]) & 0x0f | 0x40);
       $data[8] = chr(ord($data[8]) & 0x3f | 0x80);
       return  vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex($data), 4));
   }
}