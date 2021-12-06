import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/authorization_routes.dart';
import 'package:mandob_moshtarayat/module_categories/model/products_categories_model.dart';
import 'package:mandob_moshtarayat/module_categories/state_manager/store_products_state_manager.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';

@injectable
class StoreProductScreen extends StatefulWidget {
  final StoreProductsStateManager _stateManager;

  StoreProductScreen(this._stateManager);

  @override
  StoreProductScreenState createState() =>
      StoreProductScreenState();
}

class StoreProductScreenState
    extends State<StoreProductScreen> {
   late States currentState;
    bool save = true;

  @override
  void initState() {
    currentState = LoadingState(this);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      widget._stateManager.getCategoriesLevelOneWithAllProducts(this,'');
    });
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });

    super.initState();
  }
  void getStoreProducts(String name){
    widget._stateManager.getStoreProducts(this,name);
  }
  void getStoreProductLevelTwo(int idSub,int idMain,List<ProductsCategoryModel>? catOne,List<ProductsCategoryModel>? catTwo){
    widget._stateManager.getStoreProductLevelTwo(this,idSub ,idMain: idMain,catOne: catOne,catTwo: catTwo);
  }
  void getCategoriesLevelOneWithAllProducts(String name){
    widget._stateManager.getCategoriesLevelOneWithAllProducts(this,name);
  }

  void getCategoriesLevelTwoWithProducts(int storeCategoryId,List<ProductsCategoryModel>? catOne) {
    widget._stateManager.getCategoriesLevelTwoWithProducts(this,storeCategoryId,catOne);
  }
  void goToLogin(){
    Navigator.of(context).pushReplacementNamed(AuthorizationRoutes.LOGIN_SCREEN,arguments:1);
    CustomFlushBarHelper.createError(title:S.current.warnning, message:S.current.pleaseLoginToContinue).show(context);
  }
  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }
   bool flagArgs = true;
   int? storeId;

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && flagArgs){
      if (args is int) {
        storeId = args;
        flagArgs = false;
      }
    }
    return Scaffold(
      appBar:
          CustomMandopAppBar.appBar(context, title: S.current.storeProducts),
      body: currentState.getUI(context),
    );
  }
}
