<?php

namespace App\Request;

class SupportCreateRequest
{
    private $userId;
  
    private $orderId;
  
    private $reason;
  
    private $roomID;
      
    /**
    * @param mixed $userId
    */
    public function setUserId($userId): void
    {
        $this->userId = $userId;
    }

    /**
    * @return mixed
    */
    public function getUserId()
    {
        return $this->userId;
    }

    /**
     * Get the value of roomID
     */ 
    public function getRoomID()
    {
        return $this->roomID;
    }

    /**
     * Set the value of roomID
     *
     * @return  self
     */ 
    public function setRoomID($roomID)
    {
        $this->roomID = $roomID;

        return $this;
    }
}
