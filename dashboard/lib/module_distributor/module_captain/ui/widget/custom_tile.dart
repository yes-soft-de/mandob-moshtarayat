import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/utils/effect/scaling.dart';

class CustomTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final num value;

  CustomTile(this.icon, this.text, this.value);

  @override
  Widget build(BuildContext context) {
    bool currency = S.current.countOrdersDelivered != text;
    return ScalingWidget(
      milliseconds: 1250,
      fade: true,
      child: ListTile(
        leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor,
            ),
            child: Center(
                child: Icon(
              icon,
              color: Colors.white,
            ))),
        title: Text(text),
        trailing: Container(
          constraints:
              BoxConstraints(maxWidth: 120, minWidth: 95, maxHeight: 55),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${value} ${currency ? S.current.sar : S.current.sOrder}',
              style: TextStyle(
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
      ),
    );
  }
}
