<?php

namespace App\Request;

class StoreOwnerBranchUpdateRequest
{
    private $id;
   
    private $location = [];

    private $city;

    /**
     * @return array
     */
    public function getLocation(): array
    {
        return $this->location;
    }

    /**
     * @param array $location
     */
    public function setLocation(array $location): void
    {
        $this->location = $location;
    }

    /**
     * @return mixed
     */
    public function getBranchName()
    {
        return $this->branchName;
    }

    /**
     * @param mixed $branchName
     */
    public function setBranchName($branchName): void
    {
        $this->branchName = $branchName;
    }
   
    private $branchName;
      
    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }
}
