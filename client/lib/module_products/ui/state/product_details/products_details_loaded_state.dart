import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_products/ui/screen/products_details_screen.dart';
import 'package:mandob_moshtarayat/utils/components/progresive_image.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';

class ProductDetailsLoadedState extends States {
  ProductDetailsScreenState screenState;

  ProductDetailsLoadedState(this.screenState) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Column(
        children: [
          Center(
              child: Text(
            'Iphone 12 pro',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          )),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: 150,
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: CustomNetworkImage(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  imageSource: 'https://assets.swappie.com/cdn-cgi/image/width=600,height=600,fit=contain,format=auto/SwappieiPhonex256gbt%C3%A4htiharmaa-1-1-1-600x600.jpg',
                ),
              ),
            ),
          ),
          Center(
              child: Text(
            'Buy this apple product from us ',
            style:
                TextStyle(color: Theme.of(context).disabledColor, fontSize: 17),
          )),
          Padding(
            padding: const EdgeInsets.only(top:16.0),
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        S.current.specification,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Padding(
                      padding: const EdgeInsets.only(left:16.0,right: 16),
                      child: Container(
                        width: 150,
                        child: Text(
                          'Blue color 128 gb space 4 camera 8 gb ram m1 chip ios os',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            height: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Theme.of(context).backgroundColor
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(S.current.rating),
                                  SizedBox(height: 12,),
                                  Text(S.current.discount),
                                  SizedBox(height: 12,),
                                  Text(S.current.sold),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: RatingBar.builder(
                                      ignoreGestures: true,
                                      initialRating: 3,
                                      minRating: 0,
                                      itemSize: 15,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {},
                                    ),
                                  ),
                                  SizedBox(height: 12,),
                                  Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.percent,
                                        size: 12,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        '10',
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12,),
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
                                        '2',
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
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Icon(FontAwesomeIcons.medal,color: Theme.of(context).disabledColor,size: 35,),
                                  SizedBox(height: 16,),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Theme.of(context).primaryColor
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('200 \$',style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                      ),),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Text(S.current.productQuantity,style: TextStyle(fontSize: 16),),
                        Spacer(flex: 1,),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Theme.of(context).backgroundColor,
                          ),
                          child: Row(
                            children: [
                              TextButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.horizontal(
                                          left: Localizations.localeOf(context)
                                              .languageCode ==
                                              'en'
                                              ? Radius.circular(25)
                                              : Radius.zero,
                                          right: Localizations.localeOf(context)
                                              .languageCode ==
                                              'en'
                                              ? Radius.zero
                                              : Radius.circular(25)),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  // if (cartModel.quantity > 0) {
                                  //   cartModel.quantity = cartModel.quantity - 1;
                                  //   setState(() {
                                  //     widget.quantity(cartModel);
                                  //   });
                                  // }
                                },
                                child: Icon(Icons.remove),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                child: Text('0'),
                              ),
                              TextButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.horizontal(
                                          left: Localizations.localeOf(context)
                                              .languageCode ==
                                              'en'
                                              ? Radius.zero
                                              : Radius.circular(25),
                                          right: Localizations.localeOf(context)
                                              .languageCode ==
                                              'en'
                                              ? Radius.circular(25)
                                              : Radius.zero),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  // cartModel.quantity = cartModel.quantity + 1;
                                  // setState(() {
                                  //   widget.quantity(cartModel);
                                  // });
                                },
                                child: Icon(Icons.add),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:16,right: 16,bottom: 16),
                    child: Row(
                      children: [
                        Text(S.current.totalPrice,style: TextStyle(fontSize: 16),),
                        Spacer(flex: 1,),
                        Container(
                          height: 40,
                          width: 155,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Theme.of(context).backgroundColor,
                          ),
                          child:Center(child: Text('200 \$',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 75,),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
