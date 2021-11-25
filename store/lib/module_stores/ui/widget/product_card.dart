import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/utils/components/progresive_image.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final String image;
  final GestureTapCallback? onTap;
  const HomeCard(
      {Key? key, required this.title, required this.image, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 125,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                CustomNetworkImage(
                  width: 200,
                  height: 200,
                  imageSource: image,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 35,
                    width: 1000,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.00),
                            Colors.black.withOpacity(0.35),
                            Colors.black.withOpacity(0.4),
                            Colors.black.withOpacity(0.45),
                            Colors.black.withOpacity(0.45),
                          ]),
                    ),
                    child: Center(
                        child: Text(
                      title,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
