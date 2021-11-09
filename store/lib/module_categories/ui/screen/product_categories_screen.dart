import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/global_nav_key.dart';
import 'package:mandob_moshtarayat/module_categories/request/create_products_request.dart';
import 'package:mandob_moshtarayat/module_categories/request/update_product_category_request.dart';
import 'package:mandob_moshtarayat/module_categories/state_manager/products_category_state_manager.dart';
import 'package:mandob_moshtarayat/module_categories/ui/state/product_category/product_categories_loading_state.dart';
import 'package:mandob_moshtarayat/module_categories/ui/state/product_category/product_categories_state.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/components/floated_button.dart';
import 'package:mandob_moshtarayat/utils/effect/hidder.dart';
import 'package:mandob_moshtarayat/utils/helpers/form_dialog.dart';

@injectable
class ProductCategoriesScreen extends StatefulWidget {
  final ProductsCategoryStateManager _stateManager;

  ProductCategoriesScreen(this._stateManager);

  @override
  ProductCategoriesScreenState createState() => ProductCategoriesScreenState();
}

class ProductCategoriesScreenState extends State<ProductCategoriesScreen> {
  late ProductCategoriesState currentState;
  bool canAddCategories = true;

  @override
  void initState() {

    currentState = ProductCategoriesLoadingState(this);

    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });

    super.initState();
  }

  void getStoreCategories() {

    widget._stateManager.getProductCategory(this,storeId??-1);

  }

  void addCategory(CreateProductsCategoriesRequest request) {

    widget._stateManager.createProductCategory(this, request);

  }

  void updateProductCategory(UpdateProductCategoryRequest request){
    widget._stateManager.updateProductCategory(this, request, storeId??-1);
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
        widget._stateManager.getProductCategory(this,storeId??-1);
      }
    }
    return Scaffold(
      appBar: CustomTwaslnaAppBar.appBar(context,
          title: S.of(context).productCategories,),
      body: currentState.getUI(context),
      floatingActionButton: Hider(
        active: canAddCategories,
        child: FloatedIconButton(
          text: S.current.addNewCategory,
          icon: Icons.add_circle_rounded,
          onPressed: (){
            showDialog(
                context: context,
                builder: (_) {
                  return formDialog(
                      context, S.current.addNewCategory, S.current.category,
                          (name, image) {
                        Navigator.of(context).pop();
                        addCategory(CreateProductsCategoriesRequest(productCategoryName: name,storeOwnerProfileId: storeId));
                      },image: false);
                });
          },
        ),
      ),
    );
  }
}
