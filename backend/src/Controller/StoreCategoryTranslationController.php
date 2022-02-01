<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\StoreCategoryTranslationCreateRequest;
use App\Service\StoreCategoryTranslationService;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class StoreCategoryTranslationController extends BaseController
{
    private $autoMapping;
    private $storeCategoryTranslationService;
    private $validator;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, StoreCategoryTranslationService $storeCategoryTranslationService, ValidatorInterface $validator)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->storeCategoryTranslationService = $storeCategoryTranslationService;
        $this->validator = $validator;
    }

    /**
     * admin: Create new store category translation.
     * @Route("createstorecategorytranslation", name="createStoreCategoryTranslation", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Category Translation")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Create new Store Category translation",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="storeCategoryID"),
     *          @OA\Property(type="string", property="storeCategoryName"),
     *          @OA\Property(type="string", property="language"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the new store owner's role and the creation date",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="storeCategoryName"),
     *                  @OA\Property(type="string", property="description"),
     *                  @OA\Property(type="string", property="language")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function createStoreCategoryTranslation(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StoreCategoryTranslationCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if(\count($violations) > 0)
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->storeCategoryTranslationService->createStoreCategoryTranslation($request);

        return $this->response($result, self::CREATE);
    }

}