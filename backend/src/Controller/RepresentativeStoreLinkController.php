<?php


namespace App\Controller;

use App\AutoMapping;
use App\Request\RepresentativeStoreLinkCreateRequest;
use App\Service\RepresentativeStoreLinkService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use OpenApi\Annotations as OA;

class RepresentativeStoreLinkController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $representativeStoreLinkService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, RepresentativeStoreLinkService $representativeStoreLinkService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->representativeStoreLinkService = $representativeStoreLinkService;
    }

    /**
     * Create link between representative and store.
     * @Route("representativestorelink", name="createRepresentativeStoreLink", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Representative Store Link")
     *
     * @OA\RequestBody(
     *      description="Create new mandob",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="userName")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the link status",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="string", property="linkStatus")
     *          )
     *      )
     * )
     *
     */
    public function createRepresentativeStoreLink(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, RepresentativeStoreLinkCreateRequest::class, (object)$data);
        $request->setStoreOwnerIP("AC:37:43:CB:D6:6C");
        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string)$violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->representativeStoreLinkService->createRepresentativeStoreLink($request);

        return $this->response($response, self::CREATE);
    }
}
