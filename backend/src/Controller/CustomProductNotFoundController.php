<?php

namespace App\Controller;
use App\AutoMapping;
use App\Request\CustomProductNotFoundCreateRequest;
use App\Service\CustomProductNotFoundService;
use Nelmio\ApiDocBundle\Annotation\Security;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use OpenApi\Annotations as OA;

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
     * client:Create Custom Product Not Found.
     * @Route("customproductnotfound", name="createCustomProductNotFound", methods={"POST"})
     * @IsGranted("ROLE_CLIENT")
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Custom Product Not Found")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Create Custom Product Not Found",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="productName"),
     *          @OA\Property(type="string", property="productImage"),
     *          @OA\Property(type="number", property="detail"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns data of product",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="productName"),
     *                  @OA\Property(type="string", property="productImage"),
     *                  @OA\Property(type="number", property="detail"),
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
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
     * admin: get Custom Products Not Found.
     * @Route("customproductsnotfound", name="getCustomProductsNotFound", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     * *
     * @OA\Tag(name="Custom Product Not Found")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the products not found",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *                @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="productName"),
     *                  @OA\Property(type="object", property="productImage",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL"),
     *                  ),
     *                  @OA\Property(type="number", property="detail"),
     *                  )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getCustomProductsNotFound()
    {
        $result = $this->customProductNotFoundService->getCustomProductsNotFound();

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: get Custom Product Not Found.
     * @Route("customproductnotfound/{id}", name="getCustomProductNotFound", methods={"GET"})
     * @return JsonResponse
     * *
     * @OA\Tag(name="Custom Product Not Found")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the product not found",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="productName"),
     *                  @OA\Property(type="object", property="productImage",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL"),
     *                      ),
     *                  @OA\Property(type="number", property="detail"),
     *                  )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getCustomProductNotFound($id): JsonResponse
    {
        $result = $this->customProductNotFoundService->getCustomProductNotFound($id);

        return $this->response($result, self::FETCH);
    }
}