<?php

namespace App\Constant;

abstract class NotificationStoreConstant
{
    static $MESSAGE_STORE_NEW_ORDER = "هناك طلب جديد من متجرك رقم الطلب ";

    static $MESSAGE_STORE_ORDER_UPDATE = "هناك تحديث في حالة الطلب رقم ";

    static $MESSAGE_STORE_ORDER_CANCEL = "قام العميل بإلغاء الطلب رقم ";

    static $MESSAGE_STORE_STATUS_ORDER_UPDATE = "هناك تحديث في حالة الطلب";

    static $MESSAGE_NEW_CHAT = "لديك رسالة جديدة";

    static $MESSAGE_NEW_CHAT_FROM_ADMIN = "لديك رسالة جديدة من الإدارة";

}