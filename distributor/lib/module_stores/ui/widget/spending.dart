import 'package:flutter/material.dart';

class Spendings extends StatelessWidget {

  final String name;
  final String amount;
  Spendings({

    required this.name,
    required this.amount,
  }) ;


  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(15.0)),
      elevation: 4.0,
      child: InkWell(
        onTap: () => print("tapped"),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
//                    SizedBox(height: 10.0),
                      Column(
                        children: <Widget>[
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 10.0),
                          Text("$amount",
                            style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
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