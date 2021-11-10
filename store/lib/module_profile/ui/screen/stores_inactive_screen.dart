// import 'package:flutter/material.dart';
// import 'package:injectable/injectable.dart';
// import 'package:mandob_moshtarayat/abstracts/states/loading_state.dart';
// import 'package:mandob_moshtarayat/abstracts/states/state.dart';
// import 'package:mandob_moshtarayat/generated/l10n.dart';
// import 'package:mandob_moshtarayat/global_nav_key.dart';
// import 'package:mandob_moshtarayat/module_categories/request/update_store_request.dart';
// import 'package:mandob_moshtarayat/module_stores/request/create_store_request.dart';
// import 'package:mandob_moshtarayat/module_stores/state_manager/stores_inactive_state_manager.dart';
// import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
//
// @injectable
// class StoresInActiveScreen extends StatefulWidget {
//   final StoresInActiveStateManager _stateManager;
//
//   StoresInActiveScreen(this._stateManager);
//
//   @override
//   StoresInActiveScreenState createState() => StoresInActiveScreenState();
// }
//
// class StoresInActiveScreenState extends State<StoresInActiveScreen> {
//   late States currentState;
//   bool canAddCategories = true;
//   String searchKey = '';
//   @override
//   void initState() {
//     currentState = LoadingState(this);
//     widget._stateManager.stateStream.listen((event) {
//       currentState = event;
//       if (mounted) {
//         refresh();
//       }
//     });
//     widget._stateManager.getStores(this);
//     super.initState();
//   }
//
//   void getStores() {
//     widget._stateManager.getStores(this);
//   }
//   void getStoresFilter(String key) {
//     searchKey = key;
//     widget._stateManager.getStoresFilter(this,key);
//   }
//
//   void updateStore(UpdateStoreRequest request){
//     widget._stateManager.updateStore(this, request);
//   }
//
//   void refresh() {
//     if (mounted) {
//       setState(() {});
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomMandopAppBar.appBar(context,
//           title: S.of(context).storesList, icon: Icons.menu, onTap: () {
//             GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
//           }),
//       body: currentState.getUI(context),
//     );
//   }
// }
