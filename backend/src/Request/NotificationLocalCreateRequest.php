<?php


namespace App\Request;


class NotificationLocalCreateRequest
{
    private $title;

    private $userID;

    private $message;

    private $orderNumber;

    private $createdAt;


    public function setTitle($title): void
    {
        $this->title = $title;
    }

    public function getUserID()
    {
        return $this->userID;
    }

    public function setUserID($userID): void
    {
        $this->userID = $userID;
    }

    public function setMessage($message): void
    {
        $this->message = $message;
    }

    public function setOrderNumber($orderNumber)
    {
        $this->orderNumber = $orderNumber;
    }
}
