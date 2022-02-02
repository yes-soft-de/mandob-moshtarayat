<?php

namespace App\Constant;

abstract class MalathURLConstant
{
    // Main URL for Server
    static $URL_GATEWAY = "http://sms.malath.net.sa";

    // Url 4 Send SMS
    static $URL_GATEWAY_SEND = "/httpSmsProvider.aspx";

    // Url 4 Get Balance
    static $URL_GATEWAY_CREDIT = "/api/getBalance.aspx";

    // Url 4 Get & ADD Sender Names
    static $URL_GATEWAY_SENDER = "/apis/users.aspx";

}