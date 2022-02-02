<?php

namespace App\Request;

class MandobProfileUpdateRequest
{
    private $userID;

    private $mandobName;

    private $image;

    private $age;

    private $phone;

    private $bankName;

    private $bankAccountNumber;

    private $stcPay;

    /**
     * Get the value of mandobName
     */
    public function getMandobName()
    {
        return $this->mandobName;
    }

    /**
     * Set the value of captainName
     *
     * @return  self
     */
    public function setMandobName($mandobName)
    {
        $this->mandobName = $mandobName;

        return $this;
    }

    /**
     * Get the value of image
     */
    public function getImage()
    {
        return $this->image;
    }

    /**
     * Set the value of image
     *
     * @return  self
     */
    public function setImage($image)
    {
        $this->image = $image;

        return $this;
    }

    /**
     * Get the value of age
     */
    public function getAge()
    {
        return $this->age;
    }

    /**
     * Set the value of age
     *
     * @return  self
     */
    public function setAge($age)
    {
        $this->age = $age;

        return $this;
    }

    /**
     * Get the value of userID
     */
    public function getUserID()
    {
        return $this->userID;
    }

    /**
     * Set the value of userID
     *
     * @return  self
     */
    public function setUserID($userID)
    {
        $this->userID = $userID;

        return $this;
    }
}