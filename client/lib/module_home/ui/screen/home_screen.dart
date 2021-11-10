import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_home/state_manager/home_state_manager.dart';
import 'package:mandob_moshtarayat/module_home/ui/state/home_loaded_state.dart';
import 'package:mandob_moshtarayat/module_home/ui/state/home_loading_state.dart';
import 'package:mandob_moshtarayat/module_home/ui/state/home_state.dart';

@injectable
class HomeScreen extends StatefulWidget {
  final HomeStateManager _homeStateManager;

  HomeScreen(this._homeStateManager);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  HomeState? currentState;
  late AsyncSnapshot snapshot = AsyncSnapshot.nothing();

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getHomeData() async {
    widget._homeStateManager.getHomeData(this);
  }

  void getCategories(catId,categories) async {
    widget._homeStateManager.getHomeFilterData(this,catId,categories);
  }
  void getProducts(catId)  {
    widget._homeStateManager.getFilteredProducts(this,catId);
  }


  @override
  void initState() {
    currentState = HomeLoadingState(this);
    widget._homeStateManager.getHomeData(this);
    widget._homeStateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    widget._homeStateManager.productsStream.listen((event) {
      snapshot = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        body: currentState?.getUI(context),
      ),
    );
  }
}
