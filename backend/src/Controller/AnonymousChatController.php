<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\AnonymousChatCreateRequest;
use App\Service\AnonymousChatService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use OpenApi\Annotations as OA;

class AnonymousChatController extends BaseController
{
    private $autoMapping;
    private $anonymousChatService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, AnonymousChatService $anonymousChatService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->anonymousChatService = $anonymousChatService;
    }

    /**
     * create new chat with dashboard by anonymous user
     * @Route("anonymouschat", name="createChatWithDashboardByAnonymousUser", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Anonymous Chat")
     *
     * @OA\RequestBody(
     *      description="Create new chat with dashboard by anonymous user",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="name"),
     *          @OA\Property(type="string", property="roomID"),
     *          @OA\Property(type="boolean", property="needSupport"),
     *          @OA\Property(type="string", property="token")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the creation date of the chat",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="object", property="createdAt")
     *          )
     *      )
     * )
     */
    public function createAnonymousChat(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AnonymousChatCreateRequest::class, (object)$data);

        $result = $this->anonymousChatService->createAnonymousChat($request);

        return $this->response($result, self::CREATE);
    }

}