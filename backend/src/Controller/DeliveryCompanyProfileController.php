<?php

namespace App\Controller;
use App\AutoMapping;
use App\Request\DeliveryCompanyInfoRequest;
use App\Request\DeliveryCompanyInfoUpdateRequest;
use App\Service\DeliveryCompanyProfileService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;


class DeliveryCompanyProfileController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $deliveryCompanyProfileService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, DeliveryCompanyProfileService $deliveryCompanyProfileService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->deliveryCompanyProfileService = $deliveryCompanyProfileService;
    }

    /**
     * @Route("companyinfo", name="createCompanyInfo", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function createDeliveryCompanyInfo(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, DeliveryCompanyInfoRequest::class, (object)$data);

        $result = $this->deliveryCompanyProfileService->createDeliveryCompanyInfo($request);
            

        return $this->response($result, self::CREATE);
    }

     /**
     * @Route("companyinfo", name="updateCompanyInfo", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse
     */
    public function updateCompanyInfo(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, DeliveryCompanyInfoRequest::class, (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->deliveryCompanyProfileService->updateCompanyInfo($request);

        return $this->response($result, self::UPDATE);
    }

    /**
     * @Route("companyinfo/{id}", name="getcompanyinfoById", methods={"GET"})
     * @param $id
     * @return JsonResponse
     */
    public function getCompanyInfoById($id): JsonResponse
    {
        $result = $this->deliveryCompanyProfileService->getcompanyinfoById($id);

        return $this->response($result, self::FETCH);
    }

     /**
     * @Route("companyinfoall", name="getcompanyinfoAll", methods={"GET"})
     * @return JsonResponse
     */
    public function getCompanyInfoAll(): JsonResponse
    {
        $result = $this->deliveryCompanyProfileService->getcompanyinfoAll();

        return $this->response($result, self::FETCH);
    }

     /**
     * @Route("companyinfoforuser", name="getcompanyinfoAllforUser", methods={"GET"})
     * @return JsonResponse
     */
    public function getCompanyInfoAllForUser(): JsonResponse
    {
        if ($this->isGranted('ROLE_OWNER')) {
             $result = $this->deliveryCompanyProfileService->getAllCompanyInfoForStoreOwner($this->getUserId());
        }

        if ($this->isGranted('ROLE_CAPTAIN')) {
             $result = $this->deliveryCompanyProfileService->getAllCompanyInfoForCaptain($this->getUserId());
        }
        return $this->response($result, self::FETCH);
    }
}
