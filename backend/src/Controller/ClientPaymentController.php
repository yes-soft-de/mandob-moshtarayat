<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\ClientPaymentCreateRequest;
use App\Service\ClientPaymentService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;

class ClientPaymentController extends BaseController
{
    private $autoMapping;
    private $clientPaymentService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ClientPaymentService $clientPaymentService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->clientPaymentService = $clientPaymentService;
    }
    
    /**
     * @Route("/clientpayment", name="createClientPayment", methods={"POST"})
     * @IsGranted("ROLE_CAPTAIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function createClientPayment(Request $request)
    {
            $data = json_decode($request->getContent(), true);

            $request = $this->autoMapping->map(stdClass::class, ClientPaymentCreateRequest::class, (object)$data);
            $request->setCaptainID($this->getUserId());
            $result = $this->clientPaymentService->createClientPayment($request);

        return $this->response($result, self::CREATE);
    }
}
