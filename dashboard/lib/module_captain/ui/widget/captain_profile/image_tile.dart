import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/progresive_image.dart';

class ImageTile extends StatelessWidget {
  final String title;
  final String image;

  ImageTile({required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 8, right: 8),
          child: Container(
              width: 150,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor.withOpacity(0.25),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                    child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16, top: 16),
          child: Container(
            width: 75,
            height: 75,
            child: Center(
              child: ClipOval(
                child: Container(
                  width: 75,
                  height: 75,
                  child: CustomNetworkImage(
                    imageSource: image,
                    width: double.maxFinite,
                    height: double.maxFinite,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
