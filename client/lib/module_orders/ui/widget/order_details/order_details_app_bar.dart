import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_main/main_routes.dart';

class CustomOrderDetailsAppBar extends StatelessWidget {
  final GestureTapCallback? editTap;
  final GestureTapCallback? deleteTap;
  final bool collapsed;
  final bool edit;
  CustomOrderDetailsAppBar(
      {this.editTap,
      this.deleteTap,
      this.collapsed = false,
      this.edit = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16, top: 25),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => edit
                  ? Navigator.of(context).pushNamedAndRemoveUntil(
                      MainRoutes.MAIN_SCREEN, (route) => false,
                      arguments: 1)
                  : Navigator.of(context).pop(),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_back,
                  ),
                ),
              ),
            ),
            collapsed
                ? Text(
                    S.current.orderDetails,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  )
                : Spacer(
                    flex: 1,
                  ),
            Flex(
              direction: Axis.horizontal,
              children: [
                deleteTap != null
                    ? InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: deleteTap,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.85),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                Container(
                  width: 16,
                ),
                editTap != null
                    ? InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: editTap,
                        child: Container(
                          decoration: BoxDecoration(
                            color: collapsed
                                ? Theme.of(context).cardColor.withOpacity(0.5)
                                : Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.85),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
