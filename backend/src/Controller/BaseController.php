<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Serializer\Encoder\JsonEncoder;
use Symfony\Component\Serializer\Normalizer\ObjectNormalizer;
use Symfony\Component\Serializer\Serializer;
use Symfony\Component\Serializer\SerializerInterface;

class BaseController extends AbstractController
{
    private $serializer;
    private $statusCode;

    public function __construct(SerializerInterface $serializer)
    {
        $this->serializer = $serializer;
    }
    const STATE_OK = 200;
    const CREATE = ["created ","201"];
    const UPDATE = ["updated","204"];
    const DELETE = ["deleted","401"];
    const FETCH = ["fetched","200"];
    //error order
    const ERROR = ["error","9201"];
    const ERROR_ORDER_REMOVE = ["error","9202"];
    const ERROR_ORDER_UPDATE = ["error","9203"];
    //error related
    const ERROR_RELATED= ["error related","9251"];
    // error users
    const ERROR_USER_CHECK = ["error user check","9000"];
    const ERROR_USER_FOUND = ["error user found","9001"];
    const ERROR_UNMATCHED_PASSWORDS = ["password and its confirmation are not matched", "9002"];
    const ERROR_USER_CREATED = ["error, not created user","9010"];
    // error captain
    const ERROR_CAPTAIN_INACTIVE = ["error captain inactive","9100"];
    const CAPTAIN_PROFILE_NOT_EXIST = ["captain profile not exist!", "9101"];
    //error store
    const ERROR_STORE_INACTIVE = ["error store inactive","9151"];
    const INCORRECT_ENTERED_DATA = ["incorrect entered date!", "9152"];
    const CODE_DATE_IS_NOT_VALID = ["overdue cod!", "9153"];
    const ALREADY_VERIFIED_STORE_OWNER = ["already verified store owner!", "9154"];
    const STORE_OWNER_IS_NOT_REGISTERED = ["store owner is not registered!", "9155"];
    const STORE_OWNER_IS_NOT_VERIFIED = ["store owner is not verified!", "9156"];
    const STORE_OWNER_PROFILE_NOT_EXIST = ["store owner profile not exist!", "9157"];
    // client
    const CLIENT_PROFILE_NOT_EXIST = ["client profile not exist!", "9210"];
    //profile not completed
    const PROFILE_NOT_COMPLETED = ["profile is not completed!", "9220"];

    const NOTFOUND=["Not found", "404"];
//    const TEST = [
//        "one"=>[ "error error", "9003"],
//        "tow"=>[ "error captain inactive", "9002"]
//    ];

    public function getUserId()
    {
        $userID = 0;

        if ($this->getUser())
        {
            // $userID = $this->getUser()->getuserid();
            $userID = $this->getUser()->getId();
        }

        return $userID;
    }

    /**
     * @return mixed
     */
    public function getStatusCode()
    {
        return $this->statusCode;
    }

    /**
     * @param mixed $statusCode
     */
    public function setStatusCode($statusCode): void
    {
        $this->statusCode = $statusCode;
    }

    /**
     * Returns a JSON response
     *
     * @param array $data
     * @param array $headers
     *
     * @return JsonResponse
     */
    public function respond($data, $headers = [])
    {
        return new JsonResponse($data, self::STATE_OK, $headers);
    }

    /**
     * Sets an error message and returns a JSON response
     * @param string $errors
     * @param array $headers
     * @return JsonResponse
     */
    public function respondWithErrors($errors, $headers = [])
    {
        $data = [
            'errors' => $errors,
        ];

        return new JsonResponse($data, $this->getStatusCode(), $headers);
    }

    /**
     * Returns a 401 Unauthorized http response
     *
     * @param string $message
     *
     * @return JsonResponse
     */
    public function respondUnauthorized($message = 'Not authorized!')
    {
        $this->setStatusCode(401)->respondWithErrors($message);
    }

    /**
     * @param string $message
     * @return JsonResponse
     */
    public function respondNotFound($message = 'Not found!')
    {
        $data = [
            'Error' => $message,
        ];

        $this->setStatusCode(404);

        return new JsonResponse($data, $this->getStatusCode());
    }

    public function response($result, $status) :jsonResponse
    {
        if($result!=null)
        {
            $encoders = [new JsonEncoder()];
            $normalizers = [new ObjectNormalizer()];
            $this->serializer = new Serializer($normalizers, $encoders);
            $result = $this->serializer->serialize($result, "json", [
                'enable_max_depth' => true]);
            $response = new jsonResponse(["status_code" => $status[1],
                    "msg" => $status[0] . " " . "Successfully.",
                    "Data" => json_decode($result)
                ]
                , Response::HTTP_OK);
            $response->headers->set('Access-Control-Allow-Headers', 'X-Header-One,X-Header-Two');
            $response->headers->set('Access-Control-Allow-Origin', '*');
            $response->headers->set('Access-Control-Allow-Methods', 'PUT');
            return $response;
        }
        else
        {
            $response = new JsonResponse(["status_code"=>"200",
                 "msg"=>"Data not found!"],
             Response::HTTP_OK);

            return $response;
        }
    }
}
