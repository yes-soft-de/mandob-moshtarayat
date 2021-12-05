<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\CaptainProfileUpdateRequest;
use App\Request\CaptainProfileUpdateLocationRequest;
use App\Request\CaptainProfileUpdateByAdminRequest;
use App\Request\UserRegisterRequest;
use App\Service\CaptainProfileService;
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

class CaptainProfileController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $captainProfileService;   

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, CaptainProfileService $captainProfileService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->captainProfileService = $captainProfileService;
        
    }

     /**
     * Create new captain.
     * @Route("/captainregister", name="captainRegister", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
      * *
      * @OA\Tag(name="Captain Profile")
      *
      * @OA\RequestBody(
      *      description="Create new captain",
      *      @OA\JsonContent(
      *          @OA\Property(type="string", property="userName"),
      *          @OA\Property(type="string", property="userID"),
      *          @OA\Property(type="string", property="password"),
      *      )
      * )
      *
      * @OA\Response(
      *      response=200,
      *      description="Returns the new captain's role and the creation date",
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
      *
      */
    public function captainRegister(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);
        
        $request = $this->autoMapping->map(stdClass::class, UserRegisterRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->captainProfileService->captainRegister($request);
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
     * captain: Update captain profile.
     * @Route("/captainprofile", name="captainProfileUpdate", methods={"PUT"})
     * @IsGranted("ROLE_CAPTAIN")
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Captain Profile")
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     * @OA\RequestBody(
     *      description="Update captain profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="captainName"),
     *          @OA\Property(type="string", property="drivingLicence"),
     *          @OA\Property(type="string", property="image"),
     *          @OA\Property(type="string", property="mechanicLicense"),
     *          @OA\Property(type="string", property="identity"),
     *          @OA\Property(type="integer", property="age"),
     *          @OA\Property(type="string", property="car"),
     *          @OA\Property(type="string", property="bankName"),
     *          @OA\Property(type="string", property="bankAccountNumber"),
     *          @OA\Property(type="string", property="stcPay"),
     *          @OA\Property(type="string", property="phone"),
     *          @OA\Property(type="string", property="isOnline"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns captain profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="string", property="captainName"),
     *              @OA\Property(type="string", property="drivingLicence"),
     *              @OA\Property(type="string", property="image"),
     *              @OA\Property(type="string", property="mechanicLicense"),
     *              @OA\Property(type="string", property="identity"),
     *              @OA\Property(type="integer", property="age"),
     *              @OA\Property(type="string", property="car"),
     *              @OA\Property(type="string", property="bankName"),
     *              @OA\Property(type="string", property="bankAccountNumber"),
     *              @OA\Property(type="string", property="stcPay"),
     *              @OA\Property(type="string", property="phone"),

     *          )
     *      )
     * )
     * @Security(name="Bearer")
     */
    public function updateCaptainProfile(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, CaptainProfileUpdateRequest::class, (object)$data);
        $request->setUserID($this->getUserId());

        $response = $this->captainProfileService->updateCaptainProfile($request);

        return $this->response($response, self::UPDATE);  
    }

    /**
     * captain: Update captain location.
     * @Route("/captainProfileUpdateLocation", name="captainProfileUpdateLocation", methods={"PUT"})
     * @IsGranted("ROLE_CAPTAIN")
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Captain Profile")
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update captain location",
     *      @OA\JsonContent(
     *          @OA\Property(type="object", property="location"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns captain profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="string", property="id"),
     *              @OA\Property(type="string", property="captainName"),
     *              @OA\Property(type="object", property="location"),
     *              @OA\Property(type="string", property="drivingLicence"),
     *              @OA\Property(type="string", property="image"),
     *              @OA\Property(type="string", property="mechanicLicense"),
     *              @OA\Property(type="string", property="identity"),
     *              @OA\Property(type="integer", property="age"),
     *              @OA\Property(type="string", property="car"),
     *              @OA\Property(type="string", property="bankName"),
     *              @OA\Property(type="string", property="bankAccountNumber"),
     *              @OA\Property(type="string", property="stcPay"),
     *              @OA\Property(type="string", property="phone"),

     *          )
     *      )
     * )
     * @Security(name="Bearer")
     */
    public function captainProfileUpdateLocation(Request $request): JsonResponse
    {
        $response="error lon or lat";
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, CaptainProfileUpdateLocationRequest::class, (object)$data);
        $request->setUserID($this->getUserId());

        $lon = isset($request->getLocation()["lon"]);
        $lat = isset($request->getLocation()["lat"]);

        if( $lon == true && $lat == true) {
            $response = $this->captainProfileService->captainProfileUpdateLocation($request);
            return $this->response($response, self::UPDATE);
        }

        return $this->response($response, self::ERROR);
    }
  
    /**
     * admin: Update captain profile by admin.
     * @Route("/captainprofileupdatebyadmin", name="captainProfileUpdateByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     **
     * @OA\Tag(name="Captain Profile")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update captain profile by admin",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="captainID"),
     *          @OA\Property(type="string", property="salary"),
     *          @OA\Property(type="string", property="status"),
     *          @OA\Property(type="integer", property="bounce"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns captain profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="string", property="id"),
     *              @OA\Property(type="string", property="captainName"),
     *              @OA\Property(type="object", property="location"),
     *              @OA\Property(type="string", property="drivingLicence"),
     *              @OA\Property(type="string", property="image"),
     *              @OA\Property(type="string", property="mechanicLicense"),
     *              @OA\Property(type="string", property="identity"),
     *              @OA\Property(type="integer", property="age"),
     *              @OA\Property(type="string", property="car"),
     *              @OA\Property(type="string", property="bankName"),
     *              @OA\Property(type="string", property="bankAccountNumber"),
     *              @OA\Property(type="string", property="stcPay"),
     *              @OA\Property(type="string", property="phone"),

     *          )
     *      )
     * )
     * @Security(name="Bearer")
     */
    public function updateCaptainProfileByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, CaptainProfileUpdateByAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->captainProfileService->UpdateCaptainProfileByAdmin($request);

        return $this->response($response, self::UPDATE);
    }
    
    /**
     * captain: Get captain's profile.
     * @Route("/captainprofile", name="getCaptainprofileByCaptainID",methods={"GET"})
     * @IsGranted("ROLE_CAPTAIN")
     *  @return JsonResponse
     * *
     * @OA\Tag(name="Captain Profile")
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
     *      description="Get captain's profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="string", property="id"),
     *              @OA\Property(type="string", property="captainID"),
     *              @OA\Property(type="string", property="captainName"),
     *              @OA\Property(type="object", property="location"),
     *              @OA\Property(type="integer", property="age"),
     *              @OA\Property(type="string", property="car"),
     *              @OA\Property(type="string", property="drivingLicence"),
     *              @OA\Property(type="string", property="drivingLicenceURL"),
     *              @OA\Property(type="integer", property="salary"),
     *              @OA\Property(type="string", property="status"),
     *              @OA\Property(type="string", property="image"),
     *              @OA\Property(type="string", property="imageURL"),
     *              @OA\Property(type="string", property="baseURL"),
     *              @OA\Property(type="string", property="phone"),
     *              @OA\Property(type="string", property="isOnline"),
     *              @OA\Property(type="string", property="bankName"),
     *              @OA\Property(type="string", property="bankAccountNumber"),
     *              @OA\Property(type="string", property="stcPay"),
     *              @OA\Property(type="string", property="vacationStatus"),
     *              @OA\Property(type="string", property="mechanicLicense"),
     *              @OA\Property(type="string", property="identity"),
     *              @OA\Property(type="object", property="createDate"),
     *               )
     *          )
     *      )
     * )
     * @Security(name="Bearer")
     */
    public function getCaptainProfileByCaptainID(): JsonResponse
    {
        $response = $this->captainProfileService->getCaptainProfileByCaptainID($this->getUserId());

        return $this->response($response, self::FETCH);
    }

    /**
     * admin:Get captain's profile.
     * @Route("/captainProfile/{captainID}", name="getCaptainProfileByCaptainIDForAdmin",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param $captainID
     * @return JsonResponse
     * *
     * @OA\Tag(name="Captain Profile")
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
     *      description="Get captain's profile for admin",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="string", property="id"),
     *              @OA\Property(type="string", property="captainID"),
     *              @OA\Property(type="string", property="captainName"),
     *              @OA\Property(type="object", property="location"),
     *              @OA\Property(type="integer", property="age"),
     *              @OA\Property(type="string", property="car"),
     *              @OA\Property(type="string", property="drivingLicence"),
     *              @OA\Property(type="string", property="drivingLicenceURL"),
     *              @OA\Property(type="integer", property="salary"),
     *              @OA\Property(type="string", property="status"),
     *              @OA\Property(type="string", property="rating"),
     *              @OA\Property(type="string", property="image"),
     *              @OA\Property(type="string", property="imageURL"),
     *              @OA\Property(type="string", property="baseURL"),
     *              @OA\Property(type="string", property="phone"),
     *              @OA\Property(type="string", property="isOnline"),
     *              @OA\Property(type="string", property="bankName"),
     *              @OA\Property(type="string", property="bankAccountNumber"),
     *              @OA\Property(type="string", property="stcPay"),
     *              @OA\Property(type="string", property="vacationStatus"),
     *              @OA\Property(type="string", property="mechanicLicense"),
     *              @OA\Property(type="string", property="identity"),
     *              @OA\Property(type="object", property="createDate"),
     *               )
     *          )
     *      )
     * )
     * @Security(name="Bearer")
     */
    public function getCaptainProfileByCaptainIDForAdmin($captainID): JsonResponse
    {
        $response = $this->captainProfileService->getCaptainProfileByCaptainIDForAdmin($captainID);

        return $this->response($response, self::FETCH);
    }

    /**
     * admin: Get inactive captains.
     * @Route("/getcaptainsinactive", name="getCaptainsPending",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     *  @return JsonResponse
     * *
     * @OA\Tag(name="Captain Profile")
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
     *      description="Get inactive captains for admin",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *            @OA\Items(
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="captainID"),
     *              @OA\Property(type="string", property="captainName"),
     *              @OA\Property(type="object", property="image",
     *                 @OA\Property(type="string", property="imageURL"),
     *                 @OA\Property(type="string", property="baseURL"),
     *              ),
     *                   )
     *              )
     *          )
     *      )
     * )
     * @Security(name="Bearer")
     */
    public function getCaptainsInactive(): JsonResponse
    {
        $response = $this->captainProfileService->getCaptainsInactive();

        return $this->response($response, self::FETCH);
    }

    /**
     * @Route("/dashboardcaptains", name="dashboardCaptains",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     */
    public function dashboardCaptains(): JsonResponse
    {
        $result = $this->captainProfileService->dashboardCaptains();

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/getdayofcaptains", name="getDayOfCaptains",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     */
    public function getCaptainsInVacation(): JsonResponse
    {
        $result = $this->captainProfileService->getCaptainsInVacation();

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: Get captains.
     * @Route("/captains", name="getCaptains",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     * *
     * @OA\Tag(name="Captain Profile")
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
     *      description="Get captains for admin",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *            @OA\Items(
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="captainID"),
     *              @OA\Property(type="string", property="captainName"),
     *              @OA\Property(type="object", property="image",
     *                 @OA\Property(type="string", property="imageURL"),
     *                 @OA\Property(type="string", property="baseURL"),
     *                      ),
     *                   )
     *              )
     *          )
     *      )
     * )
     * @Security(name="Bearer")
     */
    public function getAllCaptains(): JsonResponse
    {
        $response = $this->captainProfileService->getAllCaptains();

        return $this->response($response, self::FETCH);
    }

     /**
      * admin:Get the remaining captains have payments.
     * @Route("/captainsRemainingForItAmount", name="captainsRemainingForItAmount",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
      * *
      * @OA\Tag(name="Captain Profile")
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
      *      description="Get the remaining captains have payments",
      *      @OA\JsonContent(
      *          @OA\Property(type="string", property="status_code"),
      *          @OA\Property(type="string", property="msg"),
      *          @OA\Property(type="array", property="Data",
      *            @OA\Items(
      *              @OA\Property(type="integer", property="id"),
      *              @OA\Property(type="string", property="captainID"),
      *              @OA\Property(type="string", property="captainName"),
      *              @OA\Property(type="string", property="roomID"),
      *              @OA\Property(type="string", property="image"),
      *              @OA\Property(type="string", property="phone"),
      *              @OA\Property(type="string", property="remainingAmountForCaptain"),
      *                   )
      *              )
      *          )
      *      )
      * )
      * @Security(name="Bearer")
      */
    public function captainsRemainingForItAmount(): JsonResponse
    {
        $response = $this->captainProfileService->captainsRemainingForItAmount();

        return $this->response($response, self::FETCH);
    }

     /**
      * admin:Get captains remaining on it amount.
     * @Route("/captainsRemainingOnItAmount ", name="captainsRemainingOnItAmount",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
      * *
      * @OA\Tag(name="Captain Profile")
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
      *      description="Get captains remaining on it amount",
      *      @OA\JsonContent(
      *          @OA\Property(type="string", property="status_code"),
      *          @OA\Property(type="string", property="msg"),
      *          @OA\Property(type="object", property="Data",
      *              @OA\Property(type="integer", property="totalAmountForCompany"),
      *              @OA\Property(type="array", property="captains",
      *             @OA\Items(
      *              @OA\Property(type="integer", property="id"),
      *              @OA\Property(type="string", property="captainID"),
      *              @OA\Property(type="string", property="captainName"),
      *              @OA\Property(type="string", property="roomID"),
      *              @OA\Property(type="string", property="image"),
      *              @OA\Property(type="string", property="phone"),
      *              @OA\Property(type="string", property="remainingAmountForCompany"),
      *                     ),
      *                 )
      *              )
      *          )
      *      )
      * )
      * @Security(name="Bearer")
      */
    public function captainsRemainingOnItAmount(): JsonResponse
    {
        $response = $this->captainProfileService->captainsRemainingOnItAmount();

        return $this->response($response, self::FETCH);
    }

    /**
     * @Route("/captainupdatenewmessagestatus", name="captainUpdateNewMessageStatus", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function updateCaptainNewMessageStatus(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,CaptainProfileUpdateByAdminRequest::class,(object)$data);
        
        $response = $this->captainProfileService->updateCaptainNewMessageStatus($request,false);

        return $this->response($response, self::UPDATE);
    }

    /**
     * Get top 5 captains.
     * @Route("/gettop5captains", name="GetTop5Captains",methods={"GET"})
     * @return JsonResponse
     * *
     * @OA\Tag(name="Captain Profile")
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
     *      description="Get top 5 captains",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *             @OA\Items(
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="captainID"),
     *              @OA\Property(type="string", property="captainName"),
     *              @OA\Property(type="string", property="car"),
     *              @OA\Property(type="string", property="age"),
     *              @OA\Property(type="string", property="salary"),
     *              @OA\Property(type="string", property="bounce"),
     *              @OA\Property(type="string", property="image"),
     *              @OA\Property(type="string", property="countOrdersDeliverd"),
     *                     ),
     *              )
     *          )
     *      )
     * )
     * @Security(name="Bearer")
     */
    public function getTop5Captains(): JsonResponse
    {
        $result = $this->captainProfileService->getTop5Captains();

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/topCaptains", name="getTopCaptainsInThisMonth",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     */
    public function getTopCaptainsInLastMonthDate(): JsonResponse
    {
        $result = $this->captainProfileService->getTopCaptainsInLastMonthDate();

        return $this->response($result, self::FETCH);
    }

    /**
     * captain: Get captain's balance.
     * @Route("/captainFinancialAccount", name="getCaptainMyBalance",methods={"GET"})
     * @IsGranted("ROLE_CAPTAIN")
     *  @return JsonResponse
     * *
     * @OA\Tag(name="Captain Profile")
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
     *      description="Get captain's balance",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *             @OA\Items(
     *              @OA\Property(type="number", property="sumPaymentsFromCompany"),
     *              @OA\Property(type="number", property="sumPaymentsToCompany"),
     *              @OA\Property(type="integer", property="countOrdersDelivered"),
     *              @OA\Property(type="number", property="sumInvoiceAmount"),
     *              @OA\Property(type="number", property="deliveryCost"),
     *              @OA\Property(type="number", property="amountYouOwn"),
     *              @OA\Property(type="number", property="remainingAmountForCompany"),
     *              @OA\Property(type="number", property="salary"),
     *              @OA\Property(type="number", property="bounce"),
     *              @OA\Property(type="number", property="kilometerBonus"),
     *              @OA\Property(type="number", property="netProfit"),
     *              @OA\Property(type="number", property="total"),
     *                   ),
     *              )
     *          )
     *      )
     * )
     * @Security(name="Bearer")
     */
    public function getCaptainFinancialAccountDetailsByCaptainId(): JsonResponse
    {
        $response = $this->captainProfileService->getCaptainFinancialAccountDetailsByCaptainId($this->getUserId());

        return $this->response($response, self::FETCH);
    }

    /**
     * captain: Get captain's financial account in last month.
     * @Route("/captainFinancialAccountInLastMonth", name="captainFinancialAccountInLastMonth",methods={"GET"})
     * @IsGranted("ROLE_CAPTAIN")
     *  @return JsonResponse
     * *
     * @OA\Tag(name="Captain Profile")
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
     *      description="Get captain's financial account in last month",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *             @OA\Items(
     *              @OA\Property(type="number", property="sumPaymentsFromCompany"),
     *              @OA\Property(type="number", property="sumPaymentsToCompany"),
     *              @OA\Property(type="integer", property="countOrdersDelivered"),
     *              @OA\Property(type="number", property="sumInvoiceAmount"),
     *              @OA\Property(type="number", property="deliveryCost"),
     *              @OA\Property(type="array", property="paymentsFromCompany",
     *                  @OA\Items(
     *                          @OA\Property(type="integer", property="id"),
     *                          @OA\Property(type="string", property="captainId"),
     *                          @OA\Property(type="number", property="amount"),
     *                          @OA\Property(type="object", property="date"),
     *                          @OA\Property(type="string", property="note"),
     *                  ),),
     *              @OA\Property(type="number", property="amountYouOwn"),
     *              @OA\Property(type="number", property="remainingAmountForCompany"),
     *              @OA\Property(type="number", property="bounce"),
     *              @OA\Property(type="number", property="kilometerBonus"),
     *              @OA\Property(type="number", property="netProfit"),
     *              @OA\Property(type="number", property="total"),
     *                   ),
     *              )
     *          )
     *      )
     * )
     * @Security(name="Bearer")
     */
    public function captainFinancialAccountInLastMonth(): JsonResponse
    {
        $response = $this->captainProfileService->captainFinancialAccountInLastMonth($this->getUserId());

        return $this->response($response, self::FETCH);
    }

    /**
     * @Route("/captainFinancialAccountInSpecificDate/{fromDate}/{toDate}", name="captainFinancialAccountInSpecificDate",methods={"GET"})
     * @IsGranted("ROLE_CAPTAIN")
     *  @return JsonResponse
     */
    public function captainFinancialAccountInSpecificDate($fromDate, $toDate): JsonResponse
    {
        $response = $this->captainProfileService->captainFinancialAccountInSpecificDate($this->getUserId(), $fromDate, $toDate);

        return $this->response($response, self::FETCH);
    }

    /**
     * captain: Get Count Orders Captain Delivered In Today.
     * @Route("/countOrdersCaptainDeliveredInToday", name="countOrdersCaptainDeliveredInToday",methods={"GET"})
     * @IsGranted("ROLE_CAPTAIN")
     *  @return JsonResponse
     * *
     * @OA\Tag(name="Captain Profile")
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
     *      description="Get Count Orders Captain Delivered In Today",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *          @OA\Property(type="integer", property="countOrdersDeliveredInToday"),
     *
     *              )
     *          )
     *      )
     * )
     * @Security(name="Bearer")
     */
    public function countOrdersCaptainDeliveredInToday(): JsonResponse
    {
        $response = $this->captainProfileService->countOrdersCaptainDeliveredInToday($this->getUserId());

        return $this->response($response, self::FETCH);
    }

    /**
     * admin: Get captain's financial account.
     * @Route("/captainFinancialAccountForAdmin/{captainID}", name="captainFinancialAccountForAdmin",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param $captainID
     * @return JsonResponse
     * *
     * @OA\Tag(name="Captain Profile")
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
     *      description="Get captain's financial account ,for admin",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *             @OA\Items(
     *              @OA\Property(type="number", property="sumPaymentsToCaptain"),
     *              @OA\Property(type="number", property="sumPaymentsFromCaptain"),
     *              @OA\Property(type="integer", property="countOrdersDelivered"),
     *              @OA\Property(type="number", property="sumInvoiceAmount"),
     *              @OA\Property(type="number", property="amountWithCaptain"),
     *              @OA\Property(type="number", property="deliveryCost"),
     *              @OA\Property(type="number", property="remainingAmountForCompany"),
     *              @OA\Property(type="number", property="bounce"),
     *              @OA\Property(type="number", property="kilometerBonus"),
     *              @OA\Property(type="number", property="salary"),
     *              @OA\Property(type="number", property="NetProfit"),
     *              @OA\Property(type="number", property="total"),
     *              @OA\Property(type="array", property="paymentsToCaptain",
     *                  @OA\Items(
     *                          @OA\Property(type="integer", property="id"),
     *                          @OA\Property(type="string", property="captainId"),
     *                          @OA\Property(type="number", property="amount"),
     *                          @OA\Property(type="object", property="date"),
     *                          @OA\Property(type="string", property="note"),
     *                  ),),
    *              @OA\Property(type="array", property="paymentsFromCaptain",
     *                  @OA\Items(
     *                          @OA\Property(type="integer", property="id"),
     *                          @OA\Property(type="string", property="captainId"),
     *                          @OA\Property(type="number", property="amount"),
     *                          @OA\Property(type="object", property="date"),
     *                          @OA\Property(type="string", property="note"),
     *                  ),),
     *                   )
     *              )
     *          )
     * )
     * @Security(name="Bearer")
     */
    public function getCaptainFinancialAccountDetailsByCaptainIdForAdmin($captainID): JsonResponse
    {
        $response = $this->captainProfileService->getCaptainFinancialAccountDetailsByCaptainIdForAdmin($captainID);

        return $this->response($response, self::FETCH);
    }

    /**
     * admin: Get captain's financial account in last month.
     * @Route("/captainFinancialAccountInLastMonthForAdmin/{captainID}", name="captainFinancialAccountInLastMonthForAdmin",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param $captainID
     * @return JsonResponse
     * *
     * @OA\Tag(name="Captain Profile")
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
     *      description="Get captain's financial account in last month ,for admin",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *             @OA\Items(
     *              @OA\Property(type="number", property="sumPaymentsToCaptain"),
     *              @OA\Property(type="number", property="sumPaymentsFromCaptain"),
     *              @OA\Property(type="integer", property="countOrdersDelivered"),
     *              @OA\Property(type="number", property="sumInvoiceAmount"),
     *              @OA\Property(type="number", property="amountWithCaptain"),
     *              @OA\Property(type="number", property="deliveryCost"),
     *              @OA\Property(type="number", property="remainingAmountForCompany"),
     *              @OA\Property(type="number", property="bounce"),
     *              @OA\Property(type="number", property="kilometerBonus"),
     *              @OA\Property(type="number", property="salary"),
     *              @OA\Property(type="number", property="NetProfit"),
     *              @OA\Property(type="number", property="total"),
     *              @OA\Property(type="array", property="paymentsToCaptain",
     *                  @OA\Items(
     *                          @OA\Property(type="integer", property="id"),
     *                          @OA\Property(type="string", property="captainId"),
     *                          @OA\Property(type="number", property="amount"),
     *                          @OA\Property(type="object", property="date"),
     *                          @OA\Property(type="string", property="note"),
     *                  ),),
     *              @OA\Property(type="array", property="paymentsFromCaptain",
     *                  @OA\Items(
     *                          @OA\Property(type="integer", property="id"),
     *                          @OA\Property(type="string", property="captainId"),
     *                          @OA\Property(type="number", property="amount"),
     *                          @OA\Property(type="object", property="date"),
     *                          @OA\Property(type="string", property="note"),
     *                  ),),
     *                   )
     *              )
     *          )
     * )
     * @Security(name="Bearer")
     */
    public function captainFinancialAccountInLastMonthForAdmin($captainID): JsonResponse
    {
        $response = $this->captainProfileService->captainFinancialAccountInLastMonthForAdmin($captainID);

        return $this->response($response, self::FETCH);
    }

     /**
      * admin: Get captain's financial account in specific date.
     * @Route("/captainFinancialAccountInSpecificDateForAdmin/{captainID}/{fromDate}/{toDate}", name="captainFinancialAccountInSpecificDateForAdmin",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     *  @return JsonResponse
      * *
      * @OA\Tag(name="Captain Profile")
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
      *      description="Get captain's financial account in specific date ,for admin",
      *      @OA\JsonContent(
      *          @OA\Property(type="string", property="status_code"),
      *          @OA\Property(type="string", property="msg"),
      *          @OA\Property(type="array", property="Data",
      *             @OA\Items(
      *              @OA\Property(type="number", property="sumPaymentsToCaptain"),
      *              @OA\Property(type="number", property="sumPaymentsFromCaptain"),
      *              @OA\Property(type="integer", property="countOrdersDelivered"),
      *              @OA\Property(type="number", property="sumInvoiceAmount"),
      *              @OA\Property(type="number", property="amountWithCaptain"),
      *              @OA\Property(type="number", property="deliveryCost"),
      *              @OA\Property(type="number", property="remainingAmountForCompany"),
      *              @OA\Property(type="number", property="bounce"),
      *              @OA\Property(type="number", property="kilometerBonus"),
      *              @OA\Property(type="number", property="salary"),
      *              @OA\Property(type="number", property="NetProfit"),
      *              @OA\Property(type="number", property="total"),
      *              @OA\Property(type="array", property="paymentsToCaptain",
      *                  @OA\Items(
      *                          @OA\Property(type="integer", property="id"),
      *                          @OA\Property(type="string", property="captainId"),
      *                          @OA\Property(type="number", property="amount"),
      *                          @OA\Property(type="object", property="date"),
      *                          @OA\Property(type="string", property="note"),
      *                  ),),
      *              @OA\Property(type="array", property="paymentsFromCaptain",
      *                  @OA\Items(
      *                          @OA\Property(type="integer", property="id"),
      *                          @OA\Property(type="string", property="captainId"),
      *                          @OA\Property(type="number", property="amount"),
      *                          @OA\Property(type="object", property="date"),
      *                          @OA\Property(type="string", property="note"),
      *                  ),),
      *                   )
      *              )
      *          )
      * )
      * @Security(name="Bearer")
      */
    public function captainFinancialAccountInSpecificDateForAdmin($captainID, $fromDate, $toDate)
    {
        $response = $this->captainProfileService->captainFinancialAccountInSpecificDateForAdmin($captainID, $fromDate, $toDate);

        return $this->response($response, self::FETCH);
    }

    /**
     * admin: Filter by captain's name.
     * @Route("/captainFilter/{name}", name="getCaptainsByName", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * *
     * @OA\Tag(name="Captain Profile")
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
     *      description="Filter by captain's name",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *          @OA\Property(type="array", property="captains",
     *            @OA\Items(
     *              @OA\Property(type="number", property="id"),
     *              @OA\Property(type="number", property="captainID"),
     *              @OA\Property(type="integer", property="captainName"),
     *              @OA\Property(type="number", property="image"),
     *                  )
     *              )
     *         )
     * )
     *)
     * @Security(name="Bearer")
     */
    public function captainFilter($name): JsonResponse
    {
        $result = $this->captainProfileService->captainFilter($name);

        return $this->response($result, self::FETCH);
    }
}
