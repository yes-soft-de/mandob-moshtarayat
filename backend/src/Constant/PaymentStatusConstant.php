<?php

namespace App\Constant;

abstract class PaymentStatusConstant
{
    static $PAYMENT_STATE_NOT_PAID = "not paid";

    static $PAYMENT_STATE_PAID = "paid";

    static $PAYMENT_STATE_CARD = "card";

    static $PAYMENT_STATE_CASH = "cash";

}