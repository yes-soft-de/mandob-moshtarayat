import 'package:flutter/material.dart';

class SubCategoryCard extends StatelessWidget {

  final String title;
  final IconData icon;
  final bool selected;
  final Function(String)? onTap;

  SubCategoryCard({required this.title,required this.icon,required this.selected, this.onTap});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(12.0),
      child: InkWell(
        borderRadius:  BorderRadius.circular(25),
        onTap: (){
          if (onTap!= null){
            onTap!(title);
          }
        },
        child: Container(
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color:selected ?Theme.of(context).primaryColor : Theme.of(context).backgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left:8.0,right: 8.0),
            child: Row(
              children: [
                Icon(icon,color: selected ? Colors.white: null),
                SizedBox(width: 8,),
                Text(title,textAlign: TextAlign.center,style: TextStyle(
                  color:selected ? Colors.white : null
                ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
