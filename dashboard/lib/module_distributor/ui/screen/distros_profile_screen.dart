import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/captains_routes.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/request/accept_captain_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/state_manager/captain_profile_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/request/accept_distro_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/state_manager/distros_profile_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/payments_routes.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';

import '../../distros_routes.dart';

@injectable
class DistrosProfileScreen extends StatefulWidget {
  final DistrosProfileStateManager _stateManager;

  DistrosProfileScreen(this._stateManager);

  @override
  DistributorProfileScreenState createState() => DistributorProfileScreenState();
}

class DistributorProfileScreenState extends State<DistrosProfileScreen> {
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

  void getCaptain() {
    //  widget._stateManager.getCaptainProfile(this, captainId);
  }

  void enableDistro(AcceptDistroRequest request) {
     widget._stateManager.acceptDistroProfile(this, distorId, request);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  int distorId = -1;
  int  Id = -1;

  @override
  Widget build(BuildContext context) {
    if (Id == -1) {
      var arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null && arg is List<int>) {
        distorId = arg.last;
        Id = arg.first;
          widget._stateManager.getDistorProfile(this, Id);
      }
    }
    return Scaffold(
      appBar: CustomMandoobAppBar.appBar(context,
          title: S.current.profile,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: InkWell(
                  customBorder: CircleBorder(),
                  onTap: () {
                    Navigator.pushNamed(context, DistributorRoutes.DISTRO_BALANCE,
                        arguments: distorId);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.account_balance,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
      body: currentState.getUI(context),
    );
  }
}
