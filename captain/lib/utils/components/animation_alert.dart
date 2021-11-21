import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_captain/generated/l10n.dart';

class CustomAnimationAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: double.maxFinite,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 50.0, end: width),
            duration: Duration(milliseconds: 650),
            builder: (context, double val, _) {
              return Container(
                width: val,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: Theme.of(context).primaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Icon(
                        Icons.info_rounded,
                        color: Colors.white,
                      ),
                      Container(
                        width: 8,
                      ),
                      val == width
                          ? Expanded(
                              child: Text(
                                S.of(context).chooseAddressNote,
                                style:
                                    TextStyle(color: Colors.white, height: 1.1),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
