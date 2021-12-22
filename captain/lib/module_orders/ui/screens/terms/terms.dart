import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_captain/module_orders/state_manager/terms/terms_state_manager.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/state/terms/terms_state.dart';

@injectable
class TermsScreen extends StatefulWidget {
  final TermsStateManager _stateManager;

  TermsScreen(
    this._stateManager,
  );

  @override
  TermsScreenState createState() => TermsScreenState();
}

class TermsScreenState extends State<TermsScreen> {
  TermsListState? currentState;

  void refresh() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget._stateManager.termsStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    widget._stateManager.getTerms(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: currentState!.getUI(context),
      ),
    );
  }
}
