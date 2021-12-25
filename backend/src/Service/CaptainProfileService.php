<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\CaptainProfileEntity;
use App\Entity\UserEntity;
use App\Request\CaptainVacationCreateRequest;
use App\Request\CaptainProfileUpdateRequest;
use App\Request\CaptainProfileUpdateLocationRequest;
use App\Request\UserRegisterRequest;
use App\Request\CaptainProfileUpdateByAdminRequest;
use App\Response\CaptainIsActiveResponse;
use App\Response\CaptainProfileCreateResponse;
use App\Response\CaptainFinancialAccountDetailsResponse;
use App\Response\CaptainProfileInActiveGetResponse;
use App\Response\CaptainsProfilesResponse;
use App\Response\CaptainTotalFinancialAccountInMonthResponse;
use App\Response\CaptainTotalFinancialAccountInMonthForAdminResponse;
use App\Response\CaptainCountOrdersDeliveredInTodayResponse;
use App\Response\CaptainsRemainingForItAmountResponse;
use App\Response\UserRegisterResponse ;
use App\Response\CaptainProfileFilterResponse ;
use App\Response\CaptainsRemainingOnItAmountResponse ;
use App\Service\DeliveryCompanyPaymentsFromCaptainService;
use App\Service\DeliveryCompanyPaymentsToCaptainService;
use App\Service\RoomIdHelperService;
use App\Service\RatingService;
use App\Service\DateFactoryService;
use App\Service\OrdersInvoicesService;
use App\Manager\UserManager;
use App\Manager\CaptainProfileManager;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;
use DateTime;


class CaptainProfileService
{
    private $autoMapping;
    private $userManager;
    private $ratingService;
    private $params;
    private $deliveryCompanyPaymentsFromCaptainService;
    private $deliveryCompanyPaymentsToCaptainService;
    private $roomIdHelperService;
    private $dateFactoryService;
    private $captainProfileManager;
    private $ordersInvoicesService;

    public function __construct(AutoMapping $autoMapping, ParameterBagInterface $params, DeliveryCompanyPaymentsFromCaptainService $deliveryCompanyPaymentsFromCaptainService, DeliveryCompanyPaymentsToCaptainService $deliveryCompanyPaymentsToCaptainService,   RoomIdHelperService $roomIdHelperService, UserManager $userManager,
      RatingService $ratingService, DateFactoryService $dateFactoryService, CaptainProfileManager $captainProfileManager, OrdersInvoicesService $ordersInvoicesService)
    {
        $this->autoMapping = $autoMapping;
        $this->roomIdHelperService = $roomIdHelperService;
        $this->userManager = $userManager;
        $this->ratingService = $ratingService;
        $this->dateFactoryService = $dateFactoryService;
        $this->deliveryCompanyPaymentsFromCaptainService = $deliveryCompanyPaymentsFromCaptainService;
        $this->deliveryCompanyPaymentsToCaptainService = $deliveryCompanyPaymentsToCaptainService;
        $this->captainProfileManager = $captainProfileManager;
        $this->ordersInvoicesService = $ordersInvoicesService;

        $this->params = $params->get('upload_base_url') . '/';
    }
    
    public function captainRegister(UserRegisterRequest $request)
    {
        $request->setRoomID($this->roomIdHelperService->roomIdGenerate());

        $userRegister = $this->captainProfileManager->captainRegister($request);
        if ($userRegister == "user is found") {
            $user['found']="yes";

            return $this->autoMapping->map("array", UserRegisterResponse::class, $user);
        }
        return $this->autoMapping->map(UserEntity::class, UserRegisterResponse::class, $userRegister);
    }

    public function updateCaptainProfile(CaptainProfileUpdateRequest $request)
    {
        $item = $this->captainProfileManager->updateCaptainProfile($request);
        
        return $this->autoMapping->map(CaptainProfileEntity::class, CaptainProfileCreateResponse::class, $item);
    }

    public function captainProfileUpdateLocation(CaptainProfileUpdateLocationRequest $request)
    {
        $item = $this->captainProfileManager->captainProfileUpdateLocation($request);
        
        return $this->autoMapping->map(CaptainProfileEntity::class, CaptainProfileCreateResponse::class, $item);
    }

    public function updateCaptainProfileByAdmin(CaptainProfileUpdateByAdminRequest $request)
    {
        $item = $this->captainProfileManager->updateCaptainProfileByAdmin($request);

        return $this->autoMapping->map(CaptainProfileEntity::class, CaptainProfileCreateResponse::class, $item);
    }

