<?php

namespace App\Request;

class NotificationTokenByUserIDRequest
{
    private $otherUserID;

    private $chatRoomID;

    private $userID;


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

    /**
     * @return mixed
     */
    public function getChatRoomID()
    {
        return $this->chatRoomID;
    }

    /**
     * @param mixed $chatRoomID
     */
    public function setChatRoomID($chatRoomID): void
    {
        $this->chatRoomID = $chatRoomID;
    }

    /**
     * @return mixed
     */
    public function getUserID()
    {
        return $this->userID;
    }

    /**
     * @param mixed $userID
     */
    public function setUserID($userID): void
    {
        $this->userID = $userID;
    }
}