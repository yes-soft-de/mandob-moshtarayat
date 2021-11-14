<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\DeliveryCompanyPaymentsToStoreCreateRequest;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use App\Service\DeliveryCompanyPaymentsToStoreService;


class DeliveryCompanyPaymentsToStoreController extends BaseController
{
    private $autoMapping;
    private $deliveryCompanyPaymentsToStoreService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, DeliveryCompanyPaymentsToStoreService $deliveryCompanyPaymentsToStoreService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->deliveryCompanyPaymentsToStoreService = $deliveryCompanyPaymentsToStoreService;
    }
    
    /**
     * @Route("/deliverycompanypaymentstostore", name="createDeliveryCompanyPaymentsTostore", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function createDeliveryCompanyPaymentsTostore(Request $request)
    {
            $data = json_decode($request->getContent(), true);

            $request = $this->autoMapping->map(stdClass::class, DeliveryCompanyPaymentsToStoreCreateRequest::class, (object)$data);

            $result = $this->deliveryCompanyPaymentsToStoreService->createDeliveryCompanyPaymentsTostore($request);

        return $this->response($result, self::CREATE);
    }

     /**
      * @Route("/deliverycompanypaymentstostore", name="getDeliveryCompanyPaymentsToStore", methods={"GET"})
      * @IsGranted("ROLE_OWNER")
      * @param Request $request
      * @return JsonResponse
      */
      public function getDeliveryCompanyPaymentsToStore()
      {
          $result = $this->deliveryCompanyPaymentsToStoreService->getDeliveryCompanyPaymentsToStore($this->getUserId());
  
          return $this->response($result, self::FETCH);
      }
}
