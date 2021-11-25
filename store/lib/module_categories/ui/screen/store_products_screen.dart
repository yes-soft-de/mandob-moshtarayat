import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/authorization_routes.dart';
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
      widget._stateManager.getStoreProducts(this);
    });
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });

    super.initState();
  }
  void getStoreProducts(){
    widget._stateManager.getStoreProducts(this);
  }
//  void createProduct(CreateProductRequest request){
//    widget._stateManager.createProduct(this, request);
//  }

//  void updateProduct(UpdateProductRequest request) {
//    widget._stateManager.updateProduct(this,request);
//  }
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
//      floatingActionButton: ElevatedButton(
//        onPressed: (){
//          if (currentState is ProductStoreState){
//            showDialog(context: context, builder:(_){
//              return AddProductsForm(
//                state: currentState as ProductStoreState,
//                addProduct: (name,image,price,catID){
//                  Navigator.of(context).pop();
//                  createProduct(CreateProductRequest(
//                    productName: name,
//                    productImage: image,
//                    productPrice: price,
//                    storeProductCategoryID: catID.toInt(),
//                    storeOwnerProfileID: storeId
//                  ));
//                },
//              );
//            });
//          }
//        },
//        child: Padding(
//          padding: const EdgeInsets.all(16.0),
//          child: Text(S.current.addProducts,style: TextStyle(
//            color: Colors.white
//          ),),
//        ),
//        style: ElevatedButton.styleFrom(
//          shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.circular(25),
//          ),
//          elevation: 3
//        ),
//      ),
    );
  }
}
