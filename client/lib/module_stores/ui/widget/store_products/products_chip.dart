import 'package:flutter/material.dart';

class ProductsChips extends StatelessWidget {
  final int id;
  final String title;
  final bool active;
  final Function(String,int) onChange;
  ProductsChips({required this.id,required this.title, required this.active,required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right:8.0,left:8.0),
      child: InkWell(
        onTap: (){
          onChange(title,id);
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:active ? Theme.of(context).primaryColor : null),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                color:active ? Colors.white : null,
              ),
            ),
          )),
        ),
      ),
    );
  }
}
