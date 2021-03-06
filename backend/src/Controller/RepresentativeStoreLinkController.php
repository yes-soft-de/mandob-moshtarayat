<?php


namespace App\Controller;

use App\AutoMapping;
use App\Constant\AppStoreTypeConstant;
use App\Request\RepresentativeStoreLinkCreateRequest;
use App\Service\RepresentativeStoreLinkService;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use stdClass;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\RedirectResponse;
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
    private $params;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, RepresentativeStoreLinkService $representativeStoreLinkService,
                                ParameterBagInterface $params)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->representativeStoreLinkService = $representativeStoreLinkService;
        $this->params = $params;
    }

    /**
     * Create link between representative and store.
     * @Route("representativestorelink", name="createRepresentativeStoreLink", methods={"POST"})
     * @IsGranted("ROLE_MANDOB")
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

        $request->setStoreOwnerIP($_SERVER['REMOTE_ADDR']);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string)$violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->representativeStoreLinkService->createRepresentativeStoreLink($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * @Route("getstoreappurl/{representativeUserID}/{store}", name="getStoreAppURL", methods={"GET"})
     *
     * @OA\Tag(name="Representative Store Link")
     *
     * @OA\Response(
     *     response="default",
     *     description="redirect to the URL of the store app on Google Play Store"
     * )
     */
    public function getStoreAppURL($representativeUserID, $store): RedirectResponse
    {
        $request['representativeUserID'] = $representativeUserID;

        $createRequest = $this->autoMapping->map('array', RepresentativeStoreLinkCreateRequest::class, $request);

        $this->representativeStoreLinkService->createRepresentativeStoreLink($createRequest);

        if ($store === AppStoreTypeConstant::$APPLE_STORE) {

            return new RedirectResponse($this->params->get('store_url_on_apple_store'));
            
        } elseif ($store === AppStoreTypeConstant::$GOOGLE_PLAY_STORE) {

            return new RedirectResponse($this->params->get('store_url_on_google_play_store'));
        }
    }
}
