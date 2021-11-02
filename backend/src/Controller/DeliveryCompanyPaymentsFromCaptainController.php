<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\DeliveryCompanyPaymentsFromCaptainCreateRequest;
use App\Service\DeliveryCompanyPaymentsFromCaptainService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;


class DeliveryCompanyPaymentsFromCaptainController extends BaseController
{
    private $autoMapping;
    private $deliveryCompanyPaymentsFromCaptainService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, DeliveryCompanyPaymentsFromCaptainService $deliveryCompanyPaymentsFromCaptainService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->deliveryCompanyPaymentsFromCaptainService = $deliveryCompanyPaymentsFromCaptainService;
    }
    
    /**
     * @Route("/deliveryCompanyPaymentsFromCaptain", name="createDeliveryCompanyPaymentsFromCaptain", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function createDeliveryCompanyPaymentsFromCaptain(Request $request)
    {
            $data = json_decode($request->getContent(), true);

            $request = $this->autoMapping->map(stdClass::class, DeliveryCompanyPaymentsFromCaptainCreateRequest::class, (object)$data);

            $result = $this->deliveryCompanyPaymentsFromCaptainService->createDeliveryCompanyPaymentsFromCaptain($request);

        return $this->response($result, self::CREATE);
    }

     /**
      * @Route("/deliveryCompanyPaymentsFromCaptain", name="getDeliveryCompanyPaymentsFromCaptain", methods={"GET"})
      * @IsGranted("ROLE_CAPTAIN")
      * @param Request $request
      * @return JsonResponse
      */
      public function deliveryCompanyPaymentsFromCaptain()
      {
          $result = $this->deliveryCompanyPaymentsFromCaptainService->deliveryCompanyPaymentsFromCaptain($this->getUserId());
  
          return $this->response($result, self::FETCH);
      }
}
