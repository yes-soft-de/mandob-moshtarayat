import 'package:flutter/material.dart';

class CategoriesCard extends StatelessWidget {
  final String title;
  final String categoryId;
  final String? image;
  final IconData? icon;
  final bool selected;
  final Function(String)? onTap;

  CategoriesCard(
      {required this.title,
      this.image,
      required this.selected,
      this.icon,
      this.onTap,
      required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: () {
          if (onTap != null) {
            onTap!(categoryId);
          }
        },
        child: Container(
          constraints: BoxConstraints(minWidth: 100),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: selected
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).disabledColor,
                    offset: Offset(0.1, 0.1),
                    spreadRadius: 0.2,
                    blurRadius: 5),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                icon != null
                    ? Icon(
                        icon,
                        color: selected ? Colors.white : null,
                        size: 35,
                      )
                    : Image.network(
                        image ?? '',
                        color: selected
                            ? Colors.white
                            : Theme.of(context).iconTheme.color,
                        width: 35,
                        height: 35,
                      ),
                SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: selected ? Colors.white : null,
                    ),
                    textAlign: TextAlign.center,
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
