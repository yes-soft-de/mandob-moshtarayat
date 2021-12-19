<?php

namespace App\Request;

class OrderUpdateStateByOrderStateRequest
{
    private $id;

    private $state;

    private $captainID;

    /**
     * Get the value of id
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set the value of id
     *
     * @return  self
     */
    public function setId($id)
    {
        $this->id = $id;

        return $this;
    }

    /**
     * @return mixed
     */
    public function getState()
    {
        return $this->state;
    }

    /**
     * @param mixed $state
     */
    public function setState($state): void
    {
        $this->state = $state;
    }

    public function setCaptainID($captainID): void
    {
        $this->captainID = $captainID;
    }

    public function getCaptainID()
    {
        return $this->captainID;
    }
}