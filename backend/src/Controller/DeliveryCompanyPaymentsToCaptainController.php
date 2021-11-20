<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\DeliveryCompanyPaymentsToCaptainCreateRequest;
use App\Service\DeliveryCompanyPaymentsToCaptainService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\Validator\Validator\ValidatorInterface;


class DeliveryCompanyPaymentsToCaptainController extends BaseController
{
    private $autoMapping;
    private $deliveryCompanyPaymentsToCaptainService;
    private $validator;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, DeliveryCompanyPaymentsToCaptainService $deliveryCompanyPaymentsToCaptainService, ValidatorInterface $validator)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->deliveryCompanyPaymentsToCaptainService = $deliveryCompanyPaymentsToCaptainService;
        $this->validator = $validator;
    }
    
    /**
     * @Route("/deliveryCompanyPaymentsToCaptain", name="createDeliveryCompanyPaymentsToCaptain", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function createDeliveryCompanyPaymentsToCaptain(Request $request)
    {
       $data = json_decode($request->getContent(), true);

       $request = $this->autoMapping->map(stdClass::class, DeliveryCompanyPaymentsToCaptainCreateRequest::class, (object)$data);

       $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->deliveryCompanyPaymentsToCaptainService->createDeliveryCompanyPaymentsToCaptain($request);

        return $this->response($result, self::CREATE);
    }

     /**
      * @Route("/deliveryCompanyPaymentsToCaptain", name="getDeliveryCompanyPaymentsToCaptain", methods={"GET"})
      * @IsGranted("ROLE_CAPTAIN")
      * @param Request $request
      * @return JsonResponse
      */
      public function deliveryCompanyPaymentsToCaptain()
      {
          $result = $this->deliveryCompanyPaymentsToCaptainService->deliveryCompanyPaymentsToCaptain($this->getUserId());
  
          return $this->response($result, self::FETCH);
      }
}
