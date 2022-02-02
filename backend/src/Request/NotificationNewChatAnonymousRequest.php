<?php

namespace App\Request;

class NotificationNewChatAnonymousRequest
{
    private $anonymousChatID;

    /**
     * @return mixed
     */
    public function getAnonymousChatID()
    {
        return $this->anonymousChatID;
    }

    /**
     * @param mixed $anonymousChatID
     */
    public function setAnonymousChatID($anonymousChatID): void
    {
        $this->anonymousChatID = $anonymousChatID;
    }
}