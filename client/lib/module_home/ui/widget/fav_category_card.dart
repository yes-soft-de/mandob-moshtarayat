import 'package:flutter/material.dart';

class FavCategoryCard extends StatelessWidget {
  final String name;
  
  const FavCategoryCard({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).primaryColor,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(name,style: const TextStyle(
            color: Colors.white
          ),),
        ),
      ),
    );
  }
}
