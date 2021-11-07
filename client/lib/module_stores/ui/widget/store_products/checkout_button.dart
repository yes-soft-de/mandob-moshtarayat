import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';

class CheckoutButton extends StatelessWidget {
  final String total;
  final VoidCallback onPressed;
  final String currency;
  final String quantity;
  CheckoutButton(
      {required this.total, required this.onPressed, this.currency = 'SAR',required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: double.maxFinite,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).cardColor.withOpacity(0.2),
              Theme.of(context).cardColor,
              Theme.of(context).cardColor,
              Theme.of(context).cardColor,
              Theme.of(context).cardColor,
              Theme.of(context).cardColor,
            ]),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 65,
          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              icon: Icon(Icons.shopping_cart,color: Colors.white,),
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: onPressed,
              label: Text(
                '${S.of(context).showingCart} ( $quantity ${S.current.item} | $total $currency  )',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