    public function updateCaptainStateByAdmin(CaptainVacationCreateRequest $request)
    {
        return $this->captainProfileManager->updateCaptainStateByAdmin($request);

    }

    public function getCaptainProfileByCaptainID($captainID):object
    {
        $response=(object)[];

        $item = $this->captainProfileManager->getCaptainProfileByCaptainID($captainID);

//        $bounce = $this->getCaptainFinancialAccountDetailsByCaptainId($captainID);

        $countOrdersDelivered = $this->captainProfileManager->countCaptainOrdersDelivered($captainID);

        $item['baseURL'] = $this->params;
        $item['image'] = $this->getImageParams($item['image'], $this->params.$item['image'], $this->params);
        $item['drivingLicence'] = $this->getImageParams($item['drivingLicence'], $this->params.$item['drivingLicence'], $this->params);
        $item['mechanicLicense'] = $this->getImageParams($item['mechanicLicense'], $this->params.$item['mechanicLicense'], $this->params);
        $item['identity'] = $this->getImageParams($item['identity'], $this->params.$item['identity'], $this->params);

        $item['rating'] = $this->ratingService->getAvgRating($captainID, 'captain');
       
        $response = $this->autoMapping->map('array', CaptainProfileCreateResponse::class, $item);

//        $response->bounce = $bounce;
        $response->countOrdersDeliverd = $countOrdersDelivered;

        return $response;
    }

    public function getCaptainProfileByCaptainIDForAdmin($captainID)
    {
        $item = $this->captainProfileManager->getCaptainProfileByCaptainID($captainID);
        if($item) {
            $item['imageURL'] = $item['image'];
            $item['image'] = $this->params.$item['image'];
            $item['drivingLicenceURL'] = $item['drivingLicence'];
            $item['drivingLicence'] = $this->params.$item['drivingLicence'];
            $item['baseURL'] = $this->params;
            $item['rating'] = $this->ratingService->getAvgRating($item['captainID'], 'captain');
        }

        return $this->autoMapping->map('array', CaptainProfileCreateResponse::class, $item);
    }

    public function getCaptainsInactive():array
    {
        $response = [];

        $items = $this->captainProfileManager->getCaptainsInactive();

        foreach( $items as  $item ) {
            $item['image'] = $this->getImageParams($item['image'], $this->params.$item['image'], $this->params);

            $response[]  = $this->autoMapping->map('array', CaptainProfileInActiveGetResponse::class, $item);
            }

        return $response;
    }
    
    public function captainIsActive($captainID)
    {
        $item = $this->captainProfileManager->captainIsActive($captainID);

        return $this->autoMapping->map('array',CaptainIsActiveResponse::class, $item);
     }

     public function dashboardCaptains():array
     {
         $response = [];

         $response[] = $this->userManager->countpendingCaptains();
         $response[] = $this->userManager->countOngoingCaptains();
         $response[] = $this->userManager->countDayOfCaptains();

         $top5Captains = $this->getTop5Captains();
      
         foreach ($top5Captains as $item) {
            $item['image'] = $this->getImageParams($item['image'], $this->params.$item['image'], $this->params);

            $response[]  = $this->autoMapping->map('array',CaptainProfileCreateResponse::class,  $item);
         }         

         return $response;
     }

     public function getCaptainsInVacation():array
     {
         $response = [];

         $dayOfCaptains = $this->captainProfileManager->getCaptainsInVacation();
      
         foreach ($dayOfCaptains as $item) {
            $item['imageURL'] = $item['image'];
            $item['image'] = $this->params.$item['image'];
            $item['drivingLicenceURL'] = $item['drivingLicence'];
            $item['drivingLicence'] = $this->params.$item['drivingLicence'];
            $item['baseURL'] = $this->params;

            $response[]  = $this->autoMapping->map('array',CaptainProfileCreateResponse::class,  $item);
         }         

         return $response;
     }
 
    public function getOrderKilometers($captainId)
     {
       $sumKilometerBonus = [];

       $orderKilometers = $this->captainProfileManager->getOrderKilometers($captainId);

       foreach ($orderKilometers as $orderKilometer) {
           if ($orderKilometer['orderKilometers'] >= $orderKilometer['kilometers']) {
                 $Kilometer = $orderKilometer['orderKilometers'] - $orderKilometer['kilometers'];
                 $kilometerBonus1 = $Kilometer * $orderKilometer['maxKilometerBonus'];
                 $sumKilometerBonus[] = $kilometerBonus1;
           }

         if ($orderKilometer['orderKilometers'] < $orderKilometer['kilometers']) {
                $Kilometer = $orderKilometer['orderKilometers'];
                $kilometerBonus2 = $Kilometer * $orderKilometer['minKilometerBonus'];
                $sumKilometerBonus[] = $kilometerBonus2;
         }

       }

       return array_sum($sumKilometerBonus);
     }
    
