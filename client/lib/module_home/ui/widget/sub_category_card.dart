import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/utils/components/progresive_image.dart';

class SubCategoryCard extends StatelessWidget {
  final String title;
  final IconData? icon;
  final String? image;
  final bool selected;
  final Function(String)? onTap;
  final String id;
  const SubCategoryCard(
      {required this.id,
      this.image,
      required this.title,
      required this.icon,
      required this.selected,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: () {
          if (onTap != null) {
            onTap!(id);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: selected
                ? Theme.of(context).primaryColor
                : Theme.of(context).backgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4.0),
            child: Row(
              children: [
                icon != null
                    ? Icon(
                        icon,
                        color: selected ? Colors.white : null,
                      )
                    : Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: CustomNetworkImage(
                            imagePreview: false,
                            imageSource: image ?? '',
                            width: 40,
                            height: 40,
                          ),
                        ),
                      ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: selected ? Colors.white : null),
                ),
                const SizedBox(
                  width: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
