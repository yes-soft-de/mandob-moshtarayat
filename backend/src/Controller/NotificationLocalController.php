<?php

namespace App\Controller;
use App\Service\NotificationLocalService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;


class NotificationLocalController extends BaseController
{
    private $notificationLocalService;

    public function __construct(SerializerInterface $serializer, NotificationLocalService $notificationLocalService)
    {
        parent::__construct($serializer);
        $this->notificationLocalService = $notificationLocalService;
    }

    /**
     * Get Local Notification By Id.
     * @Route("notificationLocal/{id}", name="getLocalNotificationById", methods={"GET"})
     * @return JsonResponse
     * *
     * @OA\Tag(name="Local Notification")
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns Local Notification",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="title"),
     *                  @OA\Property(type="string", property="message"),
     *                  @OA\Property(type="string", property="orderNumber"),
     *                  @OA\Property(type="object", property="createdAt"),
     *          )
     *      )
     * )
     */
      public function getLocalNotificationById($id): JsonResponse
      {
      $result = $this->notificationLocalService->getLocalNotificationById($id);

      return $this->response($result, self::FETCH);
      }

     /**
     * client: Local Notifications.
     * @Route("notificationsLocal", name="getLocalNotifications", methods={"GET"})
     * @IsGranted("ROLE_CLIENT")
     * *
     * @OA\Tag(name="Local Notification")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns Local Notifications",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *             @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="title"),
     *                  @OA\Property(type="string", property="message"),
     *                  @OA\Property(type="string", property="orderNumber"),
     *                  @OA\Property(type="object", property="createdAt"),
     *              ),
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getLocalNotifications(): JsonResponse
    {
        $result = $this->notificationLocalService->getLocalNotifications($this->getUserId());

        return $this->response($result, self::FETCH);
    }
}
