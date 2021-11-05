import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_main/state_manager/home_state_manager.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';

import '../../global_nav_key.dart';

@injectable
class HomeScreen extends StatefulWidget {
  final HomeStateManager _stateManager;

  HomeScreen(this._stateManager);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTwaslnaAppBar.appBar(context,
          title: S.of(context).home, icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }),
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
                child: Opacity(
                    opacity: 0.1,
                    child: Image.asset(
                      ImageAsset.DELIVERY_MOTOR,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      height: 2000,
                    ))),
          ),
          state.getUI(context)
        ],
      ),
    );
  }

  late States state;

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    state = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      state = event;
     if (this.mounted){
       setState(() {
       });
     }
    });
    getReport();
    super.initState();
  }

  void getReport() {
    widget._stateManager.getReport(this);
  }
}
