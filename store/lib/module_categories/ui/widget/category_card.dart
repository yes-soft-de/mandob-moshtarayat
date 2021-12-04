
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/utils/components/progresive_image.dart';


class CategoryCard extends StatelessWidget {
  final String title;
  final int id;
  final Function(int)? onTap;
  final bool selected;

  CategoryCard({required this.title,required this.selected,required this.id ,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap!(id);
      },
      child: SizedBox(
        height: 100,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: selected?Theme.of(context).accentColor : Theme.of(context).cardColor,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis),
          ),
        ),
      ),
    );
  }
}