import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/cost_details_response.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/progresive_image.dart';
import 'package:mandob_moshtarayat_dashboad/utils/customIcon/mandob_icons_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mandob_moshtarayat_dashboad/utils/effect/hidder.dart';

class ProductComponent extends StatelessWidget {
  final String productId;
  final String title;
  final String image;
  final String price;
  final String discount;
  final String commission;
  final bool isCommission;
  final CostDetailsResponse costDetailsResponse;
  ProductComponent(
      {required this.title,
      required this.image,
      required this.discount,
      required this.productId,
      required this.price,
      required this.commission,
      required this.isCommission,
      required this.costDetailsResponse});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
        child: Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis),
                  SizedBox(
                    height: 8,
                  ),
                  Hider(
                    active: isCommission,
                    child: Row(
                      children: [
                        Text(
                          S.current.commission + '  ',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          commission,
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Hider(
                    active: costDetailsResponse.priceWithCommission != null,
                    child: Row(
                      children: [
                        Text(
                          S.current.priceWithComission + '  ',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          costDetailsResponse.priceWithCommission!
                              .toStringAsFixed(1),
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    constraints: BoxConstraints(maxWidth: 200),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [],
                        ),
                        Column(
                          children: [
                            Text(
                              S.current.discount,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold
                              ),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Icon(
                                  MandobIcons.discount,
                                  size: 15,
                                  color: discount == '0'
                                      ? Colors.red
                                      : Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  '$discount',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold
                                  ),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right:8.0,left: 8.0,bottom: 18),
                          child: Text('|' ,style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        Column(
                          children: [
                            Text(
                              S.current.price,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold
                              ),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.shoppingBag,
                                  size: 12,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  '$price',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold
                                  ),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            )),
            SizedBox(
              width: 16,
            ),
            SizedBox(
              height: 125,
              width: 125,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: CustomNetworkImage(
                      height: 125, width: 125, imageSource: image),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
