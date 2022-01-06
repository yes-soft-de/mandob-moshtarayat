<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\MainAndSubLevelOneCategoriesLinkUpdateRequest;
use App\Service\CategoryLinkService;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;

class CategoryLinkController extends BaseController
{
    private $autoMapping;
    private $categoryLinkService;
    private $validator;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, CategoryLinkService $categoryLinkService, ValidatorInterface $validator)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->categoryLinkService = $categoryLinkService;
        $this->validator = $validator;
    }

    /**
     * admin: update link/s between main and level one sub categories
     * @Route("mainsublevelonecategorieslink", name="createCategoryLink", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Category Link")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Create new categories link by admin",
     *      @OA\JsonContent(
     *          @OA\Property(type="array", property="mainCategoriesIDs",
     *              @OA\Items()
     *          ),
     *          @OA\Property(type="integer", property="subCategoryLevelOneID")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the link/s being created",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="string", property="linkType"),
     *                  @OA\Property(type="integer", property="mainCategoryID"),
     *                  @OA\Property(type="integer", property="subCategoryLevelOneID"),
     *                  @OA\Property(type="integer", property="subCategoryLevelTwoID")
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function createCategoryLink(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, MainAndSubLevelOneCategoriesLinkUpdateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->categoryLinkService->updateMainAndSubLevelOneCategoriesLink($request);

        return $this->response($result, self::CREATE);
    }

}