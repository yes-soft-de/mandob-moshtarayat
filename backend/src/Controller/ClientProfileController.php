<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\ClientByUserIdGetRequest;
use App\Request\ClientProfileNeedSupportUpdateRequest;
use App\Request\ClientProfileUpdateRequest;
use App\Request\ClientUpdateFavouriteCategoriesRequest;
use App\Request\UserRegisterRequest;
use App\Service\ClientProfileService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;

class ClientProfileController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $clientProfileService;
   
    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, ClientProfileService $clientProfileService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->clientProfileService = $clientProfileService;     
    }

     /**
      * Create new client.
     * @Route("/clientregister", name="clientRegister", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
      * *
      * @OA\Tag(name="Client")
      *
      * @OA\RequestBody(
      *      description="Create new client",
      *      @OA\JsonContent(
      *          @OA\Property(type="string", property="userName"),
      *          @OA\Property(type="string", property="userID"),
      *          @OA\Property(type="string", property="password"),
      *      )
      * )
      *
      * @OA\Response(
      *      response=201,
      *      description="Returns the new client's role and the creation date",
      *      @OA\JsonContent(
      *          @OA\Property(type="string", property="status_code"),
      *          @OA\Property(type="string", property="msg"),
      *          @OA\Property(type="object", property="Data",
      *                  @OA\Property(type="array", property="roles",
      *                      @OA\Items(example="user")),
      *                  @OA\Property(type="object", property="createdAt")
      *          )
      *      )
      * )
      */
    public function clientRegister(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        
        $request = $this->autoMapping->map(stdClass::class, UserRegisterRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->clientProfileService->clientRegister($request);
        $isArray = is_array($response);
        if($isArray){
            $found = isset($response['found']);
            if( $found == "yes"){
                return $this->response($response, self::ERROR_USER_FOUND); 
          }
        }
        return $this->response($response, self::CREATE);
    }

    /**
     * client: Update client profile.
     * @Route("/clientprofile", name="updateClientProfile", methods={"PUT"})
     * @IsGranted("ROLE_CLIENT")
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Client")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update client profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="clientName"),
     *          @OA\Property(type="string", property="image"),
     *          @OA\Property(type="object", property="location"),
     *          @OA\Property(type="string", property="phone"),
     *          @OA\Property(type="string", property="nationalAddress"),
     *          @OA\Property(type="string", property="recordNumber"),
     *          @OA\Property(type="string", property="taxNumber"),
     *          @OA\Property(type="string", property="qrCode"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns client",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="integer", property="clientID"),
     *                  @OA\Property(type="string", property="clientName"),
     *                  @OA\Property(type="string", property="roomID"),
     *                  @OA\Property(type="string", property="phone"),
     *                  @OA\Property(type="string", property="image"),
     *                  @OA\Property(type="object", property="location"),
     *                  @OA\Property(type="string", property="nationalAddress"),
     *                  @OA\Property(type="string", property="recordNumber"),
     *                  @OA\Property(type="string", property="taxNumber"),
     *                  @OA\Property(type="string", property="qrCode"),
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateClientProfile(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, ClientProfileUpdateRequest::class, (object)$data);
        $request->setClientID($this->getUserId());

        $response = $this->clientProfileService->updateClientProfile($request);

        return $this->response($response, self::UPDATE);
    }

    /**
     * client: Get client profile.
     * @Route("/clientProfile", name="getClientProfileByClientID",methods={"GET"})
     * @IsGranted("ROLE_CLIENT")
     * @return JsonResponse
     * *
     * @OA\Tag(name="Client")
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
     *      description="Get client profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="integer", property="clientID"),
     *                  @OA\Property(type="string", property="clientName"),
     *                  @OA\Property(type="string", property="roomID"),
     *                  @OA\Property(type="string", property="phone"),
     *                  @OA\Property(type="string", property="image"),
     *                  @OA\Property(type="string", property="imageURL"),
     *                  @OA\Property(type="string", property="baseURL"),
     *                  @OA\Property(type="jsone", property="location"),
     *                  @OA\Property(type="array", property="favouriteCategories",
     *                      @OA\Items(),
     *              ),
     *                  @OA\Property(type="string", property="nationalAddress"),
     *                  @OA\Property(type="string", property="recordNumber"),
     *                  @OA\Property(type="string", property="taxNumber"),
     *                  @OA\Property(type="string", property="qrCode"),
     *                  @OA\Property(type="string", property="qrCodeBase64"),
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getClientProfileByClientID()
    {
        $response = $this->clientProfileService->getClientProfileByClientID($this->getUserId());

        return $this->response($response, self::FETCH);
    }

    /**
     * admin: Get client's profile by profileID.
     * @Route("/clientprofilebyid/{id}", name="getClientProfileByProfileID",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     * *
     * @OA\Tag(name="Client")
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
     *      description="Get client's profile by profileID, for admin",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="integer", property="clientID"),
     *                  @OA\Property(type="string", property="clientName"),
     *                  @OA\Property(type="string", property="roomID"),
     *                  @OA\Property(type="string", property="phone"),
     *                  @OA\Property(type="string", property="image"),
     *                  @OA\Property(type="string", property="imageURL"),
     *                  @OA\Property(type="string", property="baseURL"),
     *                  @OA\Property(type="object", property="location"),
     *                  @OA\Property(type="object", property="statistics"),
     *                  @OA\Property(type="string", property="nationalAddress"),
     *                  @OA\Property(type="string", property="recordNumber"),
     *                  @OA\Property(type="string", property="taxNumber"),
     *                  @OA\Property(type="string", property="qrCode"),
     *                  @OA\Property(type="string", property="qrCodeURL"),
     *                  @OA\Property(type="string", property="qrCodeBase64"),
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getClientProfileByID($id)
    {
        $response = $this->clientProfileService->getClientProfileByID($id);

        return $this->response($response, self::FETCH);
    }

    /**
     * admin: Get client's info by roomID
     * @Route("clientinfobyuserid", name="getClientInfoByUserID", methods={"POST"})
     * @IsGranted("ROLE_CLIENT")
     * @return JsonResponse
     * *
     * @OA\Tag(name="Client")
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
     *      description="Get client's profile by profileID, for admin",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="clientName"),
     *                  @OA\Property(type="string", property="roomID"),
     *                  @OA\Property(type="string", property="image")
     *          )
     *      )
     * )
     * @Security(name="Bearer")
     */
    public function getClientByRoomID(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, ClientByUserIdGetRequest::class, (object)$data);

        $request->setClientID($this->getUserId());

        $response = $this->clientProfileService->getClientByUserID($this->getUserId());

        return $this->response($response, self::FETCH);
    }

    /**
     * client
     * @Route("updateneedsupport", name="updateNeedSupport", methods={"PUT"})
     * @IsGranted("ROLE_CLIENT")
     * @return JsonResponse
     *
     * @OA\Tag(name="Client")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update client profile need support field",
     *      @OA\JsonContent(
     *          @OA\Property(type="boolean", property="needSupport")
     *      )
     * )
     *
     * @OA\Response(
     *      response="default",
     *      description="Get client's profile by profileID, for admin",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="boolean", property="needSupport"),
     *                  @OA\Property(type="string", property="clientName"),
     *                  @OA\Property(type="string", property="status")
     *          )
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Get client's profile by profileID, for admin",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9210"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="boolean", property="needSupport"),
     *                  @OA\Property(type="string", property="clientName"),
     *                  @OA\Property(type="string", property="status", example="noClientProfileWasFound")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateClientProfileNeedSupport(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, ClientProfileNeedSupportUpdateRequest::class, (object)$data);

        $request->setClientID($this->getUserId());

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->clientProfileService->updateClientProfileNeedSupport($request);

        if ($response->status == 'noClientProfileWasFound')
        {
            return $this->response($response, self::CLIENT_PROFILE_NOT_EXIST);
        }

        return $this->response($response, self::UPDATE);
    }

    /**
     * admin: Get client's profile.
     * @Route("/clientsprofile", name="getClientsProfile",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     * *
     * @OA\Tag(name="Client")
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
     *      description="Get client's profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *     @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="integer", property="clientID"),
     *                  @OA\Property(type="string", property="clientName"),
     *                  @OA\Property(type="string", property="phone"),
     *                  @OA\Property(type="string", property="image"),
     *                  @OA\Property(type="string", property="imageURL"),
     *                  @OA\Property(type="string", property="baseURL"),
     *              ),
     *          )
     *      )
     * )
     * @Security(name="Bearer")
     */
    public function getClientsProfile()
    {
        $response = $this->clientProfileService->getClientsProfile();

        return $this->response($response, self::FETCH);
    }

     /**
     * @Route("/clientFilter/{itemName}", name="getStoresAndProducts", methods={"GET"})
     */
    public function clientFilter($itemName)
    {
        $result = $this->clientProfileService->clientFilter($itemName);

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: Filter client by name.
     * @Route("/clientfilterbyname/{name}", name="getClientsByName", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * *
     * @OA\Tag(name="Client")
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
     *      description="Filter client by name, for admin",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *     @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="integer", property="clientID"),
     *                  @OA\Property(type="string", property="clientName"),
     *                  @OA\Property(type="string", property="phone"),
     *                  @OA\Property(type="string", property="image"),
     *                  @OA\Property(type="string", property="imageURL"),
     *                  @OA\Property(type="string", property="baseURL"),
     *              ),
     *          )
     *      )
     * )
     * @Security(name="Bearer")
     */
    public function clientsByName($name): JsonResponse
    {
        $result = $this->clientProfileService->clientsByName($name);

        return $this->response($result, self::FETCH);
    }


    /**
     * client: Update client's favourite categories.
     * @Route("/updateclientfavouritecategories", name="updateClientFavouriteCategories", methods={"PUT"})
     * @IsGranted("ROLE_CLIENT")
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Client")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update client's favourite categories",
     *      @OA\JsonContent(
     *          @OA\Property(type="array", property="favouriteCategories", @OA\Items( ),),
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Get client's favourite categories",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="array", property="favouriteCategories",
     *                        @OA\Items( ),
     *              ),
     *          )
     *      )
     * )
     * @Security(name="Bearer")
     */
    public function updateClientFavouriteCategories(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, ClientUpdateFavouriteCategoriesRequest::class, (object)$data);
        $request->setClientID($this->getUserId());

        $response = $this->clientProfileService->updateClientFavouriteCategories($request);

        return $this->response($response, self::UPDATE);
    }

    /**
     * admin: Get all clients and anonymous users who need support
     * @Route("clientwhoneedsupport", name="getClientsWhoNeedSupport", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Client")
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
     *      description="Get client's profile info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="clientName"),
     *                  @OA\Property(type="string", property="image"),
     *                  @OA\Property(type="string", property="roomID")
     *              ),
     *          )
     *      )
     * )
     * @Security(name="Bearer")
     */
    public function getClientProfileWhoNeedSupport()
    {
        $response = $this->clientProfileService->getClientProfileWhoNeedSupport();

        return $this->response($response, self::FETCH);
    }
}
