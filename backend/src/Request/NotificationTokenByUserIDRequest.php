<?php

namespace App\Request;

class NotificationTokenByUserIDRequest
{
    private $otherUserID;

    /**
     * @return mixed
     */
    public function getOtherUserID()
    {
        return $this->otherUserID;
    }

    /**
     * @param mixed $otherUserID
     */
    public function setOtherUserID($otherUserID): void
    {
        $this->otherUserID = $otherUserID;
    }

}