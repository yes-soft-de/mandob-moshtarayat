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
     */
    public function update(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, CaptainTermUpdateRequest::class, (object) $data);

        $response = $this->captainTermService->update($request);

        return $this->response($response, self::UPDATE);
    }
}
