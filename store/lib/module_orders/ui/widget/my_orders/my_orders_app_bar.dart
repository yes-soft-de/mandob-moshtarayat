import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/utils/components/costom_search.dart';
import 'package:mandob_moshtarayat/utils/effect/hidder.dart';
import 'package:mandob_moshtarayat/utils/text_style/text_style.dart';

class MyOrdersAppBar extends StatelessWidget {
  const MyOrdersAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        SizedBox(
          height: 16,
        ),
        Padding(
          padding:
              const EdgeInsets.only(right: 25.0, left: 25, top: 16, bottom: 16),
          child: Container(
            width: double.maxFinite,
            child: Text(
              S.of(context).orders,
              style: StyleText.appBarHeaderStyle,
              textAlign: TextAlign.start,
            ),
          ),
        ),
        Hider(
          active: false,
          child: Padding(
            padding: const EdgeInsets.only(right: 25.0, left: 25, top: 16),
            child: CustomDeliverySearch(
              hintText: S.of(context).searchForOrder,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 16),
          child: Divider(
            color: Theme.of(context).backgroundColor,
            thickness: 2,
          ),
        ),
      ],
    );
  }
}
