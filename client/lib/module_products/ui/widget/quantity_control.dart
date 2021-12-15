// ignore_for_file: must_be_immutable

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/hive/objects/cart_model/cart_model.dart';

class QuantityControlWidget extends StatefulWidget {
  int quantity;
  final CartModel model;
  final Function(CartModel) onSelect;
  QuantityControlWidget(
      {this.quantity = 0, required this.model, required this.onSelect});
  @override
  _QuantityControlWidgetState createState() => _QuantityControlWidgetState();
}

class _QuantityControlWidgetState extends State<QuantityControlWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 155,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                      left: Localizations.localeOf(context).languageCode == 'en'
                          ? const Radius.circular(25)
                          : Radius.zero,
                      right:
                          Localizations.localeOf(context).languageCode == 'en'
                              ? Radius.zero
                              : const Radius.circular(25)),
                ),
              ),
            ),
            onPressed: widget.quantity > 0
                ? () {
                    widget.quantity -= 1;
                    widget.model.quantity = widget.quantity;
                    widget.onSelect(widget.model);
                    Flushbar(
                      titleSize: 0,
                      duration: const Duration(milliseconds: 1000),
                      title: '',
                      message: S.current.cartItemRemoved,
                      backgroundColor: Theme.of(context).primaryColor,
                    ).show(context);
                    setState(() {});
                  }
                : null,
            child: const Icon(Icons.remove),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text(widget.quantity.toString()),
          ),
          TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                      left: Localizations.localeOf(context).languageCode == 'en'
                          ? Radius.zero
                          : const Radius.circular(25),
                      right:
                          Localizations.localeOf(context).languageCode == 'en'
                              ? const Radius.circular(25)
                              : Radius.zero),
                ),
              ),
            ),
            onPressed: () {
              widget.quantity += 1;
              widget.model.quantity = widget.quantity;
              Flushbar(
                titleSize: 0,
                duration: const Duration(milliseconds: 1000),
                title: '',
                message: S.current.cartItemAdded,
                backgroundColor: Theme.of(context).primaryColor,
              ).show(context);
              widget.onSelect(widget.model);
              setState(() {});
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