    public function getOrderKilometersInThisMonth($captainId, $fromDate, $toDate)
    {
      $sumKilometerBonus = [];

      $orderKilometers = $this->captainProfileManager->getOrderKilometersInThisMonth($captainId, $fromDate, $toDate);

      foreach ($orderKilometers as $orderKilometer) {
          if ($orderKilometer['orderKilometers'] >= $orderKilometer['kilometers']) {
                 $Kilometer = $orderKilometer['orderKilometers'] - $orderKilometer['kilometers'];
                 $kilometerBonus1 = $Kilometer * $orderKilometer['maxKilometerBonus'];
                 $sumKilometerBonus[] = $kilometerBonus1;
       }

       if ($orderKilometer['orderKilometers'] < $orderKilometer['kilometers']) {
                 $Kilometer = $orderKilometer['orderKilometers'];
                 $kilometerBonus2 = $Kilometer * $orderKilometer['minKilometerBonus'];
                 $sumKilometerBonus[] = $kilometerBonus2;
       }

      }

       return array_sum($sumKilometerBonus);
    }

    public function getCaptainFinancialAccountDetailsByCaptainId($captainId):array
    {
        $response=[];

        $item = $this->captainProfileManager->getCaptainAsArrayByCaptainId($captainId);
    
        $sumPaymentsFromCaptainToCompany = $this->deliveryCompanyPaymentsFromCaptainService->deliveryCompanySumPaymentsFromCaptain($captainId);
        $sumPaymentsToCaptainFromCompany = $this->deliveryCompanyPaymentsToCaptainService->deliveryCompanySumPaymentsToCaptain($captainId);
      
        if ($item) {
            $countOrdersDelivered = $this->captainProfileManager->countCaptainOrdersDelivered($item[0]['captainID']);
            $invoicesIDs = $this->captainProfileManager->getInvoicesIDs($item[0]['captainID']);
            $sumInvoiceAmountWithoutOrderTypeSendIt = $this->ordersInvoicesService->sumInvoiceAmountWithoutOrderTypeSendIt($invoicesIDs);

//            $sumInvoiceAmountWithoutOrderTypeSendIt = $this->captainProfileManager->sumInvoiceAmountWithoutOrderTypeSendIt($invoicesIDs);

            $sumKilometerBonus = $this->getOrderKilometers($captainId);
             
             $item['countOrdersDelivered'] = (float)$countOrdersDelivered[0]['countOrdersDelivered'];
             $item['kilometerBonus'] = $sumKilometerBonus;

             $item['sumInvoiceAmount'] = (float)$sumInvoiceAmountWithoutOrderTypeSendIt;

             $item['deliveryCost'] = (float)$countOrdersDelivered[0]['deliveryCost'];
             $item['amountYouOwn'] = (float)$sumInvoiceAmountWithoutOrderTypeSendIt + $countOrdersDelivered[0]['deliveryCost'];

             $item['sumPaymentsFromCompany'] = (float)$sumPaymentsToCaptainFromCompany[0]['sumPaymentsFromCompany'];
             $item['sumPaymentsToCompany'] = (float)$sumPaymentsFromCaptainToCompany[0]['sumPaymentsToCompany'];
             $item['remainingAmountForCompany'] = (float)$item['amountYouOwn'] - $item['sumPaymentsToCompany'];

             $item['bounce'] = $item[0]['bounce'] * $item['countOrdersDelivered'];
             $item['salary'] = $item[0]['salary'];
             $item['netProfit'] = $item['bounce'] + $item['salary'] + $item['kilometerBonus'];
             $item['total'] = $item['netProfit'] - $item['sumPaymentsFromCompany'];
            //  $item['payments'] = $payments;

             $response[] = $this->autoMapping->map('array', CaptainFinancialAccountDetailsResponse::class,  $item);

        }
        return $response;
    }

