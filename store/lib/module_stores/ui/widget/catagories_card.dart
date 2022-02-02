import 'package:flutter/material.dart';

class CategoriesCard extends StatelessWidget {
  final String title;
  final String categoryId;
  final IconData icon;
  final bool selected;
  final Function(String)? onTap;

  CategoriesCard({required this.title,required this.icon,required this.selected,this.onTap,required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap:(){
          if (onTap != null){
            onTap!(categoryId);
          }
        },
        child: Container(
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color:selected ? Theme.of(context).primaryColor : Theme.of(context).backgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Icon(icon,size: 35,color: selected ? Colors.white : null,),
                SizedBox(height: 4,),
                Text(title,style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: selected ? Colors.white : null,
                ),textAlign: TextAlign.center,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
