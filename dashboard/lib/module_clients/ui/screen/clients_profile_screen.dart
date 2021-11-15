import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/captains_routes.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/request/accept_captain_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/state_manager/captain_profile_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';

@injectable
class ClientProfileScreen extends StatefulWidget {
  final ClientProfileStateManager _stateManager;

  ClientProfileScreen(this._stateManager);

  @override
  ClientProfileScreenState createState() => ClientProfileScreenState();
}

class ClientProfileScreenState extends State<ClientProfileScreen> {
  late States currentState;

  @override
  void initState() {
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    super.initState();
  }

  void getClientProfile() {
    widget._stateManager.getClientProfile(this, clientId);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  int clientId = -1;

  @override
  Widget build(BuildContext context) {
    if (clientId == -1) {
      var arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null && arg is int) {
        clientId = arg;
        widget._stateManager.getClientProfile(this, clientId);
      }
    }
    return Scaffold(
      appBar: CustomTwaslnaAppBar.appBar(
        context,
        title: S.current.profile,
      ),
      body: currentState.getUI(context),
    );
  }
}