    public function getCaptainFinancialAccountDetailsByCaptainIdForAdmin($captainId):array
    {
        $response=[];

        $item = $this->captainProfileManager->getCaptainAsArrayByCaptainId($captainId);

        $sumPaymentsFromCaptainToCompany = $this->deliveryCompanyPaymentsFromCaptainService->deliveryCompanySumPaymentsFromCaptain($captainId);
        $sumPaymentsToCaptainFromCompany = $this->deliveryCompanyPaymentsToCaptainService->deliveryCompanySumPaymentsToCaptain($captainId);

        $paymentsFromCaptainToCompany = $this->deliveryCompanyPaymentsFromCaptainService->deliveryCompanyPaymentsFromCaptain($captainId);
        $paymentsToCaptainFromCompany = $this->deliveryCompanyPaymentsToCaptainService->deliveryCompanyPaymentsToCaptain($captainId);

        if ($item) {
             $countOrdersDelivered = $this->captainProfileManager->countCaptainOrdersDelivered($item[0]['captainID']);
            $invoicesIDs = $this->captainProfileManager->getInvoicesIDs($item[0]['captainID']);
            $sumInvoiceAmountWithoutOrderTypeSendIt = $this->ordersInvoicesService->sumInvoiceAmountWithoutOrderTypeSendIt($invoicesIDs);

//             $sumInvoiceAmountWithoutOrderTypeSendIt = $this->captainProfileManager->sumInvoiceAmountWithoutOrderTypeSendIt($item[0]['captainID']);

             $sumKilometerBonus = $this->getOrderKilometers($captainId);

             $item['countOrdersDelivered'] = (float)$countOrdersDelivered[0]['countOrdersDelivered'];
             $item['kilometerBonus'] = $sumKilometerBonus;
             $item['sumInvoiceAmount'] = (float)$sumInvoiceAmountWithoutOrderTypeSendIt;
             $item['deliveryCost'] = (float)$countOrdersDelivered[0]['deliveryCost'];
             $item['amountWithCaptain'] = (float)$sumInvoiceAmountWithoutOrderTypeSendIt + $countOrdersDelivered[0]['deliveryCost'];
             $item['sumPaymentsToCaptain'] = (float)$sumPaymentsToCaptainFromCompany[0]['sumPaymentsFromCompany'];
             $item['sumPaymentsFromCaptain'] = (float)$sumPaymentsFromCaptainToCompany[0]['sumPaymentsToCompany'];
             $item['remainingAmountForCompany'] = (float)$item['amountWithCaptain'] - $item['sumPaymentsFromCaptain'];
             
             $item['bounce'] = $item[0]['bounce'] * $item['countOrdersDelivered'];
             $item['salary'] = $item[0]['salary'];
             $item['NetProfit'] = $item['bounce'] + $item['salary'] + $item['kilometerBonus'];
             
             // + Positive: the account is on the captain
             // - Negative: the account is for the captain
             $item['total'] = $item['sumPaymentsToCaptain'] - $item['NetProfit'];
             $item['paymentsToCaptain'] = $paymentsToCaptainFromCompany;
             $item['paymentsFromCaptain'] = $paymentsFromCaptainToCompany;

             $response[] = $this->autoMapping->map('array', CaptainTotalFinancialAccountInMonthForAdminResponse::class,  $item);
            
        }

        return $response;
    }

