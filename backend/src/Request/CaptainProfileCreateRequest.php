<?php

namespace App\Request;

class CaptainProfileCreateRequest
{
    private $captainID;

    private $captainName;

    private $image;

    private $location;

    private $age;

    private $car;

    private $drivingLicence;

    private $status;

    private $roomID;
    
    private $specialLink;
    
    private $phone;

    private $userID;

    private $bankName;

    private $accountID;
    
    private $stcPay;

    private $mechanicLicense;

    private $identity;

    /**
     * Get the value of captainID
     */
    public function getCaptainID()
    {
        return $this->captainID;
    }

    /**
     * Set the value of captainID
     *
     * @return  self
     */
    public function setCaptainID($captainID)
    {
        $this->captainID = $captainID;

        return $this;
    }

    /**
     * Get the value of captainName
     */
    public function getCaptainName()
    {
        return $this->captainName;
    }

    /**
     * Set the value of captainName
     *
     * @return  self
     */
    public function setCaptainName($captainName)
    {
        $this->captainName = $captainName;

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
     * Get the value of location
     */
    public function getLocation()
    {
        return $this->location;
    }

    /**
     * Set the value of location
     *
     * @return  self
     */
    public function setLocation($location)
    {
        $this->location = $location;

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
     * Get the value of car
     */
    public function getCar()
    {
        return $this->car;
    }

    /**
     * Set the value of car
     *
     * @return  self
     */
    public function setCar($car)
    {
        $this->car = $car;

        return $this;
    }

    /**
     * Get the value of drivingLicence
     */
    public function getDrivingLicence()
    {
        return $this->drivingLicence;
    }

    /**
     * Set the value of drivingLicence
     *
     * @return  self
     */
    public function setDrivingLicence($drivingLicence)
    {
        $this->drivingLicence = $drivingLicence;

        return $this;
    }

     /**
     * Get the value of status
     */
    public function getStatus(): ?string
    {
        return $this->status;
    }

     /**
     * Set the value of status
     *
     * @return  self
     */
    public function setStatus(string $status): self
    {
        $this->status = $status;

        return $this;
    }
    
    public function getRoomID(): ?string
    {
        return $this->roomID;
    }

    public function setRoomID(?string $roomID): self
    {
        $this->roomID = $roomID;

        return $this;
    }

    /**
     * Get the value of phone
     */ 
    public function getPhone()
    {
        return $this->phone;
    }

    /**
     * Set the value of phone
     *
     * @return  self
     */ 
    public function setPhone($phone)
    {
        $this->phone = $phone;

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

    /**
     * Get the value of bankName
     */ 
    public function getBankName()
    {
        return $this->bankName;
    }

    /**
     * Set the value of bankName
     *
     * @return  self
     */ 
    public function setBankName($bankName)
    {
        $this->bankName = $bankName;

        return $this;
    }

    /**
     * Get the value of accountID
     */ 
    public function getAccountID()
    {
        return $this->accountID;
    }

    /**
     * Set the value of accountID
     *
     * @return  self
     */ 
    public function setAccountID($accountID)
    {
        $this->accountID = $accountID;

        return $this;
    }

    /**
     * Get the value of stcPay
     */ 
    public function getStcPay()
    {
        return $this->stcPay;
    }

    /**
     * Set the value of stcPay
     *
     * @return  self
     */ 
    public function setStcPay($stcPay)
    {
        $this->stcPay = $stcPay;

        return $this;
    }
     /**
     * Get the value of mechanicLicense
     */ 
    public function getMechanicLicense()
    {
        return $this->mechanicLicense;
    }

    /**
     * Set the value of mechanicLicense
     *
     * @return  self
     */ 
    public function setMechanicLicense($mechanicLicense)
    {
        $this->mechanicLicense = $mechanicLicense;

        return $this;
    }

    /**
     * Get the value of identity
     */ 
    public function getIdentity()
    {
        return $this->identity;
    }

    /**
     * Set the value of identity
     *
     * @return  self
     */ 
    public function setIdentity($identity)
    {
        $this->identity = $identity;

        return $this;
    }
}
