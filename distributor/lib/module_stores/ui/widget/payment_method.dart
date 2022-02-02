import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';

class PaymentMethods extends StatelessWidget {

  final String name;
  final String amount;
  final String image;
  PaymentMethods({

   required this.name, required this.amount,required this.image
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4.0,
        child: InkWell(
          onTap: () => print("tapped"),
          child: Container(
            padding: EdgeInsets.only(top: 15.0, bottom: 15.0, right: 15.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 20.0),
                  child:CircleAvatar(radius: 35,backgroundImage: NetworkImage(image),),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text("$amount"),


                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}