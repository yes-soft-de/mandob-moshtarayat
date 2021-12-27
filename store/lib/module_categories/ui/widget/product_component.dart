import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/utils/components/progresive_image.dart';
import 'package:mandob_moshtarayat/utils/customIcon/mandob_custom_icon.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductComponent extends StatelessWidget {
  final String productId;
  final String title;
  final String description;
  final String image;
  final String price;
  final String discount;
  final double rating;

  ProductComponent(
      {required this.title,required this.image,required this.discount,required this.rating,required this.description,required this.productId,required this.price});

  @override
  Widget build(BuildContext context) {
    num disPrice =
        (num.parse(price) * (100 - num.parse(discount))) / 100;
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
//                      Container(
//                        constraints:
//                        BoxConstraints(maxHeight: 50, maxWidth: 200),
//                        child: Text(
//                          description,
//                          style: TextStyle(
//                            fontSize: 14,
//                          ),
//                          textAlign: TextAlign.start,
//                        ),
//                      ),
                      Container(
                          constraints:
                          const BoxConstraints(maxHeight: 50, maxWidth: 200),
                          child: RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                    text:price,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        decoration: discount != '0'
                                            ? TextDecoration.lineThrough
                                            : null)),
                                const TextSpan(text: ' '),
                                TextSpan(
                                    text: discount == '0'
                                        ? ' '
                                        : disPrice.toStringAsFixed(2),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red)),
                                const TextSpan(text: ' '),
                                TextSpan(
                                    text: S.current.sar,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: discount != '0'
                                            ? Colors.red
                                            : null)),
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        constraints: BoxConstraints(maxWidth: 200),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  S.current.rating,
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                RatingBar.builder(
                                  ignoreGestures: true,
                                  initialRating: rating,
                                  minRating: 0,
                                  itemSize: 15,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding:
                                  EdgeInsets.symmetric(horizontal: 0.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onRatingUpdate: (rating) {},
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  S.current.discount,
                                  style: TextStyle(
                                    fontSize: 13,
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
                                      color:discount == '0' ?Colors.red : Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      '$discount',
                                      style: TextStyle(
                                        fontSize: 12,
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
                      height: 125,
                      width: 125,
                      imageSource:image),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}