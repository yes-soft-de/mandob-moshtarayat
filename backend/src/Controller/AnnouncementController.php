<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\AnnouncementCreateRequest;
use App\Request\AnnouncementUpdateRequest;
use App\Service\AnnouncementService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;


class AnnouncementController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $announcementService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, AnnouncementService $announcementService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->announcementService = $announcementService;
        $this->announcementService = $announcementService;
    }

    /**
     * @Route("announcement", name="createAnnouncement", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function createAnnouncement(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AnnouncementCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }
        $result = $this->announcementService->createAnnouncement($request);
            

        return $this->response($result, self::CREATE);
    }

     /**
     * @Route("announcement", name="updateAnnouncement", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse
     */
    public function updateAnnouncement(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, AnnouncementUpdateRequest::class, (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->announcementService->updateAnnouncement($request);

        return $this->response($result, self::UPDATE);
    }

     /**
     * @Route("announcement/{id}", name="getAnnouncementById", methods={"GET"})
     * @return JsonResponse
     */
    public function getAnnouncementById($id)
    {
        $result = $this->announcementService->getAnnouncementById($id);

        return $this->response($result, self::FETCH);
    }

     /**
     * @Route("announcements", name="getAnnouncements", methods={"GET"})
     * @return JsonResponse
     */
    public function getAnnouncements()
    {
        $result = $this->announcementService->getAnnouncements();

        return $this->response($result, self::FETCH);
    }
}