    public function captainFinancialAccountInLastMonth($captainId):array
    {
        $response = [];

        $dateNow = new DateTime("now");
        $year = $dateNow->format("Y");
        $month = $dateNow->format("m");

        $date = $this->dateFactoryService->returnLastMonthDate($year, $month);

        $item = $this->captainProfileManager->getCaptainAsArrayByCaptainId($captainId);
    
        $sumPaymentsToCaptainFromCompany = $this->deliveryCompanyPaymentsToCaptainService->deliveryCompanySumPaymentsToCaptainInSpecificDate($captainId, $date[0], $date[1]);
        $sumPaymentsFromCaptainToCompany = $this->deliveryCompanyPaymentsFromCaptainService->deliveryCompanySumPaymentsFromCaptainInSpecificDate($captainId, $date[0], $date[1]);

        if( $sumPaymentsToCaptainFromCompany[0]['sumPayments'] == null) {
            $sumPaymentsFromCompany[0]['sumPayments'] = (float)0; 
        }

        if( $sumPaymentsFromCaptainToCompany[0]['sumPayments'] == null) {
            $sumPaymentsFromCaptainToCompany[0]['sumPayments'] = (float)0; 
        }

        if ($item) {
            $countOrdersDelivered = $this->captainProfileManager->countOrdersInMonthForCaptain($date[0], $date[1], $item[0]['captainID']);

            $sumInvoiceAmount = $this->captainProfileManager->sumInvoiceAmountWithoutOrderTypeSendItInMonthForCaptain($date[0], $date[1], $item[0]['captainID']);

            $paymentsToCaptainFromCompany = $this->deliveryCompanyPaymentsToCaptainService->deliveryCompanyPaymentsToCaptainInSpecificDate( $item[0]['captainID'] ,$date[0], $date[1]);

            $sumKilometerBonus = $this->getOrderKilometersInThisMonth($captainId, $date[0], $date[1]);
            $item['kilometerBonus'] = $sumKilometerBonus;

            $item['countOrdersDelivered'] = (float)$countOrdersDelivered[0]['countOrdersInMonth'];
            $item['sumInvoiceAmount'] = (float)$sumInvoiceAmount[0]['sumInvoiceAmount'];
            $item['deliveryCost'] = (float)$countOrdersDelivered[0]['deliveryCost'];
            $item['amountYouOwn'] = (float)$sumInvoiceAmount[0]['sumInvoiceAmount'] + $countOrdersDelivered[0]['deliveryCost'];

            $item['sumPaymentsFromCompany'] = (float)$sumPaymentsToCaptainFromCompany[0]['sumPayments'];
            $item['sumPaymentsToCompany'] = (float)$sumPaymentsFromCaptainToCompany[0]['sumPayments'];
            $item['remainingAmountForCompany'] = (float)$item['amountYouOwn'] - $item['sumPaymentsToCompany'];
            $item['bounce'] = $item[0]['bounce'] * $item['countOrdersDelivered'];
            $item['salary'] = $item[0]['salary'];
            $item['NetProfit'] = $item['bounce'] + $item[0]['salary'] + $item['kilometerBonus'];;
            $item['total'] = $item['NetProfit'] - $item['sumPaymentsFromCompany'];
            $item['paymentsFromCompany'] = $paymentsToCaptainFromCompany;

            $response[] = $this->autoMapping->map('array', CaptainTotalFinancialAccountInMonthResponse::class,  $item);
        }

        return $response;
    }

    public function captainFinancialAccountInLastMonthForAdmin($captainID):array
    {
        $response = [];

        $dateNow = new DateTime("now");
        $year = $dateNow->format("Y");
        $month = $dateNow->format("m");

        $date = $this->dateFactoryService->returnLastMonthDate($year, $month);

        $item = $this->captainProfileManager->getCaptainAsArrayByCaptainId($captainID);
    
        $sumPaymentsToCaptainFromCompany = $this->deliveryCompanyPaymentsToCaptainService->deliveryCompanySumPaymentsToCaptainInSpecificDate($captainID, $date[0], $date[1]);
        $sumPaymentsFromCaptainToCompany = $this->deliveryCompanyPaymentsFromCaptainService->deliveryCompanySumPaymentsFromCaptainInSpecificDate($captainID, $date[0], $date[1]);
        if( $sumPaymentsToCaptainFromCompany[0]['sumPayments'] == null) { 
            $sumPaymentsToCaptainFromCompany[0]['sumPayments'] = (float)0; 
             }

        if( $sumPaymentsFromCaptainToCompany[0]['sumPayments'] == null) {
            $sumPaymentsFromCaptainToCompany[0]['sumPayments'] = (float)0;
             }

        if ($item) {
             $countOrdersDelivered = $this->captainProfileManager->countOrdersInMonthForCaptain($date[0], $date[1], $item[0]['captainID']);
             $sumInvoiceAmount = $this->captainProfileManager->sumInvoiceAmountWithoutOrderTypeSendItInMonthForCaptain($date[0], $date[1], $item[0]['captainID']);
             $paymentsToCaptainFromCompany = $this->deliveryCompanyPaymentsToCaptainService->deliveryCompanyPaymentsToCaptainInSpecificDate($item[0]['captainID'] ,$date[0], $date[1]);

             $paymentsFromCaptainToCompany = $this->deliveryCompanyPaymentsFromCaptainService->deliveryCompanyPaymentsFromCaptainInSpecificDate($item[0]['captainID'] ,$date[0], $date[1]);

             $sumKilometerBonus = $this->getOrderKilometersInThisMonth($captainID, $date[0], $date[1]);
             $item['kilometerBonus'] = $sumKilometerBonus;

             $item['countOrdersDelivered'] = (float)$countOrdersDelivered[0]['countOrdersInMonth'];
//             $item['sumInvoiceAmount'] = (float)$countOrdersDelivered[0]['sumInvoiceAmount'];
             $item['sumInvoiceAmount'] = (float)$sumInvoiceAmount[0]['sumInvoiceAmount'];
             $item['deliveryCost'] = (float)$countOrdersDelivered[0]['deliveryCost'];
             $item['amountWithCaptain'] = (float)$sumInvoiceAmount[0]['sumInvoiceAmount'] + $countOrdersDelivered[0]['deliveryCost'];

             $item['sumPaymentsToCaptain'] = (float)$sumPaymentsToCaptainFromCompany[0]['sumPayments'];
             $item['sumPaymentsFromCaptain'] = (float)$sumPaymentsFromCaptainToCompany[0]['sumPayments'];
             $item['remainingAmountForCompany'] = (float)$item['amountWithCaptain'] - $item['sumPaymentsFromCaptain'];
             $item['bounce'] = $item[0]['bounce'] * $item['countOrdersDelivered'];

             $item['salary'] = $item[0]['salary'];
            
             $item['NetProfit'] = $item['bounce'] + $item[0]['salary'] + $item['kilometerBonus'];
             // + Positive: the account is on the captain
             // - Negative: the account is for the captain
             $item['total'] =  $item['sumPaymentsToCaptain'] - $item['NetProfit'];
             $item['paymentsToCaptain'] = $paymentsToCaptainFromCompany;
             $item['paymentsFromCaptain'] = $paymentsFromCaptainToCompany;

             $response[] = $this->autoMapping->map('array', CaptainTotalFinancialAccountInMonthForAdminResponse::class,  $item);
            
        }

        return $response;
    }

