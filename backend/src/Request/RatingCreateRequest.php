<?php

namespace App\Request;

class RatingCreateRequest
{
    private $itemID;

    private $itemType; //captain or client or product or store
    
    private $rating; // 1 - 2 - 3 - 4 - 5
    
    private $userID;
    
    private $orderNumber;
    
    private $userType; // Who is the user who rating? if store send (store). For fear of conflict because we rely on the store profile id
 
    
    public function getItemID()
    {
        return $this->itemID;
    }

    public function setItemID($itemID)
    {
        $this->itemID = $itemID;

        return $this;
    }

    public function getItemType()
    {
        return $this->itemType;
    }

    public function setItemType($itemType)
    {
        $this->itemType = $itemType;

        return $this;
    }

    public function getRating()
    {
        return $this->rating;
    }

    public function setRating($rating)
    {
        $this->rating = $rating;

        return $this;
    }

    public function getUserID()
    {
        return $this->userID;
    }

    public function setUserID($userID)
    {
        $this->userID = $userID;

        return $this;
    }
 
    public function getOrderNumber()
    {
        return $this->orderNumber;
    }

    public function setOrderNumber($orderNumber)
    {
        $this->orderNumber = $orderNumber;

        return $this;
    }

    public function getUserType()
    {
        return $this->userType;
    }

    public function setUserType($userType)
    {
        $this->userType = $userType;

        return $this;
    }
}
