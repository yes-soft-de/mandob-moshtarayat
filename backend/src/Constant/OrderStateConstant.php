<?php

namespace App\Constant;

abstract class OrderStateConstant
{
    static $ORDER_STATE_NOT_PAID = "not paid";

    static $ORDER_STATE_PENDING = "pending";

    static $ORDER_STATE_ON_WAY = "on way to pick order";

    static $ORDER_STATE_IN_STORE= "in store";

    static $ORDER_STATE_PICKED= "picked";

    static $ORDER_STATE_ONGOING= "ongoing";

    static $ORDER_STATE_DELIVERED= "delivered";

    static $ORDER_STATE_CANCEL= "cancelled";
}