    public function captainFinancialAccountInSpecificDateForAdmin($captainID, $fromDate, $toDate):array
    {
        $response = [];

        $date = $this->dateFactoryService->returnSpecificDate($fromDate, $toDate);

        $item = $this->captainProfileManager->getCaptainAsArrayByCaptainId($captainID);
    
        $sumPaymentsToCaptainFromCompany = $this->deliveryCompanyPaymentsToCaptainService->deliveryCompanySumPaymentsToCaptainInSpecificDate($captainID, $date[0], $date[1]);
        $sumPaymentsFromCaptainToCompany = $this->deliveryCompanyPaymentsFromCaptainService->deliveryCompanySumPaymentsFromCaptainInSpecificDate($captainID, $date[0], $date[1]);

        if( $sumPaymentsToCaptainFromCompany[0]['sumPayments'] == null) {
            $sumPaymentsToCaptainFromCompany[0]['sumPayments'] = (float)0; 
             }

        if( $sumPaymentsFromCaptainToCompany[0]['sumPayments'] == null) {
            $sumPaymentsFromCaptain[0]['sumPayments'] = (float)0; 
             }

        if ($item) {
             $countOrdersDelivered = $this->captainProfileManager->countOrdersInMonthForCaptain($date[0], $date[1], $item[0]['captainID']);
             $sumInvoiceAmount = $this->captainProfileManager->sumInvoiceAmountWithoutOrderTypeSendItInMonthForCaptain($date[0], $date[1], $item[0]['captainID']);
             $paymentsToCaptainFromCompany = $this->deliveryCompanyPaymentsToCaptainService->deliveryCompanyPaymentsToCaptainInSpecificDate($item[0]['captainID'] ,$date[0], $date[1]);

             $paymentsFromCaptainToCompany = $this->deliveryCompanyPaymentsFromCaptainService->deliveryCompanyPaymentsFromCaptainInSpecificDate($item[0]['captainID'] ,$date[0], $date[1]);

             $sumKilometerBonus = $this->getOrderKilometersInThisMonth($captainID, $date[0], $date[1]);
             $item['kilometerBonus'] = $sumKilometerBonus;

             $item['countOrdersDelivered'] = (float)$countOrdersDelivered[0]['countOrdersInMonth'];
//             $item['sumInvoiceAmount'] = (float)$countOrdersDelivered[0]['sumInvoiceAmount'];
             $item['sumInvoiceAmount'] = (float)$sumInvoiceAmount[0]['sumInvoiceAmount'];
             $item['deliveryCost'] = (float)$countOrdersDelivered[0]['deliveryCost'];
             $item['amountWithCaptain'] = (float)$sumInvoiceAmount[0]['sumInvoiceAmount'] + $countOrdersDelivered[0]['deliveryCost'];

             $item['sumPaymentsToCaptain'] = (float)$sumPaymentsToCaptainFromCompany[0]['sumPayments'];
             $item['sumPaymentsFromCaptain'] = (float)$sumPaymentsFromCaptainToCompany[0]['sumPayments'];
             $item['remainingAmountForCompany'] = (float)$item['amountWithCaptain'] - $item['sumPaymentsFromCaptain'];
             $item['bounce'] = $item[0]['bounce'] * $item['countOrdersDelivered'];

             $item['salary'] = $item[0]['salary'];
            
             $item['NetProfit'] = $item['bounce'] + $item[0]['salary'] + $item['kilometerBonus'];
             // + Positive: the account is on the captain
             // - Negative: the account is for the captain
             $item['total'] =  $item['sumPaymentsToCaptain'] - $item['NetProfit'];
             $item['paymentsToCaptain'] = $paymentsToCaptainFromCompany;
             $item['paymentsFromCaptain'] = $paymentsFromCaptainToCompany;

             $response[] = $this->autoMapping->map('array', CaptainTotalFinancialAccountInMonthForAdminResponse::class,  $item);
            
        }

        return $response;
    }

