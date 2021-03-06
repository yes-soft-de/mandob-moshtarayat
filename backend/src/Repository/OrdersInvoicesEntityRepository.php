<?php

namespace App\Repository;

use App\Entity\OrdersInvoicesEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method OrdersInvoicesEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method OrdersInvoicesEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method OrdersInvoicesEntity[]    findAll()
 * @method OrdersInvoicesEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class OrdersInvoicesEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, OrdersInvoicesEntity::class);
    }

    public function getInvoicesByOrderNumber($orderNumber)
    {
        return $this->createQueryBuilder('invoice')

            ->select('invoice.id', 'invoice.invoiceAmount')

            ->andWhere('invoice.orderNumber = :orderNumber' )
            ->setParameter('orderNumber',$orderNumber)

            ->getQuery()
            ->getResult();
    }

    public function getInvoicesByOrderNumberAndStoreID($storeOwnerProfileID, $orderNumber)
    {
        return $this->createQueryBuilder('invoice')

            ->andWhere('invoice.orderNumber = :orderNumber' )
            ->andWhere('invoice.storeOwnerProfileID = :storeOwnerProfileID' )

            ->setParameter('orderNumber',$orderNumber)
            ->setParameter('storeOwnerProfileID',$storeOwnerProfileID)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function sumInvoiceAmountWithoutOrderTypeSendIt($invoicesIDs)
    {
        return $this->createQueryBuilder('invoice')

            ->select('sum(invoice.invoiceAmount) as sumInvoiceAmount')

            ->andWhere('invoice.id IN (:invoicesIDs)' )
            ->setParameter('invoicesIDs',$invoicesIDs)

            ->getQuery()
            ->getSingleScalarResult();
    }
}
