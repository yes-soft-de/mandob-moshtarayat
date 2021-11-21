<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\UserEntity;
use App\Request\AdminCreateRequest;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;
use App\Manager\UserManager;


class AdminManager
{
    private $autoMapping;
    private $entityManager;
    private $encoder;
    private $userManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, UserPasswordEncoderInterface $encoder,UserManager $userManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->encoder = $encoder;
        $this->userManager = $userManager;
    }

    public function createAdmin(AdminCreateRequest $request)
    {
        $createAdmin = $this->autoMapping->map(AdminCreateRequest::class, UserEntity::class, $request);

        $user = new UserEntity($request->getUserID());

        if ($request->getPassword()) {
               $createAdmin->setPassword($this->encoder->encodePassword($user, $request->getPassword()));
        }

        $createAdmin->setCreateDate(new \DateTime('now'));

        if ($request->getRoles() == null) {
              $request->setRoles(['ROLE_ADMIN']);
         }
        $createAdmin->setRoles($request->getRoles());

        $this->entityManager->persist($createAdmin);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $createAdmin;
    }

    public function getUserByUserID($userID)
    {
        return $this->userManager->getUserByUserID($userID);
    }
}
