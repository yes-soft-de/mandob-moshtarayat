<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\FilterUserRequest;
use App\Service\UserService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;

class UserController extends BaseController
{
    private $autoMapping;
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
      *      response=201,
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

    /**
     * For testing issues
     *
     * @Route("updateallstoreownersverificationstatus", name="updateAllStoreOwnersVerificationStatus", methods={"PUT"})
     */
    public function updateAllStoreOwnersVerificationStatusByDeveloper()
    {
        $response = $this->userService->updateAllStoreOwnersVerificationStatusByDeveloper();

        return $this->response($response, self::UPDATE);
    }

    /**
     * For testing issues
     *
     * @Route("updateallclientsverificationstatus", name="updateAllClientsVerificationStatus", methods={"PUT"})
     */
    public function updateAllClientsVerificationStatusByDeveloper()
    {
        $response = $this->userService->updateAllClientsVerificationStatusByDeveloper();

        return $this->response($response, self::UPDATE);
    }

    /**
     * For testing issues
     *
     * @Route("updateallcaptainsverificationstatus", name="updateAllCaptainsVerificationStatus", methods={"PUT"})
     */
    public function updateAllCaptainsVerificationStatusByDeveloper()
    {
        $response = $this->userService->updateAllCaptainsVerificationStatusByDeveloper();

        return $this->response($response, self::UPDATE);
    }

    /**
     * For testing issues
     *
     * @Route("getallstoreownersusers", name="getAllStoreOwnersUsers", methods={"GET"})
     */
    public function getAllStoreOwners()
    {
        $response = $this->userService->getAllStoreOwners();

        return $this->response($response, self::FETCH);
    }

    /**
     * For testing issues
     *
     * @Route("deleteuser/{id}", name="deleteUserByID", methods={"DELETE"})
     */
    public function deleteUserById($id)
    {
        $response = $this->userService->deleteUserById($id);

        return $this->response($response, self::DELETE);
    }

    /**
     * For testing issues
     *
     * @Route("filterusers", name="filterusers", methods={"POST"})
     */
    public function filterUsers(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, FilterUserRequest::class, (object)$data);

        $response = $this->userService->filterUsers($request);

        return $this->response($response, self::FETCH);
    }
}
