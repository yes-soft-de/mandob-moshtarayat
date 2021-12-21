<?php

namespace App\Response;

class CaptainTotalFinancialAccountInMonthResponse
{
    public $sumPaymentsFromCompany;

    public $sumPaymentsToCompany;

    public $countOrdersDelivered;

    public $sumInvoiceAmount;
 
    public $deliveryCost;

    public $paymentsFromCompany;

    public $amountYouOwn;

    public $remainingAmountForCompany;//مستحقات الشركة

    public $bounce;
    
    public $kilometerBonus;

    public $NetProfit;

    public $total;

}
