<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\ClientProfileCreateRequest;
use App\Request\ClientProfileUpdateRequest;
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
     * @Route("/clientregister", name="clientRegister", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
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
     * @Route("/clientprofile", name="updateClientProfile", methods={"PUT"})
     * @IsGranted("ROLE_CLIENT")
     * @param Request $request
     * @return JsonResponse
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
     * @Route("/clientProfile", name="getClientProfileByClientID",methods={"GET"})
     * @IsGranted("ROLE_CLIENT")
     * @return JsonResponse
     */
    public function getClientProfileByClientID()
    {
        $response = $this->clientProfileService->getClientProfileByClientID($this->getUserId());

        return $this->response($response, self::FETCH);
    }

    /**
     * @Route("/clientprofilebyid/{id}", name="getClientProfileByIDViewTheLatest25Clients",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     */
    public function getClientProfileByID($id)
    {
        $response = $this->clientProfileService->getClientProfileByID($id);

        return $this->response($response, self::FETCH);
    }

    /**
     * @Route("/clientsprofile", name="getClientsProfile",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
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
     * @Route("/clientfilterbyname/{name}", name="getClientsByName", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     */
    public function clientsByName($name): JsonResponse
    {
        $result = $this->clientProfileService->clientsByName($name);

        return $this->response($result, self::FETCH);
    }
}
