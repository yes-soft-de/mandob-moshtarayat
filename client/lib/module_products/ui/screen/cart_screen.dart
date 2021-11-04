import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_orders/model/order_details_model.dart';
import 'package:mandob_moshtarayat/module_orders/request/client_order_request.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/module_orders/ui/widget/order_details/bill.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';
import 'package:mandob_moshtarayat/module_orders/ui/widget/order_details/order_chip.dart';

@injectable
class CartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTwaslnaAppBar.appBar(context, title: S.current.order),
      body:Stack(
        children: [
          ListView(
            padding: EdgeInsets.all(8),
            physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              ListTile(
                leading: Icon(Icons.info),
                title: Text(S.of(context).updateOrderNote),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                child: Divider(
                  color: Theme.of(context).backgroundColor,
                  thickness: 2.5,
                ),
              ),
              Flex(
                direction: Axis.vertical,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: ListTile(
                      leading: Icon(
                        Icons.shopping_cart_rounded,
                        color: Theme.of(context).disabledColor,
                        size: 25,
                      ),
                      title: Text(
                        S.of(context).orderList,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                  ListView(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    children: getOrdersList(<Products>[Products(
                      productID: 1,
                      countProduct: 1,
                      price: 10,
                      productName: 'name',
                      productsImage: ImageAsset.PLACEHOLDER
                    )],context),
                  ),
                  Container(
                    height: 8,
                  ),
                  Container(
                    width: double.maxFinite,
                    child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'chackout',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: BillCard(
                      id: null,
                      deliveryCost: 0,
                      orderCost: 0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 75,
              ),
            ],
          ),
        ],
      )
    );
  }
  List<Widget> getOrdersList(List<Products>? carts,context) {
    updateTotal();
    List<Widget> orderChips = [];
    carts?.forEach((element) {
      orderChips.add(SizedBox(
        key: ObjectKey(element),
        child: OrderChip(
          productID: element.productID!,
          title: element.productName ?? S.current.product,
          image: element.productsImage ?? ImageAsset.NETWORK,
          price: element.price!,
          currency: S.current.sar,
          quantity: (product) {
            if (product.countProduct == 0) {
              // screenState.clientOrderRequest?.products?.forEach((element) {
              //   if (element.productID == product.productID) {
              //     element.countProduct = 0;
              //   }
              // });
              cleanProducts();
           //   screenState.refresh();
            } else {
              // screenState.clientOrderRequest?.products?.forEach((element) {
              //   if (element.productID == product.productID) {
              //     element.countProduct = product.countProduct;
              //   }
              // });
            }
            updateTotal();
         //   screenState.refresh();
          },
          editable: true,
          defaultQuantity: element.countProduct!,
        ),
      ));
      orderChips.add(Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
        child: DottedLine(
          dashColor: Theme.of(context).backgroundColor,
          lineThickness: 2.5,
          dashLength: 6,
        ),
      ));
    });
    cleanProducts();
  //  screenState.refresh();
    return orderChips;
  }
  List<Products> toProducts(List<Item> carts) {
    List<Products> products = [];
    carts.forEach((element) {
      products.add(Products(
          productID: element.productID,
          countProduct: element.countProduct,
          price: element.productPrice,
          productsImage: element.productImage,
          productName: element.productName));
    });
    return products;
  }

  void updateTotal() {
    double currentTotal = 0;
    // screenState.clientOrderRequest?.products?.forEach((element) {
    //   currentTotal =
    //       (element.countProduct!.toDouble() * element.price!) + currentTotal;
    // });
    // total = currentTotal;
    // screenState.clientOrderRequest?.orderCost = total;
  }

  void cleanProducts() {
    // screenState.clientOrderRequest?.products
    //     ?.removeWhere((element) => element.countProduct == 0);
  }
}
