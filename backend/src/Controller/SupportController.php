<?php


namespace App\Controller;
use App\AutoMapping;
use App\Request\SupportCreateRequest;
use App\Service\SupportService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;

class SupportController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $supportService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, SupportService $supportService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->supportService = $supportService;
    }
    
    /**
     * @Route("support", name="createReport", methods={"POST"})
     * @IsGranted("ROLE_OWNER")
     * @param Request $request
     * @return JsonResponse
     */
    public function createSupport(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, SupportCreateRequest::class, (object)$data);

        $request->setUserID($this->getUserId());

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }
        $result = $this->supportService->createSupport($request);
            
        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("supports", name="getreportsForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     */
    public function getSupports()
    {
        $result = $this->supportService->getSupports();

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("support/{id}", name="getReportById", methods={"GET"})
     * @return JsonResponse
     */
    public function getSupport($id)
    {
        $result = $this->supportService->getSupport($id);

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("supportupdatenewmessagestatus/{id}", name="reportUpdateNewMeessageStatus", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     */
    public function supportReportNewMessageStatus($id)
    {
        $result = $this->supportService->supportReportNewMessageStatus($id);

        return $this->response($result, self::FETCH);
    }
}
