import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_captain/module_orders/request/update_store_order_status_request.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/state/order_status/order_status_store.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_captain/generated/l10n.dart';
import 'package:mandob_moshtarayat_captain/module_orders/request/billed_calculated.dart';
import 'package:mandob_moshtarayat_captain/module_orders/request/order_invoice_request.dart';
import 'package:mandob_moshtarayat_captain/module_orders/request/update_order_request/update_order_request.dart';
import 'package:mandob_moshtarayat_captain/module_orders/service/orders/orders.service.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/screens/order_status/order_status_screen.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/state/order_status/order_details_state_captain_order_loaded.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/state/order_status/order_status.state.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/state/order_status/order_status_error_state.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/state/order_status/order_status_loading_state.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/state/order_status/orders_status_empty_state.dart';
import 'package:mandob_moshtarayat_captain/module_report/service/report_service.dart';
import 'package:mandob_moshtarayat_captain/module_upload/service/image_upload/image_upload_service.dart';
import 'package:mandob_moshtarayat_captain/utils/helpers/custom_flushbar.dart';

@injectable
class OrderStatusStateManager {
  final OrdersService _ordersService;
  final ReportService _reportService;
  final ImageUploadService _imageUploadService;
  final PublishSubject<OrderDetailsState> _stateSubject =
      PublishSubject<OrderDetailsState>();

  Stream<OrderDetailsState> get stateStream => _stateSubject.stream;
  StreamSubscription? _updateStateListener;

  OrderStatusStateManager(
      this._ordersService, this._reportService, this._imageUploadService);

  void getOrderDetails(int orderId, OrderStatusScreenState screenState) {
    _stateSubject.add(OrderDetailsStateLoading(screenState));

    _ordersService.getOrderDetails(orderId).then((value) {
      if (value.hasError) {
        _stateSubject.add(
            OrderStatusErrorState(screenState, value.error ?? '', orderId));
      } else if (value.isEmpty) {
        _stateSubject.add(OrderDetailsEmptyState(
            screenState, S.current.homeDataEmpty, orderId));
      } else {
        _stateSubject
            .add(OrderDetailsStateCaptainOrderLoaded(screenState, value.data));
      }
    });
  }

  void updateOrder(
      UpdateOrderRequest request, OrderStatusScreenState screenState) {
    _stateSubject.add(OrderDetailsStateLoading(screenState));
    _ordersService.updateOrder(request).then((value) {
      if (value.hasError) {
        screenState.goBack(value.error);
      } else {
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message: S.current.updateOrderSuccess)
          ..show(screenState.context);
        getOrderDetails(request.id ?? -1, screenState);
      }
    });
  }

  void updateStoreOrder(UpdateStoreOrderStatusRequest request,
      OrderStatusScreenState screenState) {
    _stateSubject.add(OrderDetailsStateLoading(screenState));
    _ordersService.updateStoreOrderStatus(request).then((value) {
      if (value.hasError) {
        screenState.goBack(value.error);
      } else {
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message: S.current.updateOrderSuccess)
          ..show(screenState.context);
        _ordersService.getOrderDetails(request.orderNumber ?? -1).then((value) {
          if (value.hasError) {
            _stateSubject.add(OrderStatusErrorState(
                screenState, value.error ?? '', request.orderNumber ?? -1));
          } else if (value.isEmpty) {
            _stateSubject.add(OrderDetailsEmptyState(screenState,
                S.current.homeDataEmpty, request.orderNumber ?? -1));
          } else {
           var store = value.data.carts.singleWhere((element) => element.storeOwnerID == request.storeOwnerProfileId);
            _stateSubject.add(OrderDetailsStoreLoaded(screenState, store));
          }
        });
      }
    });
  }

  void updateInvoice(UpdateOrderRequest orderRequest,
      OrderInvoiceRequest request, OrderStatusScreenState screenState) {
    _stateSubject.add(OrderDetailsStateLoading(screenState));
    _ordersService.updateOrderBill(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: S.current.saveInvoiceFailed)
            .show(screenState.context);
      } else {
        if (request.isBilled != null) {
          _ordersService
              .billedForCompany(BilledCalculatedRequest(
                  orderNumber: request.orderNumber,
                  isBillCalculated: request.isBilled))
              .then((value) {
            if (value.hasError) {
              CustomFlushBarHelper.createError(
                      title: S.current.warnning,
                      message: S.current.saveInvoiceFailed)
                  .show(screenState.context);
            } else {
              updateOrder(orderRequest, screenState);
            }
          });
        } else {
          updateOrder(orderRequest, screenState);
        }
      }
    });
  }

  Future<void> uploadBill(
      OrderStatusScreenState screenState, String image, double totalPrice,
      [bool? isBilled]) async {
    await CustomFlushBarHelper.createSuccess(
      title: S.current.warnning,
      message: S.current.savingInvoice,
    ).show(screenState.context);
    await _imageUploadService.uploadImage(image).then((uploadedImageLink) {
      if (uploadedImageLink == null) {
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: S.current.saveInvoiceFailed)
          ..show(screenState.context);
      } else {
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message: S.current.saveInvoiceSuccess)
          ..show(screenState.context);
        screenState.saveBill(uploadedImageLink, totalPrice, isBilled);
      }
    });
  }

  Future report(int orderId, String reason) async {
    await _reportService.createReport(orderId, reason);
  }

  void sendOrderReportState(
      var orderId, bool answer, OrderStatusScreenState screenState) {
    _ordersService.sendOrderReportState(orderId, answer).then((value) {
      if (value != null) {
        screenState.sendState(true);
      } else {
        screenState.sendState(false);
      }
    });
  }

  void dispose() {
    _updateStateListener?.cancel();
  }
}
