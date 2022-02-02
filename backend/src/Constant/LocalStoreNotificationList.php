<?php

namespace App\Constant;

abstract class LocalStoreNotificationList
{
    static $STATE_TITLE = "حالة الطلب";

    static $STATE_ON_WAY_PICK_ORDER = "الكابتن في طريقه إليك";

    static $STATE_IN_STORE = "الكابتن في متجرك";

    static $STATE_PICKED = "الكابتن إلتقط الطلب من متجرك";

    static $STATE_ONGOING = "الكابتن في طريقه إلى العميل";

    static $STATE_DELIVERED = "تم تسليم الطلب";

    static $NEW_ORDER_TITLE = "طلب جديد";

    static $CREATE_ORDER_SUCCESS = "تم إنشاء طلب جديد من متجرك";

    static $UPDATE_ORDER_TITLE = "تعديل طلب";

    static $UPDATE_ORDER_SUCCESS = "تم تعديل الطلب بنجاح";

    static $CANCEL_ORDER_TITLE = "حذف طلب";

    static $CANCEL_ORDER_SUCCESS = "تم إلغاء الطلب من قبل العميل";
}