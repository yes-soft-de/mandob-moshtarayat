<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\RatingCreateRequest;
use App\Service\RatingService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;

class RatingController extends BaseController
{
    private $autoMapping;
    private $ratingService;
    private $validator;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, RatingService $ratingService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->ratingService = $ratingService;
        $this->validator = $validator;
    }

    /**
     * @Route("rating", name="createRating", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function createRatingByCaptainOrClient(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, RatingCreateRequest::class, (object)$data);
        $request->setUserID($this->getUserId());

        $result = $this->ratingService->createRatingByCaptainOrClient($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * client: create captain rating.
     * @Route("ratingCaptainByClient", name="createCaptainRatingByClient", methods={"POST"})
     * @IsGranted("ROLE_CLIENT")
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Rating")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Create Captain Rating By Client",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="itemID"),
     *          @OA\Property(type="integer", property="rating"),
     *          @OA\Property(type="integer", property="orderNumber"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns the new Rating",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="integer", property="itemID"),
     *                  @OA\Property(type="string", property="itemType"),
     *                  @OA\Property(type="integer", property="rating"),
     *                  @OA\Property(type="string", property="userID"),
     *                  @OA\Property(type="integer", property="orderNumber"),
     *                  @OA\Property(type="string", property="userType"),
     *          )
     *      )
     * )
     * @Security(name="Bearer")
     */
    public function createCaptainRatingByClient(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, RatingCreateRequest::class, (object)$data);

        $request->setUserID($this->getUserId());

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->ratingService->createCaptainRatingByClient($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * client: Create store rating.
     * @Route("ratingStoreByClient", name="createStoreRatingByClient", methods={"POST"})
     * @IsGranted("ROLE_CLIENT")
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Rating")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Create Store Rating By Client",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="itemID"),
     *          @OA\Property(type="integer", property="rating"),
     *          @OA\Property(type="integer", property="orderNumber"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns the new Rating",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="integer", property="itemID"),
     *                  @OA\Property(type="string", property="itemType"),
     *                  @OA\Property(type="integer", property="rating"),
     *                  @OA\Property(type="string", property="userID"),
     *                  @OA\Property(type="integer", property="orderNumber"),
     *                  @OA\Property(type="string", property="userType"),
     *          )
     *      )
     * )
     * @Security(name="Bearer")
     */
    public function createStoreRatingByClient(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, RatingCreateRequest::class, (object)$data);
        $request->setUserID($this->getUserId());

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->ratingService->createStoreRatingByClient($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * client: create product rating.
     * @Route("ratingProductByClient", name="createProductRatingByClient", methods={"POST"})
     * @IsGranted("ROLE_CLIENT")
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Rating")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Create Product Rating By Client",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="itemID"),
     *          @OA\Property(type="integer", property="rating"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns the new Rating",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="integer", property="itemID"),
     *                  @OA\Property(type="string", property="itemType"),
     *                  @OA\Property(type="integer", property="rating"),
     *                  @OA\Property(type="string", property="userID"),
     *                  @OA\Property(type="integer", property="orderNumber"),
     *                  @OA\Property(type="string", property="userType"),
     *          )
     *      )
     * )
     * @Security(name="Bearer")
     */
    public function createProductRatingByClient(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, RatingCreateRequest::class, (object)$data);
        $request->setUserID($this->getUserId());

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->ratingService->createProductRatingByClient($request);

        return $this->response($result, self::CREATE);
    }
}
