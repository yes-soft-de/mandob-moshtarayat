import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/authorization_routes.dart';
import 'package:mandob_moshtarayat/module_my_notifications/state_manager/my_notifications_state_manager.dart';
import 'package:mandob_moshtarayat/module_my_notifications/ui/state/my_notifications/my_notifications_loading_state.dart';
import 'package:mandob_moshtarayat/module_my_notifications/ui/state/my_notifications/my_notifications_state.dart';
import 'package:mandob_moshtarayat/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';

@injectable
class MyNotificationsScreen extends StatefulWidget {
  final MyNotificationsStateManager _stateManager;
  MyNotificationsScreen(this._stateManager);

  @override
  MyNotificationsScreenState createState() => MyNotificationsScreenState();
}

class MyNotificationsScreenState extends State<MyNotificationsScreen> {
  late MyNotificationsState currentState;

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getNotifications() async {
    widget._stateManager.getNotifications(this);
  }

  void goToLogin() {
    Navigator.of(context)
        .pushNamed(AuthorizationRoutes.LOGIN_SCREEN, arguments: 3);
  }

  @override
  void initState() {
    currentState = MyNotificationsLoadingState(this);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      widget._stateManager.getNotifications(this);
    });
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
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
        body: FixedContainer(child: currentState.getUI(context)),
      ),
    );
  }
}
