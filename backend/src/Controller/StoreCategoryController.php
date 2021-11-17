<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\StoreCategoryCreateRequest;
use App\Request\StoreCategoryUpdateRequest;
use App\Service\StoreCategoryService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class StoreCategoryController extends BaseController
{
    private $autoMapping;
    private $storeCategoryService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, StoreCategoryService $storeCategoryService, ValidatorInterface $validator)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->storeCategoryService = $storeCategoryService;
        $this->validator = $validator;
    }

    /**
     * @Route("/createstorecategory", name="createStoreCategory", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     * @OA\Tag(name="Store Category")
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     * @OA\RequestBody(
     *      description="Create new Store Category",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="storeCategoryName"),
     *          @OA\Property(type="string", property="description"),
     *          @OA\Property(type="string", property="image"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns the new store owner's role and the creation date",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="storeCategoryName"),
     *                  @OA\Property(type="string", property="description"),
     *                  @OA\Property(type="string", property="image")
     *          )
     *      )
     * )
     * @Security(name="Bearer")
     */
    public function createStoreCategory(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StoreCategoryCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if(\count($violations) > 0)
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }
        $result = $this->storeCategoryService->createStoreCategory($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("/updatestorecategory", name="updateStoreCategory", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     * @OA\Tag(name="Store Category")
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     * @OA\RequestBody(
     *      description="Update Store Category if not have has store product category",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="storeCategoryName"),
     *          @OA\Property(type="string", property="description"),
     *          @OA\Property(type="string", property="image"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns store ",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="storeCategoryName"),
     *                  @OA\Property(type="string", property="description"),
     *                  @OA\Property(type="string", property="image")
     *          )
     *      )
     * )
     * @Security(name="Bearer")
     */
    public function updateStoreCategory(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StoreCategoryUpdateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if(\count($violations) > 0)
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }
        $result = $this->storeCategoryService->updateStoreCategory($request);
        if(is_string($result)){
              return $this->response($result, self::ERROR_RELATED);
          }
        return $this->response($result, self::UPDATE);
    }

    /**
     * @Route("storecategories", name="getStoreCategories", methods={"GET"})
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Category")
     *
     * @OA\Response(
     *      response=200,
     *      description="Get Store Categories",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="storeCategoryName"),
     *                  @OA\Property(type="object", property="image",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL"),
     *                  ),
     *          )
     *      )
     * )
     */
      public function getStoreCategories(): JsonResponse
      {
          $result = $this->storeCategoryService->getStoreCategories();
  
          return $this->response($result, self::FETCH);
      }

    /**
      * @Route("/storecategory/{id}", name="getStoreCategory", methods={"GET"})
      * @param Request $request
      * @return JsonResponse
     * @OA\Tag(name="Store Category")
     * @OA\Response(
     *      response=200,
     *      description="Get Store Categories",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="string", property="storeCategoryName"),
     *                  @OA\Property(type="object", property="image")
     *          )
     *      )
     * )
     */
      public function getStoreCategory($id)
      {
          $result = $this->storeCategoryService->getStoreCategory($id);
  
          return $this->response($result, self::FETCH);
      }
}
