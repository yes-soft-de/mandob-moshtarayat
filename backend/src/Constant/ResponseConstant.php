<?php

namespace App\Constant;

abstract class ResponseConstant
{
    static $CAPTAIN_INACTIVE = "captain inactive";

    static $STORE_INACTIVE = "store inactive";

    static $CAPTAIN_ACTIVE = "active";

    static $INACTIVE = "inactive";

    static $ERROR_LON_LOT = "error lon or lat";

    static $ORDER_NOT_CREATED = "Not created";

    static $ORDER_NOT_REMOVE_TIME = "can not remove it, Exceeded time allowed";

    static $ORDER_NOT_REMOVE_STATE = "on way to pick order";

    static $ORDER_NOT_UPDATE_STATE = "you can't edit, The captain received the order";

    static $ORDER_NOT_REMOVE_CAPTAIN_RECEIVED = "can not remove it, The captain received the order";

    static $ERROR = "error";

    static $ERROR_VALIDATION_ORDER_DETAILS = "please enter order Details.";

    static $ERROR_VALIDATION_PRODUCT_DETAILS = "please enter product Details.";
}