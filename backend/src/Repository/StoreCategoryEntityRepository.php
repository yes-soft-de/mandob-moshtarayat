<?php

namespace App\Repository;

use App\Entity\StoreCategoryEntity;
use App\Entity\StoreOwnerProfileEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;
use App\Entity\StoreProductCategoryEntity;

/**
 * @method StoreCategoryEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method StoreCategoryEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method StoreCategoryEntity[]    findAll()
 * @method StoreCategoryEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class StoreCategoryEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, StoreCategoryEntity::class);
    }

    public function getStoreCategories()
    {
        return $this->createQueryBuilder('storeCategory')

            ->select('storeCategory.id', 'storeCategory.storeCategoryName', 'storeCategory.description', 'storeCategory.image')

            ->getQuery()
            ->getResult();
    }

    public function isItRelatedToSubcategories($id)
    {
        return $this->createQueryBuilder('storeCategory')

            ->select('StoreProductCategoryEntity.id')

            ->leftJoin(StoreProductCategoryEntity::class, 'StoreProductCategoryEntity', Join::WITH, 'StoreProductCategoryEntity.storeCategoryID = storeCategory.id')

            ->andWhere('StoreProductCategoryEntity.storeCategoryID= :id')

            ->setParameter('id',$id)

            ->getQuery()
            ->getResult();
    }

    public function getStoreCategoriesByClientFavouriteCategoriesIDs($favouriteCategoriesIDsArray)
    {
        $query = $this->createQueryBuilder('storeCategory')
            ->select('storeCategory.id', 'storeCategory.storeCategoryName', 'storeCategory.description', 'storeCategory.image');

        if($favouriteCategoriesIDsArray)
        {
            $query->andWhere("storeCategory.id IN (:categoriesIDs)");
            $query->setParameter('categoriesIDs', $favouriteCategoriesIDsArray);
        }

        return $query->getQuery()->getResult();
    }
}
