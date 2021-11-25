<?php


namespace App\Controller;

use App\Entity\StoreCategoryEntity;
use App\Entity\StoreOwnerBranchEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\StoreProductCategoryEntity;
use Doctrine\ORM\Tools\SchemaTool;
use Symfony\Component\Routing\Annotation\Route;
use App\Entity\OrderEntity;
use App\Entity\OrderDetailEntity;
use App\Entity\OrderLogEntity;

class EraseController extends BaseController
{
    /**
    * @Route("dropalltables", name="deleteAllDatabaseTables", methods={"DELETE"})
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
        }
        catch (\Exception $ex)
        {
            return $this->json($ex);
        }

        return $this->response("", self::DELETE);
    }

    /**
     * @Route("erasecategories", name="deleteAllCategories", methods={"DELETE"})
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

}
