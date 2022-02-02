import 'dart:collection';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_stores/ui/screen/store_products_screen.dart';
import 'package:mandob_moshtarayat/module_stores/ui/state/store_products/store_products_state.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';

class StoreProductsErrorState extends StoreProductsState {
  final List<String> errors;
  final int id;
  StoreProductsScreenState screenState;

  StoreProductsErrorState(this.screenState, this.errors, this.id)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    List<String> errs = LinkedHashSet<String>.from(errors).toList();
    return Scaffold(
      appBar: CustomTwaslnaAppBar.appBar(context,
          title: S.current.storeProducts, buttonBackground: Colors.red),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Flex(
            direction: Axis.vertical,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Flushbar(
                  title: (errs.length > 1
                          ? S.of(context).errOc
                          : S.of(context).thisErrorHappened) +
                      ' : ',
                  messageText: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: getErrorMessage(errs, errs.length > 1)),
                  icon: Icon(
                    Icons.info,
                    size: 28.0,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                  flushbarStyle: FlushbarStyle.FLOATING,
                ),
              ),
              Container(
                height: 24,
              ),
              SvgPicture.asset(
                ImageAsset.ERROR_SVG,
                height: MediaQuery.of(context).size.height * 0.5,
              ),
              Container(
                height: 32,
              ),
              Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 0),
                      onPressed: () async {
                        screenState.getStoresProducts(id);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          S.of(context).refresh,
                          style: TextStyle(color: Colors.white),
                        ),
                      ))),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getErrorMessage(List<String> errs, bool indexed) {
    List<Widget> errorMessages = [];
    int i = 1;
    String index;
    errs.forEach((element) {
      index = indexed ? '$i- ' : '';
      errorMessages.add(Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          index + element,
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ));
      i++;
    });
    return errorMessages;
  }
}
