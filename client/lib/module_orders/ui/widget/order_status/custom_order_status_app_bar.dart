import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/utils/components/rate_dialog.dart';
import 'package:mandob_moshtarayat/utils/effect/hidder.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';

class CustomOrderStatusAppBar extends StatelessWidget {
  final Function(double) onRate;
  final bool hide;
  CustomOrderStatusAppBar({required this.onRate, this.hide = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.maxFinite,
      child: Padding(
        padding: EdgeInsets.only(
          left: 16.0,
          right: 16,
          top: MediaQuery.of(context).size.height * 0.025,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Text(
                S.of(context).orderStatus,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
              Opacity(
                opacity: hide ? 0 : 1,
                child: InkWell(
                  onTap: hide
                      ? null
                      : () {
                          showDialog(
                            context: context,
                            builder: (context) => RatingAlertDialog(
                              title: S.current.rateCaptain,
                              message: S.current.rateCaptainMessage,
                              image: ImageAsset.DELIVERY_MOTOR,
                              onPressed: (rate) {
                                onRate(rate);
                              },
                            ),
                          );
                        },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.star,
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
    );
  }
}
