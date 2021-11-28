<?php

namespace App\Controller;
use App\AutoMapping;
use App\Request\DeliveryCompanyFinancialCompensationCreateRequest;
use App\Request\DeliveryCompanyFinancialCompensationUpdateRequest;
use App\Service\DeliveryCompanyFinancialCompensationService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;

class DeliveryCompanyFinancialCompensationController extends BaseController
{
    private $autoMapping;
    private $deliveryCompanyFinancialCompensationService;
    private $validator;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, DeliveryCompanyFinancialCompensationService $deliveryCompanyFinancialCompensationService, ValidatorInterface $validator)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->deliveryCompanyFinancialCompensationService = $deliveryCompanyFinancialCompensationService;
        $this->validator = $validator;
    }

    /**
     * @Route("financialCompensation", name="createFinancialCompensation", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Delivery Company Financial Compensation")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Create financial compensation",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="kilometers"),
     *          @OA\Property(type="integer", property="maxKilometerBonus"),
     *          @OA\Property(type="integer", property="minKilometerBonus"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns Delivery Company Financial Compensation",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *                @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="integer", property="kilometers"),
     *                  @OA\Property(type="integer", property="maxKilometerBonus"),
     *                  @OA\Property(type="integer", property="minKilometerBonus"),
     *              ),
     *          )
     *      )
     * )
     * @Security(name="Bearer")
     */
    public function createFinancialCompensation(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, DeliveryCompanyFinancialCompensationCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

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
