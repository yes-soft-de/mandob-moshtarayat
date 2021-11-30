<?php

namespace App\Controller;

use App\AutoMapping;
use App\Service\UserService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;

class UserController extends BaseController
{
    private $userService;
   
    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, UserService $userService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->userService = $userService;     
    }

     /**
      * Check user type.
     * @Route("/checkUserType/{userType}", name="checkUserType", methods={"POST"})
     * @return JsonResponse
      * *
      * @OA\Tag(name="Check User")
      *
      * @OA\Parameter(
      *      name="token",
      *      in="header",
      *      description="token to be passed as a header",
      *      required=true
      * )
      *
      * @OA\Parameter(
      *      name="userType",
      *      in="path",
      *      description="ROLE_CLIENT or ROLE_CAPTAIN"
      * )
      *
      * @OA\Response(
      *      response=200,
      *      description="Return String",
      *      @OA\JsonContent(
      *          @OA\Property(type="string", property="status_code"),
      *          @OA\Property(type="string", property="msg"),
      *          @OA\Property(type="string", property="Data"),
      *      )
      * )
      * @Security(name="Bearer")
      */
    public function checkUserType($userType)
    {
        $response = $this->userService->checkUserType($userType,$this->getUserId());
        if($response == "yes"){
            $response ="yes is"." ".$userType;
            return $this->response($response, self::CREATE); 
          }

        if($response == "no"){
            $response ="no not a"." ".$userType;
            return $this->response($response, self::ERROR_USER_CHECK); 
          }
    }
}
