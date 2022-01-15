import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_about/state_manager/about_screen_state_manager.dart';
import 'package:mandob_moshtarayat/module_about/ui/states/about/about_state.dart';
import 'package:mandob_moshtarayat/module_about/ui/states/about/about_state_page_captain.dart';
import 'package:mandob_moshtarayat/module_auth/authorization_routes.dart';

@injectable
class AboutScreen extends StatefulWidget {
  final AboutScreenStateManager _stateManager;

  AboutScreen(this._stateManager);

  @override
  State<StatefulWidget> createState() => AboutScreenState();


}

class AboutScreenState extends State<AboutScreen> {
  void moveToRegister() {
    Navigator.of(context).pushNamed(AuthorizationRoutes.REGISTER_SCREEN);
  }
  void refresh() {
    setState(() {
    });
  }
  late AboutState _currentState;

  @override
  void initState() {
    _currentState = AboutStatePageCaptain(this);
    widget._stateManager.stateStream.listen((event) {
      _currentState = event;
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final node = FocusScope.of(context);
        if (node.canRequestFocus) {
          node.unfocus();
        }
      },
      child: Scaffold(
          body:_currentState.getUI(context),
    ));
  }
}
//move to register
