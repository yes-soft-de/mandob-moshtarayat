import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mandob_moshtarayat/utils/components/progresive_image.dart';


class OrderChip extends StatefulWidget {
  final String title;
  final String image;
  final price;
  final String currency;
  final int defaultQuantity;
  final bool editable;
  final int productID;
  OrderChip({
    required this.title,required this.productID,required this.image,required this.price,this.currency = 'SAR',this.defaultQuantity = 0,this.editable = true});
  @override
  _OrderChipState createState() => _OrderChipState();
}

class _OrderChipState extends State<OrderChip> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.maxFinite,
      height: 100,
      child:Flex(
        direction: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: CustomNetworkImage(
                 imageSource:widget.image,
                  width:double.maxFinite,
                  height:double.maxFinite ,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 26.0),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text('${widget.price} ${widget.currency}',style: TextStyle(
                      fontWeight: FontWeight.w600,
                  ),overflow: TextOverflow.ellipsis,)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 150,
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(widget.title,style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                  ),overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(25),
                      color:
                      Theme.of(context).primaryColor,
                    ),
                    child:Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right:16,left: 16),
                        child: Text(widget.defaultQuantity.toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

