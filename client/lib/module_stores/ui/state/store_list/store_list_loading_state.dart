import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_stores/ui/screen/store_list_screen.dart';
import 'package:mandob_moshtarayat/module_stores/ui/state/store_list/store_list_state.dart';

class StoreListLoadingState extends StoreListState {
  StoreListLoadingState(StoreListScreenState screenState) : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
