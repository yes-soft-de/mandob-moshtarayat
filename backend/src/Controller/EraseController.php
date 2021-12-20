<?php


namespace App\Controller;

use App\Entity\OrdersInvoicesEntity;
use App\Entity\ProductEntity;
use App\Entity\StoreCategoryEntity;
use App\Entity\StoreOwnerBranchEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\StoreProductCategoryEntity;
use Doctrine\ORM\Tools\SchemaTool;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\Routing\Annotation\Route;
use App\Entity\OrderEntity;
use App\Entity\OrderDetailEntity;
use App\Entity\OrderLogEntity;

class EraseController extends BaseController
{
    /**
    * @Route("dropalltables", name="deleteAllDatabaseTables", methods={"DELETE"})
    * @IsGranted("ROLE_ADMIN")
    */
   public function dropAllTablesOfDB()
   {
       $em = $this->getDoctrine()->getManager();
       $entitiesArray = $this->getDoctrine()->getManager()->getMetadataFactory()->getAllMetadata();

       $tool = new SchemaTool($em);

       $tool->dropSchema($entitiesArray);
       $tool->createSchema($entitiesArray);

       if($tool)
       {
           return $this->response("ِAll data were being deleted", self::DELETE);
       }
   }

    /**
     * @Route("eraseorders", name="deleteAllOrders", methods={"DELETE"})
     * @IsGranted("ROLE_ADMIN")
     */
    public function deleteAllOrders()
    {
        try
        {
            $em = $this->getDoctrine()->getManager();

            $order = $em->getRepository(OrderEntity::class)->createQueryBuilder('OrderEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $orderDetail = $em->getRepository(OrderDetailEntity::class)->createQueryBuilder('OrderDetailEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $orderLog = $em->getRepository(OrderLogEntity::class)->createQueryBuilder('OrderLogEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $orderInvoices = $em->getRepository(OrdersInvoicesEntity::class)->createQueryBuilder('OrdersInvoicesEntity')
                ->delete()
                ->getQuery()
                ->execute();
        }
        catch (\Exception $ex)
        {
            return $this->json($ex);
        }

        return $this->response("", self::DELETE);
    }

    /**
     * @Route("erasecategories", name="deleteAllCategories", methods={"DELETE"})
     * @IsGranted("ROLE_ADMIN")
     */
    public function deleteAllCategories()
    {
        try
        {
            $em = $this->getDoctrine()->getManager();

            $em->getRepository(StoreCategoryEntity::class)->createQueryBuilder('store_category_entity')
                ->delete()
                ->getQuery()
                ->execute();

            $em->getRepository(StoreProductCategoryEntity::class)->createQueryBuilder('store_product_category_entity')
                ->delete()
                ->getQuery()
                ->execute();

        }
        catch (\Exception $ex)
        {
            return $this->json($ex);
        }

        return $this->response("", self::DELETE);
    }

    /**
     * @Route("erasestores", name="deleteAllStores", methods={"DELETE"})
     * @IsGranted("ROLE_ADMIN")
     */
    public function deleteAllStores()
    {
        try
        {
            $em = $this->getDoctrine()->getManager();

            $em->getRepository(StoreOwnerProfileEntity::class)->createQueryBuilder('store_owner_profile_entity')
                ->delete()
                ->getQuery()
                ->execute();

            $em->getRepository(StoreOwnerBranchEntity::class)->createQueryBuilder('store_owner_branch_entity')
                ->delete()
                ->getQuery()
                ->execute();

        }
        catch (\Exception $ex)
        {
            return $this->json($ex);
        }

        return $this->response("", self::DELETE);
    }

    /**
     * @Route("eraseproducts", name="deleteAllProducts", methods={"DELETE"})
     * @IsGranted("ROLE_ADMIN")
     */
    public function deleteAllProducts()
    {
        try
        {
            $em = $this->getDoctrine()->getManager();

            $em->getRepository(ProductEntity::class)->createQueryBuilder('ProductEntity')
                ->delete()
                ->getQuery()
                ->execute();
        }
        catch (\Exception $ex)
        {
            return $this->json($ex);
        }

        return $this->response("", self::DELETE);
    }
}
