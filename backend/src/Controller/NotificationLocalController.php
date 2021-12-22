<?php

namespace App\Controller;
use App\AutoMapping;
use App\Service\NotificationLocalService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;


class NotificationLocalController extends BaseController
{
    private $notificationLocalService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, NotificationLocalService $notificationLocalService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->notificationLocalService = $notificationLocalService;
    }

    /**
     * @Route("notificationLocal/{id}", name="getLocalNotificationById", methods={"GET"})
     * @param $id
     * @return JsonResponse
     */
    public function getLocalNotificationById($id)
    {
        $result = $this->notificationLocalService->getLocalNotificationById($id);

        return $this->response($result, self::FETCH);
    }

     /**
     * @Route("notificationsLocal", name="getLocalNotifications", methods={"GET"})
     * @IsGranted("ROLE_CLIENT")
     * @return JsonResponse
     */
    public function getLocalNotifications()
    {
        $result = $this->notificationLocalService->getLocalNotifications($this->getUserId());

        return $this->response($result, self::FETCH);
    }
}
