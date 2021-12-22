<?php

namespace App\Constant;

abstract class LocalNotificationList
{
    static $STATE_TITLE = "حالة الطلب";

    static $STATE_ON_WAY_PICK_ORDER = "المندوب في طريقه إلى المتجر";

    static $STATE_IN_STORE = "المندوب في المتجر";

    static $STATE_ONGOING = "المندوب في طريقه إليك";

    static $STATE_DELIVERED = "تم تسليم الطلب";

    static $NEW_ORDER_TITLE = "طلب جديد";

    static $CREATE_ORDER_SUCCESS = "تم إنشاء طلب جديد بنجاح";

    static $UPDATE_ORDER_TITLE = "تعديل طلب";

    static $UPDATE_ORDER_SUCCESS = "تم تعديل الطلب بنجاح";

    static $UPDATE_ORDER_ERROR_CAPTAIN_IN_STORE = "عذرا لا تستطيع تعديل الطلب , الكابتن في المتجر.";

    static $CANCEL_ORDER_TITLE = "حذف طلب";

    static $CANCEL_ORDER_SUCCESS = "تم حذف الطلب بنجاح.";

    static $CANCEL_ORDER_ERROR_TIME = "لا يمكن حذف الطلب, لقد تجاوزت الوقت المسموح به للحذف.";

    static $CANCEL_ORDER_ERROR_ACCEPTED = "لا يمكن حذف الطلب, الكابتن استلم الطلب.";

}
