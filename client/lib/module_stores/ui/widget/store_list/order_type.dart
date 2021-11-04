import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_our_services/services_routes.dart';
import 'package:mandob_moshtarayat/module_stores/store_routes.dart';
import 'package:mandob_moshtarayat/utils/models/store.dart';

class OrderType extends StatelessWidget {
  final StoreModel element;

  OrderType(this.element);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              S.of(context).orderType,
              style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Divider(
              thickness: 2.5,
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 55,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context)
                    .pushNamed(StoreRoutes.STORE_PRODUCTS, arguments: element);
              },
              child: Text(S.of(context).storeProducts,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1?.color)),
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 55,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed(ServicesRoutes.PRIVATE_ORDER,
                    arguments: element);
              },
              child: Text(
                S.of(context).privateOrder,
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1?.color),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
