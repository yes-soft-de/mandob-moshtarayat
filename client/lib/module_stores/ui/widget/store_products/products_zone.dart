import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';

class ProductsZone extends StatelessWidget {
  final bool loading;
  final List<Widget> children;
  final AsyncSnapshot snapshot;
  ProductsZone(
      {required this.loading, required this.children, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Container(
          height: 125,
          width: double.maxFinite,
          child: Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: CircularProgressIndicator()));
    } else if (snapshot.hasError) {
      return Column(
        children: [
          SvgPicture.asset(
            ImageAsset.ERROR_SVG,
            height: 125,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Flushbar(
              title: S.of(context).thisErrorHappened,
              message: snapshot.error.toString(),
              icon: Icon(
                Icons.info,
                size: 28.0,
                color: Colors.white,
              ),
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(10),
              flushbarStyle: FlushbarStyle.FLOATING,
            ),
          ),
        ],
      );
    } else if (snapshot.hasData || children.isNotEmpty) {
      return ListView(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        children: children,
      );
    } else {
      return Column(
        children: [
          SvgPicture.asset(ImageAsset.EMPTY_SVG, height: 125),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                S.of(context).homeDataEmpty,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
            ),
          ),
        ],
      );
    }
  }
}
