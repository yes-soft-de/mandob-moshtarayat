import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/module_products/ui/state/cart/cart_loaded_state.dart';

@injectable
class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  late States currentState;
  @override
  void initState() {
    currentState = CartLoadedState(this);
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
