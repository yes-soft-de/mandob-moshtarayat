<?php

namespace App\Entity;

use App\Repository\StaffProfileEntityRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=StaffProfileEntityRepository::class)
 */
class StaffProfileEntity
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $roomID;

    /**
     * @ORM\Column(type="integer", length=255, nullable=true)
     */
    private $adminID;

    public function getId(): ?int
    {
        return $this->id;
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

    public function getAdminID(): ?string
    {
        return $this->adminID;
    }

    public function setAdminID(?string $adminID): self
    {
        $this->adminID = $adminID;

        return $this;
    }


}
