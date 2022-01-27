import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/states/loading_state.dart';

import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/di/di_config.dart';
import 'package:mandob_moshtarayat/module_products/state_manager/cart_state_manager.dart';
import 'package:mandob_moshtarayat/module_products/ui/state/cart/cart_loaded_state.dart';
import 'package:mandob_moshtarayat/module_stores/presistance/cart_hive_box_helper.dart';

@injectable
class CartScreen extends StatefulWidget {
  final CartStateManager _stateManager;
  const CartScreen(
    this._stateManager,
  );
  @override
  State<CartScreen> createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  late States currentState;
  @override
  void initState() {
    if (getIt<CartHiveHelper>().getCart().isEmpty) {
      currentState = CartLoadedState(this);
    } else {
      currentState = LoadingState(this);
      widget._stateManager.validateCart(this);
    }
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
    return currentState.getUI(context);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }
}
