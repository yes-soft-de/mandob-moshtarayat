import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/model/products_categories_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/update_product_category_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/screen/product_categories_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/state/product_category/product_categories_state.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/widget/product_categories_card.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/error_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/form_dialog.dart';

class ProductCategoriesLoadedState extends ProductCategoriesState {
  final ProductCategoriesScreenState screenState;
  final String? error;
  final bool empty;
  final List<ProductsCategoryModel>? model;

  ProductCategoriesLoadedState(this.screenState, this.model,
      {this.empty = false, this.error})
      : super(screenState) {
    if (error != null) {
      screenState.canAddCategories = false;
      screenState.refresh();
    }
  }

  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getStoreCategories();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getStoreCategories();
          });
    }
    return FixedContainer(
      child: CustomListView.custom(children: getCategories()),
    );
  }

  List<Widget> getCategories() {
    var context = screenState.context;
    List<Widget> widgets = [];
    if (model == null) {
      return widgets;
    }
    if (model!.isEmpty) return widgets;
    model?.forEach((element) {
      widgets.add(ProductCategoriesCard(
          categoryName: element.categoryName,
          dialog: formDialog(
            screenState.context,
            S.current.updateProductCategory,
            S.current.category,
            (name, image) {
              Navigator.of(context).pop();
              screenState.updateProductCategory(UpdateProductCategoryRequest(
                  storeOwnerProfileId: screenState.storeId,
                  productCategoryName: name,
                  id: element.id.toString()));
            },
            image: false,
            request: UpdateProductCategoryRequest(
                productCategoryName: element.categoryName),
          )));
    });
    widgets.add(SizedBox(
      height: 100,
    ));
    return widgets;
  }
}
