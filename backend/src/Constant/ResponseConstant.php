<?php

namespace App\Constant;

abstract class ResponseConstant
{
    static $CAPTAIN_INACTIVE = "captain inactive";

    static $CAPTAIN_ACTIVE = "active";

    static $ORDER_NOT_CREATED = "Not created";

    static $ORDER_NOT_REMOVE_TIME = "can not remove it, Exceeded time allowed";

    static $ORDER_NOT_REMOVE_STATE = "on way to pick order";

    static $ORDER_NOT_REMOVE_CAPTAIN_RECEIVED = "can not remove it, The captain received the order";

    static $ERROR = "error";
}