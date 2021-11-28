import 'dart:async';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_captain/module_orders/state_manager/update/update_state_manager.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/state/update/update_state.dart';

@injectable
class UpdateScreen extends StatefulWidget {
  final UpdateStateManager _stateManager;

  UpdateScreen(
    this._stateManager,
  );

  @override
  UpdateScreenState createState() => UpdateScreenState();
}

class UpdateScreenState extends State<UpdateScreen> {
  StreamSubscription? _updateSubscription;
  UpdateListState? currentState;
  @override
  void initState() {
    super.initState();
    _updateSubscription = widget._stateManager.updateStream.listen((event) {
      currentState = event;
      setState(() {});
    });
    widget._stateManager.getUpdates(this);
  }

  @override
  Widget build(BuildContext context) {
    return currentState != null
        ? currentState!.getUI(context)
        : UpdateListStateLoading(this).getUI(context);
  }

  @override
  void dispose() {
    if (_updateSubscription != null) {
      _updateSubscription?.cancel();
    }
    super.dispose();
  }
}
