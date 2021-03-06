import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/model/StoreCategoriesModel.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/update_store_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/model/stores_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/stores_routes.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/ui/screen/stores_inactive_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/ui/widget/add_store_widget.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/costom_search.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/error_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/progresive_image.dart';

class StoresInActiveLoadedState extends States {
  final StoresInActiveScreenState screenState;
  final String? error;
  final bool empty;
  final List<StoresModel>? model;
  final List<StoreCategoriesModel>? categories;

  StoresInActiveLoadedState(this.screenState, this.model, this.categories,
      {this.empty = false, this.error})
      : super(screenState) {
    if (screenState.searchKey != '') {
      //  search.text = screenState.searchKey;
    }
    if (error != null) {
      screenState.canAddCategories = false;
      screenState.refresh();
    }
  }

  String? id;
//  TextEditingController search = TextEditingController();
  String? search;

  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getStores();
        },
        error: error,
      );
    } else if (empty && search == null) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getStores();
          });
    }
    return Container(
      width: double.maxFinite,
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: 18.0, right: 18.0, bottom: 16, top: 16),
                child: CustomDeliverySearch(
                  //  controller: search,
                  hintText: S.current.searchForStore,
                  onChanged: (s) {
                    if (s == '' || s.isEmpty) {
                      search = null;
                      screenState.getStores();
                    } else {
                      search = s.toString();
                      screenState.getStoresFilter(s.toString());
                    }
                  },
                ),
              ),
              Expanded(
                child: CustomListView.custom(children: getStores()),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> getChoices() {
    List<DropdownMenuItem<String>> items = [];
    categories?.forEach((element) {
      items.add(DropdownMenuItem(
        value: element.id.toString(),
        child: Text(element.categoryName),
      ));
    });
    return items;
  }

  List<Widget> getStores() {
    List<Widget> widgets = [];
    if (model == null) {
      return widgets;
    }
    if (model!.isEmpty) return widgets;
    for (var element in model!) {
      if (element.categoryId != id && id != null) {
        continue;
      }
      widgets.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () {
            Navigator.of(screenState.context).pushNamed(StoresRoutes.STORE_INFO,
                arguments: StoresModel(
                    id: element.id,
                    storeOwnerName: element.storeOwnerName,
                    phone: element.phone,
                    deliveryCost: element.deliveryCost,
                    image: element.image,
                    privateOrders: element.privateOrders,
                    hasProducts: element.hasProducts,
                    categoryId: '',
                    stcPay: element.stcPay,
                    bankNumber: element.bankNumber,
                    bankName: element.bankName,
                    status: element.status));
          },
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(screenState.context).primaryColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: SizedBox(
                      height: 75,
                      width: 75,
                      child: CustomNetworkImage(
                        imageSource: element.image,
                        width: 75,
                        height: 75,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: getTile(element.storeOwnerName),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        barrierDismissible: false,
                        context: screenState.context,
                        builder: (context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Scaffold(
                              appBar: CustomMandoobAppBar.appBar(context,
                                  title: S.current.updateStore),
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              body: UpdateStoreWidget(
                                categories: getChoices(),
                                request: UpdateStoreRequest(
                                    commission: element.commission,
                                    id: element.id.toString(),
                                    bankName: element.bankName,
                                    bankAccountNumber: element.bankNumber,
                                    stcPay: element.stcPay,
                                    storeOwnerName: element.storeOwnerName,
                                    hasProducts: element.hasProducts ? 1 : 0,
                                    privateOrders:
                                        element.privateOrders ? 1 : 0,
                                    image: element.image,
                                    openingTime:
                                        element.openingTime?.toIso8601String(),
                                    closingTime:
                                        element.closingTime?.toIso8601String(),
                                    status: element.status,
                                    baseImage: element.imageUrl,
                                    storeCategoryId:
                                        int.parse(element.categoryId)),
                                updateStore: (id,
                                    name,
                                    image,
                                    products,
                                    privateOrder,
                                    open,
                                    close,
                                    status,
                                    commission,
                                    bankName,
                                    bankNumber,
                                    stc) {
                                  Navigator.of(context).pop();
                                  screenState.updateStore(UpdateStoreRequest(
                                      status: status,
                                      id: element.id.toString(),
                                      storeOwnerName: name,
                                      storeCategoryId:
                                          int.parse(element.categoryId),
                                      image: image,
                                      hasProducts: products ? 1 : 0,
                                      privateOrders: privateOrder ? 1 : 0,
                                      openingTime: open,
                                      closingTime: close,
                                      commission: double.parse(commission),
                                      bankAccountNumber: bankNumber,
                                      bankName: bankName,
                                      stcPay: stc));
                                },
                              ),
                            ),
                          );
                        });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(screenState.context)
                            .backgroundColor
                            .withOpacity(0.2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ));
    }

    widgets.add(SizedBox(height: 75));
    return widgets;
  }

  Widget getTile(String text) {
    return Text(text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold));
  }
}
