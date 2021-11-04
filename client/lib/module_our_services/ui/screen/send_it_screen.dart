import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/authorization_routes.dart';
import 'package:mandob_moshtarayat/module_main/main_routes.dart';
import 'package:mandob_moshtarayat/module_our_services/request/send_it_request.dart';
import 'package:mandob_moshtarayat/module_our_services/state_manager/services_state_manager.dart';
import 'package:mandob_moshtarayat/module_our_services/ui/state/send_it_states/send_it_Loaded_state.dart';
import 'package:mandob_moshtarayat/module_our_services/ui/state/send_it_states/send_it_state.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';

@injectable
class SendItScreen extends StatefulWidget {
  final ServicesStateManager _stateManager;

  SendItScreen(this._stateManager);

  @override
  SendItScreenState createState() => SendItScreenState();
}

class SendItScreenState extends State<SendItScreen> {
  late SendItState currentState;
  LatLng? receiptPoint;
  LatLng? destinationPoint;
  late SendItRequest request;

  // Send It Loaded controller
  TextEditingController orderDetailsController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController receiptNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  String? payments;
  //

  @override
  void initState() {
    super.initState();
    currentState = SendItLoadedState(this);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void moveDecision(bool success, [String err = '']) {
    if (success) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(MainRoutes.MAIN_SCREEN, (route) => false);
      CustomFlushBarHelper.createSuccess(
        title: S.of(context).warnning,
        message: S.of(context).successCreateOrder,
      )..show(context);
    } else {
      Navigator.of(context).pop();
      CustomFlushBarHelper.createError(
          title: S.of(context).warnning, message: err)
        ..show(context);
    }
  }

  void postClientOrder() {
    widget._stateManager.SendItClientOrder(request, this);
  }

  void goToLogin() {
    Navigator.of(context)
        .pushNamed(AuthorizationRoutes.LOGIN_SCREEN, arguments: true);
    CustomFlushBarHelper.createError(
            title: S.current.warnning,
            message: S.current.pleaseLoginToMakeOrder)
        .show(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        appBar: currentState is SendItLoadedState
            ? AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                centerTitle: true,
                title: Text(
                  S.of(context).deliverForMe,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color),
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_back,
                            color:
                                Theme.of(context).brightness != Brightness.dark
                                    ? Theme.of(context).disabledColor
                                    : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                elevation: 0,
              )
            : null,
        body: currentState.getUI(context),
      ),
    );
  }
}
