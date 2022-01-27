import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/utils/components/rate_dialog.dart';
import 'package:mandob_moshtarayat/utils/effect/hidder.dart';

class CustomStoresProductsAppBar extends StatelessWidget {
  final Function(double) onRate;
  final bool isLogin;
  final String image;
  const CustomStoresProductsAppBar(
      {required this.onRate, required this.isLogin, required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 25),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          Hider(
            active: isLogin,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 25),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    // show the dialog
                    showDialog(
                      context: context,
                      builder: (context) => RatingAlertDialog(
                        image: image,
                        title: S.current.rateStore,
                        message: S.current.rateStoreMessage,
                        onPressed: (rate) {
                          onRate(rate);
                        },
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.yellow),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
