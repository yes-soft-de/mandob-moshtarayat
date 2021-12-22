<?php


namespace App\Controller;

use Doctrine\ORM\Tools\SchemaTool;
use Symfony\Component\Routing\Annotation\Route;

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
}
