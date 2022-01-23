<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\NotificationNewChatAnonymousRequest;
use App\Request\NotificationTokenByUserIDRequest;
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
     * @Route("/notificationnewchatanonymous", name="notificationNewChatAnonymous", methods={"POST"})
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
     *              @OA\Property(type="string", property="anonymousChatID"),
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
    public function notificationNewChatAnonymous(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,NotificationNewChatAnonymousRequest::class,(object)$data);

        $response = $this->notificationService->notificationNewChatAnonymous($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * notification new chat by other UserID.
     * @Route("/notificationnewchatbyuserid", name="notificationnewchatByOtherUserID", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Notification Firebase")
     *
     *
     *  @OA\RequestBody (
     *        description="notification new chat by other userID",
     *        @OA\JsonContent(
     *              @OA\Property(type="integer", property="otherUserID", description="if null send new msg notification to admins"),
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
     */
    public function notificationNewChatByUserID(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,NotificationTokenByUserIDRequest::class,(object)$data);

        $response = $this->notificationService->notificationNewChatByUserID($request);

        return $this->response($response, self::CREATE);
    }
}
