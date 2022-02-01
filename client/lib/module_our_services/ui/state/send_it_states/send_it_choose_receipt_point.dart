import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_orders/ui/widget/client_order/map_client_order.dart';
import 'package:mandob_moshtarayat/module_our_services/ui/screen/send_it_screen.dart';
import 'package:mandob_moshtarayat/module_our_services/ui/state/send_it_states/send_it_finish_order.dart';
import 'package:mandob_moshtarayat/module_our_services/ui/state/send_it_states/send_it_state.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_our_services/ui/widget/custom_app_bar.dart';

class SendItChooseReceiptState extends SendItState {
  SendItChooseReceiptState(SendItScreenState screenState) : super(screenState);
  final _mapController = MapController();
  LatLng? receiptPoint;
  @override
  Widget getUI(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        screenState.currentState = SendItFinishOrderState(screenState);
        screenState.refresh();
        return false;
      },
      child: Scaffold(
        appBar: CustomAppBar.sendItBar(context,
            title: S.of(context).chooseReceiptPoint, onTap: () {
          screenState.currentState = SendItFinishOrderState(screenState);
          screenState.refresh();
        }),
        body: Stack(
          children: [
            MapClientOrder(
              _mapController,
              onTap: (value) {
                receiptPoint = value;
                screenState.refresh();
              },
              defaultPoint: screenState.receiptPoint,
            ),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(25),
                  onTap: () {
                    screenState.receiptPoint = receiptPoint;
                    screenState.refresh();
                    screenState.currentState =
                        SendItFinishOrderState(screenState);
                  },
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        S.of(context).save,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