    public function captainFinancialAccountInSpecificDate($captainId, $fromDate, $toDate):array
    {
        $response = [];
      
        $date = $this->dateFactoryService->returnSpecificDate($fromDate, $toDate);

        $item = $this->captainProfileManager->getCaptainAsArrayByCaptainId($captainId);
    
        $sumPaymentsToCaptainFromCompany = $this->deliveryCompanyPaymentsToCaptainService->deliveryCompanySumPaymentsToCaptainInSpecificDate($captainId, $date[0], $date[1]);
        $sumPaymentsFromCaptainToCompany = $this->deliveryCompanyPaymentsFromCaptainService->deliveryCompanySumPaymentsFromCaptainInSpecificDate($captainId, $date[0], $date[1]);

        if( $sumPaymentsToCaptainFromCompany[0]['sumPayments'] == null) { 
            $sumPaymentsToCaptainFromCompany[0]['sumPayments'] = (float)0; 
             }

        if( $sumPaymentsFromCaptainToCompany[0]['sumPayments'] == null) {
            $sumPaymentsFromCaptainToCompany[0]['sumPayments'] = (float)0; 
             }

        if ($item) {
            
            $countOrdersDelivered = $this->captainProfileManager->countOrdersInMonthForCaptain($date[0], $date[1], $item[0]['captainID']);
            $sumInvoiceAmount = $this->captainProfileManager->sumInvoiceAmountWithoutOrderTypeSendItInMonthForCaptain($date[0], $date[1], $item[0]['captainID']);
            $paymentsFromCompany = $this->deliveryCompanyPaymentsToCaptainService->deliveryCompanyPaymentsToCaptainInSpecificDate( $item[0]['captainID'] ,$date[0], $date[1]);

             $sumKilometerBonus = $this->getOrderKilometersInThisMonth($captainId, $date[0], $date[1]);
             $item['kilometerBonus'] = $sumKilometerBonus;

             $item['countOrdersDelivered'] = (float)$countOrdersDelivered[0]['countOrdersInMonth'];
             $item['sumInvoiceAmount'] = (float)$sumInvoiceAmount[0]['sumInvoiceAmount'];
             $item['deliveryCost'] = (float)$countOrdersDelivered[0]['deliveryCost'];
             $item['amountYouOwn'] = (float)$sumInvoiceAmount[0]['sumInvoiceAmount'] + $countOrdersDelivered[0]['deliveryCost'];

             $item['sumPaymentsFromCompany'] = (float)$sumPaymentsToCaptainFromCompany[0]['sumPayments'];
             $item['sumPaymentsToCompany'] = (float)$sumPaymentsFromCaptainToCompany[0]['sumPayments'];
             $item['remainingAmountForCompany'] = (float)$item['amountYouOwn'] - $item['sumPaymentsToCompany'];
             $item['bounce'] = $item[0]['bounce'] * $item['countOrdersDelivered'];
             $item['salary'] = $item[0]['salary'];
             $item['NetProfit'] = $item[0]['bounce'] + $item[0]['salary'] + $item['kilometerBonus'];
             $item['total'] = $item['NetProfit'] - $item['sumPaymentsFromCompany'];
             $item['paymentsFromCompany'] = $paymentsFromCompany;

             $response[] = $this->autoMapping->map('array', CaptainTotalFinancialAccountInMonthResponse::class,  $item);
            
        }
        return $response;
    }

    public function countOrdersCaptainDeliveredInToday($captainID)
    {
        $dateNow =new DateTime("now");
        $todayStart = $dateNow->format("Y-m-d 00:00:00");
        $todayEnd = $dateNow->format("Y-m-d 23:59:59");
       
        $countOrdersDeliveredInToday = $this->captainProfileManager->countOrdersDeliveredInToday($captainID, $todayStart, $todayEnd);

        return $this->autoMapping->map('array', CaptainCountOrdersDeliveredInTodayResponse::class, $countOrdersDeliveredInToday);

    }

