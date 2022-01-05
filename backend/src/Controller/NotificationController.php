<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\NotificationTokenRequest;
use App\Service\NotificationService;
use Nelmio\ApiDocBundle\Annotation\Security;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Serializer\SerializerInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use OpenApi\Annotations as OA;
use Symfony\Component\Routing\Annotation\Route;

class NotificationController extends BaseController
{
    private $autoMapping;
    private $notificationService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, NotificationService $notificationService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->notificationService = $notificationService;
    }

    /**
     * create token.
     * @Route("/notificationtoken", name="notificationtoken", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Notification Firebase")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     *  @OA\RequestBody (
     *        description="create token",
     *        @OA\JsonContent(
     *              @OA\Property(type="string", property="token"),
     *               ),
     *         ),
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns object",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *               @OA\Property(type="object", property="token"),
     *               @OA\Property(type="object", property="date"),
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function createNotificationToken(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,NotificationTokenRequest::class,(object)$data);
        $request->setUserID($this->getUserId());

        $response = $this->notificationService->notificationTokenCreate($request);

        return $this->response($response, self::CREATE);
    }


    /**
     * notification new chat.
     * @Route("/notificationnewchat", name="notificationnewchat", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Notification Firebase")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     *  @OA\RequestBody (
     *        description="notification new chat",
     *        @OA\JsonContent(
     *              @OA\Property(type="string", property="roomID"),
     *              @OA\Property(type="object", property="userType", description="captain or store or client or admin"),
     *               ),
     *         ),
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns object",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items()
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function notificationNewChat(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,NotificationTokenRequest::class,(object)$data);

        $request->setUserID($this->getUserId());

        $response = $this->notificationService->notificationNewChat($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * @Route("/notificationtoadmin", name="messageFromCaptainOrReprotToAdmin", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function notificationToAdmin(Request $request)
    {
        $response=[];
        $data = json_decode($request->getContent(), true);
      
        $request = $this->autoMapping->map(stdClass::class,NotificationTokenRequest::class,(object)$data);
       
        $request->setUserID($this->getUser()->getUsername());
       
        if ($this->isGranted('ROLE_OWNER')) {
             $response = $this->notificationService->updateNewMessageStatusInReport($request);
        }

        if ($this->isGranted('ROLE_CAPTAIN')) {
             $response = $this->notificationService->updateNewMessageStatusInCaptain($request);
        }
        return $this->response($response, self::CREATE);
    }
    
    /**
     * @Route("/notificationtocaptainfromadmin", name="notificationToCaptainFromAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function notificationToCaptainFromAdmin(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,NotificationTokenRequest::class,(object)$data);
        
        $response = $this->notificationService->notificationToCaptainFromAdmin($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * @Route("/notificationtoreportfromadmin", name="notificationToReportFromAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function notificationToReportFromAdmin(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,NotificationTokenRequest::class,(object)$data);
        
        $response = $this->notificationService->notificationToReportFromAdmin($request);

        return $this->response($response, self::CREATE);
    }
}
