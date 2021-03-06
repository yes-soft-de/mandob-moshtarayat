<?php

namespace App\Repository;

use App\Entity\StoreOwnerProfileEntity;
use App\Entity\UserEntity;
use App\Request\FilterUserRequest;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Component\Security\Core\Exception\UnsupportedUserException;
use Symfony\Component\Security\Core\User\PasswordUpgraderInterface;
use Symfony\Component\Security\Core\User\UserInterface;

/**
 * @method UserEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method UserEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method UserEntity[]    findAll()
 * @method UserEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class UserEntityRepository extends ServiceEntityRepository implements PasswordUpgraderInterface
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, UserEntity::class);
    }

    /**
     * Used to upgrade (rehash) the user's password automatically over time.
     */
    public function upgradePassword(UserInterface $user, string $newEncodedPassword): void
    {
        if (!$user instanceof UserEntity) {
            throw new UnsupportedUserException(sprintf('Instances of "%s" are not supported.', \get_class($user)));
        }

        $user->setPassword($newEncodedPassword);
        $this->_em->persist($user);
        $this->_em->flush();
    }

    public function getUserByUserID($userID)
    {
        return $this->createQueryBuilder('user')

            ->select('user.id', 'user.userID', 'user.email')

            ->andWhere('user.userID = :userID')

            ->setParameter('userID', $userID)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getUserByUserIdAndRole($userID, $role)
    {
        return $this->createQueryBuilder('userEntity')
            ->select('userEntity.id', 'userEntity.userID', 'userEntity.email')

            ->andWhere('userEntity.userID = :userID')
            ->setParameter('userID', $userID)

            ->andWhere('userEntity.roles LIKE :roles')
            ->setParameter('roles', '%"'.$role.'"%')

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getStoreProfileId($userID)
    {
        return $this->createQueryBuilder('user')

            ->select('StoreOwnerProfileEntity.id')

            ->leftJoin(StoreOwnerProfileEntity::class, 'StoreOwnerProfileEntity', Join::WITH,
                'StoreOwnerProfileEntity.storeOwnerID =:userID')

            ->andWhere('user.id=:userID')

            ->setParameter('userID', $userID)

            ->getQuery()
            ->getOneOrNullResult();
    }

    // return user entity
    public function getUserEntityByUserID($userID)
    {
        return $this->createQueryBuilder('userEntity')

            ->andWhere('userEntity.userID = :userID')
            ->setParameter('userID', $userID)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getUserVerificationStatusByUserID($userID)
    {
        return $this->createQueryBuilder('userEntity')
            ->select('userEntity.verificationStatus')

            ->andWhere('userEntity.userID = :userID')
            ->setParameter('userID', $userID)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getAllStoreOwners()
    {
        return $this->createQueryBuilder('userEntity')

            ->andWhere('userEntity.roles LIKE :roles')
            ->setParameter('roles', '%"'.'ROLE_OWNER'.'"%')

            ->getQuery()
            ->getResult();
    }

    public function getAllClients()
    {
        return $this->createQueryBuilder('userEntity')

            ->andWhere('userEntity.roles LIKE :roles')
            ->setParameter('roles', '%"'.'ROLE_CLIENT'.'"%')

            ->getQuery()
            ->getResult();
    }

    public function getAllCaptains()
    {
        return $this->createQueryBuilder('userEntity')

            ->andWhere('userEntity.roles LIKE :roles')
            ->setParameter('roles', '%"'.'ROLE_CAPTAIN'.'"%')

            ->getQuery()
            ->getResult();
    }

    public function filterUsers(FilterUserRequest $request)
    {
        $query = $this->createQueryBuilder('userEntity')
            ->select('userEntity.id', 'userEntity.userID', 'userEntity.verificationStatus', 'userEntity.roles');

        if ($request->getUserID())
        {
            $query->andWhere('userEntity.userID = :userID');
            $query->setParameter('userID', $request->getUserID());
        }

        if ($request->getVerificationStatus())
        {
            $query->andWhere('userEntity.verificationStatus = :verificationStatus');
            $query->setParameter('verificationStatus', $request->getVerificationStatus());
        }

        if ($request->getRoles())
        {
            $roles = $request->getRoles()[0];

            $query->andWhere('userEntity.roles LIKE :roles');
            $query->setParameter('roles', '%'.$roles.'%');
        }

        return $query->getQuery()->getResult();
    }
}