    public function getAllCaptains():array
    {
        $response = [];

        $captains = $this->captainProfileManager->getAllCaptains();

        foreach ($captains as $captain) {
            $captain['image'] = $this->getImageParams($captain['image'], $this->params.$captain['image'], $this->params);

            $response[]  = $this->autoMapping->map('array',CaptainsProfilesResponse::class,  $captain);
            }       

        return $response;
    }

    public function captainsRemainingForItAmount(): array
    {
        $response = [];
        $captains = $this->captainProfileManager->getAllCaptains();

        foreach ($captains as $captain) {
                 $financialAccount = $this->getCaptainFinancialAccountDetailsByCaptainIdForAdmin($captain['captainID']);

                 $total=$financialAccount[0]->total;

                 $captain['remainingAmountForCaptain'] = $total;

                if ($captain['remainingAmountForCaptain'] < 0 ) {
                    $response[] =  $this->autoMapping->map('array', CaptainsRemainingForItAmountResponse::class, $captain);
                }
        }

        return $response;
    }

    public function captainsRemainingOnItAmount(): array
    {
        $response = [];
        
        $sumFinancialAmount = $this->captainProfileManager->sumFinancialSumInvoiceAmount();
        $sumDeliveryCostAmount = $this->captainProfileManager->sumDeliveryCostAmount();

        $sumPaymentsToCompany = $this->deliveryCompanyPaymentsFromCaptainService->deliveryCompanySumPaymentsFromCaptains();

        $totalAmountForCompany =
        $sumFinancialAmount + $sumDeliveryCostAmount - $sumPaymentsToCompany[0]['sumPaymentsToCompany'];

        $captains = $this->captainProfileManager->getAllCaptains();
        
        foreach ($captains as $captain) {
                 $financialAccount = $this->getCaptainFinancialAccountDetailsByCaptainIdForAdmin($captain['captainID']);

                 $remainingAmountOnCaptain = $financialAccount[0]->remainingAmountForCompany;
                 $captain['remainingAmountForCompany'] = $remainingAmountOnCaptain;

                if ($captain['remainingAmountForCompany'] > 0 ){
                    $response[] =  $this->autoMapping->map('array', CaptainsRemainingOnItAmountResponse::class, $captain);
                }
        }

        $arr['totalAmountForCompany'] = $totalAmountForCompany;
        $arr['captains'] = $response;

        return $arr;
    }

    public function updateCaptainNewMessageStatus($request, $NewMessageStatus)
    {
       $item = $this->userManager->getcaptainByRoomID($request->getRoomID());
   
       $response = $this->userManager->updateCaptainNewMessageStatus($item, $NewMessageStatus);
    
       return  $this->autoMapping->map(CaptainProfileEntity::class, CaptainProfileCreateResponse::class, $response);
    }

    public function getTop5Captains()
    {
       return $this->captainProfileManager->getTop5Captains();
    }

    public function getTopCaptainsInLastMonthDate():array
    {
       $response = [];

       $date = $this->dateFactoryService->returnLastMonthDate();
       $topCaptains = $this->captainProfileManager->getTopCaptainsInLastMonthDate($date[0],$date[1]);
     
        foreach ($topCaptains as $topCaptain) {
            $topCaptain['imageURL'] = $topCaptain['image'];
            $topCaptain['image'] = $this->params.$topCaptain['image'];
            $topCaptain['drivingLicenceURL'] = $topCaptain['drivingLicence'];
            $topCaptain['drivingLicence'] = $this->params.$topCaptain['drivingLicence'];
            $topCaptain['baseURL'] = $this->params;
            $response[] = $this->autoMapping->map('array', CaptainProfileCreateResponse::class, $topCaptain);
        }
    
       return $response;
   }

   public function countCaptains() {
        return $this->captainProfileManager->countCaptains();
   }

   public function captainFilter($name): array
   {
       $response = [];

       $captains = $this->captainProfileManager->captainFilter($name);

       foreach ($captains as $captain) {
           $captain['image'] = $this->getImageParams($captain['image'], $this->params.$captain['image'], $this->params);

           $response['captains'][]= $this->autoMapping->map('array', CaptainProfileFilterResponse::class, $captain);
       }
       
       return $response;
   }

    public function getImageParams($imageURL, $image, $baseURL):array
    {
        $item['imageURL'] = $imageURL;
        $item['image'] = $image;
        $item['baseURL'] = $baseURL;

        return $item;
    }
}
