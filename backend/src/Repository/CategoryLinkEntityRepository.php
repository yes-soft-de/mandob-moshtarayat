<?php

namespace App\Repository;

use App\Constant\CategoryLinkTypeConstant;
use App\Entity\CategoryLinkEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method CategoryLinkEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method CategoryLinkEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method CategoryLinkEntity[]    findAll()
 * @method CategoryLinkEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class CategoryLinkEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, CategoryLinkEntity::class);
    }

    public function getAllMainAndSubLevelOneCategoryLinksBySubCategoryLevelOne($subCategoryLevelOneID)
    {
        return $this->createQueryBuilder('categoryLinkEntity')

            ->andWhere('categoryLinkEntity.linkType = :linkType')
            ->setParameter('linkType', CategoryLinkTypeConstant::$MAIN_WITH_LEVEL_ONE_LINK_TYPE)

            ->andWhere('categoryLinkEntity.subCategoryLevelOneID = :subCategoryLevelOneID')
            ->setParameter('subCategoryLevelOneID', $subCategoryLevelOneID)

            ->getQuery()
            ->getResult();
    }

    public function getAllSubLevelOneAndSubLevelTwoCategoriesLinkBySubCategoryLevelTwoID($subCategoryLevelTwoID)
    {
        return $this->createQueryBuilder('categoryLinkEntity')

            ->andWhere('categoryLinkEntity.linkType = :linkType')
            ->setParameter('linkType', CategoryLinkTypeConstant::$LEVEL_ONE_WITH_LEVEL_TWO_LINK_TYPE)

            ->andWhere('categoryLinkEntity.subCategoryLevelTwoID = :subCategoryLevelTwoID')
            ->setParameter('subCategoryLevelTwoID', $subCategoryLevelTwoID)

            ->getQuery()
            ->getResult();
    }

}
