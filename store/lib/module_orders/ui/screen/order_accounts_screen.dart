//import 'package:flutter/material.dart';
//import 'package:injectable/injectable.dart';
//import 'package:mandob_moshtarayat/abstracts/states/loading_state.dart';
//import 'package:mandob_moshtarayat/abstracts/states/state.dart';
//import 'package:mandob_moshtarayat/generated/l10n.dart';
//import 'package:mandob_moshtarayat/global_nav_key.dart';
//import 'package:mandob_moshtarayat/module_orders/state_manager/captains_from_state_manager.dart';
//import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
//
//@injectable
//class OrdersAccountScreen extends StatefulWidget {
//  final OrdersAccountStateManager _stateManager;
//
//  OrdersAccountScreen(this._stateManager);
//
//  @override
//  OrdersAccountScreenState createState() => OrdersAccountScreenState();
//}
//
//class OrdersAccountScreenState extends State<OrdersAccountScreen> {
//  late States currentState;
//
//  @override
//  void initState() {
//    currentState = LoadingState(this);
//    widget._stateManager.stateStream.listen((event) {
//      currentState = event;
//      refresh();
//    });
//    widget._stateManager.getCaptains(this);
//    super.initState();
//  }
//
//  void getCaptains() {
//    widget._stateManager.getCaptains(this);
//  }
//
//  void refresh() {
//    if (mounted) {
//      setState(() {});
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: CustomTwaslnaAppBar.appBar(context,
//          title: S.of(context).ordersAccount, icon: Icons.menu, onTap: () {
//        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
//      }),
//      body: currentState.getUI(context),
//    );
//  }
//}
