<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\CaptainTermCreateRequest;
use App\Request\CaptainTermUpdateRequest;
use App\Service\CaptainTermService;
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

class CaptainTermController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $captainTermService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, CaptainTermService $captainTermService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->captainTermService = $captainTermService;
    }
    
    /**
     * @Route("/termscaptain", name="createTermsCaptain", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Captain Terms")
     *@OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     * @OA\RequestBody(
     *      description="Create new captain terms",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="content"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns the new captain terms",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="content"),
     *          )
     *      )
     * )
     * @Security(name="Bearer")
     */
    public function createCaptainTerm(Request $request)
    {
       $data = json_decode($request->getContent(), true);

       $request = $this->autoMapping->map(stdClass::class, CaptainTermCreateRequest::class, (object)$data);

       $violations = $this->validator->validate($request);
       if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
            }

       $result = $this->captainTermService->createCaptainTerm($request);

       return $this->response($result, self::CREATE);
    }

    /**
      * @Route("/termscaptain", name="GetTermsCaptain", methods={"GET"})
      * @param Request $request
      * @return JsonResponse
     * *
     * @OA\Tag(name="Captain Terms")
     * @OA\Response(
     *      response=200,
     *      description="Get captain terms",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="content"),
     *               ),
     *          )
     *      )
     * )
     */
      public function getTermsCaptain()
      {
          $result = $this->captainTermService->getTermsCaptain();
  
          return $this->response($result, self::FETCH);
      }

    /**
          * @Route("/termscaptainbyid/{id}", name="GetTermsCaptainById", methods={"GET"})
      * @param Request $request
      * @return JsonResponse
     * *
     * @OA\Tag(name="Captain Terms")
     * @OA\Response(
     *      response=200,
     *      description="Get captain terms",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="content"),
     *          )
     *      )
     * )
     */
      public function getTermsCaptainById($id)
      {
          $result = $this->captainTermService->getTermsCaptainById($id);
  
          return $this->response($result, self::FETCH);
      }

      /**
     * @Route("/termscaptain", name="termsUpdate", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
       * *
       * @OA\Tag(name="Captain Terms")
       *@OA\Parameter(
       *      name="token",
       *      in="header",
       *      description="token to be passed as a header",
       *      required=true
       * )
       * @OA\RequestBody(
       *      description="Update captain terms",
       *      @OA\JsonContent(
       *          @OA\Property(type="string", property="id"),
       *          @OA\Property(type="string", property="content"),
       *      )
       * )
       *
       * @OA\Response(
       *      response=200,
       *      description="Returns captain terms",
       *      @OA\JsonContent(
       *          @OA\Property(type="string", property="status_code"),
       *          @OA\Property(type="string", property="msg"),
       *          @OA\Property(type="object", property="Data",
       *                  @OA\Property(type="integer", property="id"),
       *                  @OA\Property(type="string", property="content"),
       *          )
       *      )
       * )
       * @Security(name="Bearer")
       */
    public function update(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, CaptainTermUpdateRequest::class, (object) $data);

        $response = $this->captainTermService->update($request);

        return $this->response($response, self::UPDATE);
    }
}
