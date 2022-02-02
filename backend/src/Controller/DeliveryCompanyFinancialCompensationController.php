<?php

namespace App\Controller;
use App\AutoMapping;
use App\Request\DeliveryCompanyFinancialCompensationCreateRequest;
use App\Request\DeliveryCompanyFinancialCompensationUpdateRequest;
use App\Service\DeliveryCompanyFinancialCompensationService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;


class DeliveryCompanyFinancialCompensationController extends BaseController
{
    private $autoMapping;
    private $deliveryCompanyFinancialCompensationService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, DeliveryCompanyFinancialCompensationService $deliveryCompanyFinancialCompensationService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->deliveryCompanyFinancialCompensationService = $deliveryCompanyFinancialCompensationService;
    }

    /**
     * @Route("financialCompensation", name="createFinancialCompensation", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function createFinancialCompensation(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, DeliveryCompanyFinancialCompensationCreateRequest::class, (object)$data);
        $result = $this->deliveryCompanyFinancialCompensationService->createFinancialCompensation($request);
            
        return $this->response($result, self::CREATE);
    }

     /**
     * @Route("financialCompensation", name="updateFinancialCompensation", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse
     */
    public function updateFinancialCompensation(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, DeliveryCompanyFinancialCompensationUpdateRequest::class, (object) $data);

        $result = $this->deliveryCompanyFinancialCompensationService->updateFinancialCompensation($request);

        return $this->response($result, self::UPDATE);
    }

     /**
     * @Route("financialCompensation/{id}", name="getFinancialCompensationById", methods={"GET"})
     * @return JsonResponse
     */
    public function getFinancialCompensationById($id)
    {
        $result = $this->deliveryCompanyFinancialCompensationService->getFinancialCompensationById($id);

        return $this->response($result, self::FETCH);
    }

     /**
     * @Route("financialCompensations", name="getFinancialCompensations", methods={"GET"})
     * @return JsonResponse
     */
    public function getFinancialCompensations()
    {
        $result = $this->deliveryCompanyFinancialCompensationService->getFinancialCompensations();

        return $this->response($result, self::FETCH);
    }

     /**
     * @Route("compensationsAndDeliveryCost", name="getCompensationsAndDeliveryCost", methods={"GET"})
     * @return JsonResponse
     */
    public function getCompensationsAndDeliveryCost()
    {
        $result = $this->deliveryCompanyFinancialCompensationService->getCompensationsAndDeliveryCost();

        return $this->response($result, self::FETCH);
    }
}
