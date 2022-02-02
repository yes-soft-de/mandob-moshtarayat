<?php

namespace App\Request;

class AppointmentUpdateIsDoneRequest
{
    private $id;

    private $isDone;

      /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * @param mixed $id
     */
    public function setId($id): void
    {
        $this->id = $id;
    }
}
