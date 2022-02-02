<?php

namespace App\Controller;
use App\AutoMapping;
use App\Request\DeliveryCompanyFinancialRequest;
use App\Request\DeliveryCompanyFinancialUpdateRequest;
use App\Service\DeliveryCompanyFinancialService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;


class DeliveryCompanyFinancialController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $deliveryCompanyFinancialService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, DeliveryCompanyFinancialService $deliveryCompanyFinancialService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->deliveryCompanyFinancialService = $deliveryCompanyFinancialService;
    }

    /**
     * @Route("deliveryCompanyFinancial", name="createDeliveryCompanyFinancial", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function createDeliveryCompanyFinancial(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, DeliveryCompanyFinancialRequest::class, (object)$data);

        $result = $this->deliveryCompanyFinancialService->createDeliveryCompanyFinancial($request);            

        return $this->response($result, self::CREATE);
    }

     /**
     * @Route("deliveryCompanyFinancial", name="updateDeliveryCompanyFinancial", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse
     */
    public function updateDeliveryCompanyFinancial(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, DeliveryCompanyFinancialUpdateRequest::class, (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->deliveryCompanyFinancialService->updateDeliveryCompanyFinancial($request);

        return $this->response($result, self::UPDATE);
    }

     /**
     * @Route("getDeliveryCompanyFinancialById/{id}", name="getDeliveryCompanyFinancialById", methods={"GET"})
     * @return JsonResponse
     */
    public function getDeliveryCompanyFinancialById($id)
    {
        $result = $this->deliveryCompanyFinancialService->getDeliveryCompanyFinancialById($id);

        return $this->response($result, self::FETCH);
    }

     /**
     * @Route("getDeliveryCompanyFinancialAll", name="getDeliveryCompanyFinancialAll", methods={"GET"})
     * @return JsonResponse
     */
    public function getDeliveryCompanyFinancialAll()
    {
        $result = $this->deliveryCompanyFinancialService->getDeliveryCompanyFinancialAll();

        return $this->response($result, self::FETCH);
    }
}
