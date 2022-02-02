import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/ui/screen/stores_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/ui/state/store_categories/stores_state.dart';

class StoresLoadingState extends StoresState {
  StoresLoadingState(StoresScreenState screenState) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
