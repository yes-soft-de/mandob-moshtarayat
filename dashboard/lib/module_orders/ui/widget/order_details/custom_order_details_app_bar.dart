import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';

class CustomOrderDetailsAppBar extends StatelessWidget {
  final GestureTapCallback onTap;
  final GestureTapCallback onSave;
  CustomOrderDetailsAppBar({required this.onTap, required this.onSave});

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
          alignment: AlignmentDirectional.centerStart,
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: onTap,
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
                S.of(context).updateOrders,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: onSave,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.save,
                      color: Colors.white,
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
