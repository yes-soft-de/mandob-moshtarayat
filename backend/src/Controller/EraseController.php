<?php


namespace App\Controller;

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
}
