<?php

namespace App\Controller;
use App\AutoMapping;
use App\Request\CustomProductNotFoundCreateRequest;
use App\Service\CustomProductNotFoundService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;

class CustomProductNotFoundController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $customProductNotFoundService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, CustomProductNotFoundService $customProductNotFoundService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->customProductNotFoundService = $customProductNotFoundService;
    }

    /**
     * @Route("customproductnotfound", name="createCustomProductNotFound", methods={"POST"})
     * @IsGranted("ROLE_CLIENT")
     * @param Request $request
     * @return JsonResponse
     */
    public function createCustomProductNotFound(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, CustomProductNotFoundCreateRequest::class, (object)$data);
        $request->setClientID($this->getUserId());

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->customProductNotFoundService->createCustomProductNotFound($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("customproductsnotfound", name="getCustomProductsNotFound", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     */
    public function getCustomProductsNotFound()
    {
        $result = $this->customProductNotFoundService->getCustomProductsNotFound();

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("customproductnotfound/{id}", name="getCustomProductNotFound", methods={"GET"})
     * @return JsonResponse
     */
    public function getCustomProductNotFound($id): JsonResponse
    {
        $result = $this->customProductNotFoundService->getCustomProductNotFound($id);

        return $this->response($result, self::FETCH);
    }
}