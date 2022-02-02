<?php


namespace App\Request;


class SendNotificationRequest
{
    private $firstUserToken;

    private $secondUserToken;

    private $message;

    private $orderNumber;

    /**
     * @return mixed
     */
    public function getMessage()
    {
        return $this->message;
    }

    /**
     * @param mixed $message
     */
    public function setMessage($message): void
    {
        $this->message = $message;
    }

    /**
     * @return mixed
     */
    public function getFirstUserToken()
    {
        return $this->firstUserToken;
    }

    /**
     * @param mixed $firstUserToken
     */
    public function setFirstUserToken($firstUserToken): void
    {
        $this->firstUserToken = $firstUserToken;
    }

    /**
     * @return mixed
     */
    public function getSecondUserToken()
    {
        return $this->secondUserToken;
    }

    /**
     * @param mixed $secondUserToken
     */
    public function setSecondUserToken($secondUserToken): void
    {
        $this->secondUserToken = $secondUserToken;
    }

    /**
     * @return mixed
     */
    public function getOrderNumber()
    {
        return $this->orderNumber;
    }

    /**
     * @param mixed $orderNumber
     */
    public function setOrderNumber($orderNumber): void
    {
        $this->orderNumber = $orderNumber;
    }
}