import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/utils/customIcon/mandob_icons_icons.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:mandob_moshtarayat/consts/urls.dart';
import 'package:mandob_moshtarayat/utils/customIcon/custom_icons.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';

class CustomNetworkImage extends StatelessWidget {
  final double height;
  final double width;
  final String imageSource;
  final bool assets;
  final Color? background;

  const CustomNetworkImage({
    required this.height,
    required this.width,
    required this.imageSource,
    this.assets = false,
    this.background,
  });

  @override
  Widget build(BuildContext context) {
    bool asset = assets;
    var image = imageSource;

    if (image.contains('assets/')) {
      if (image == '') {
        image = ImageAsset.PLACEHOLDER;
      }
      asset = true;
    }

    if (asset) {
      return ProgressiveImage.custom(
        height: height,
        width: width,
        placeholderBuilder: (context) {
          return Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: background ?? Theme.of(context).backgroundColor),
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Icon(
                   MandobIcons.logo,
                   size: height < 75 ? 15 : 30,
                 ),
                Padding(
                  padding:
                       EdgeInsets.only(left: 16.0, right: 16.0, top: height < 75 ? 4 : 10),
                  child: SizedBox(
                    width: (height / 3) - 2,
                    child: LinearProgressIndicator(
                        minHeight: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).textTheme.headline1!.color!)),
                  ),
                ),
              ],
            ),
          );
        },
        fadeDuration: const Duration(milliseconds: 750),
        thumbnail: AssetImage(image),
        image: AssetImage(image),
        fit: BoxFit.cover,
      );
    } else {
      if (!image.contains('http')) {
        image = Urls.IMAGES_ROOT + image;
      }
      return GestureDetector(
        onTap: () {
                   showDialog(
                context: context,
                builder: (_) {
                  return Scaffold(
                    appBar:AppBar(
                      backgroundColor: Colors.black,
                      elevation: 0,
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration:const BoxDecoration(
                              color: Colors.black38,
                              shape: BoxShape.circle,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.arrow_back,color: Colors.white,),
                            ),
                          ),
                        ),
                      ),
                    ),
                    backgroundColor: Colors.black,
                    body: PinchZoom(
                      child:Image.network(image),
                      resetDuration: const Duration(milliseconds: 150),
                      onZoomStart: () {},
                      onZoomEnd: () {},
                    ),
                  );
                });
        },
        child: ProgressiveImage.custom(
          height: height,
          width: width,
          placeholderBuilder: (context) {
            return Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: background ?? Theme.of(context).backgroundColor),
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    MandobIcons.logo,
                    size: height < 75 ? 15 : 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4),
                    child: SizedBox(
                      width: (height / 3) - 2,
                      child: LinearProgressIndicator(
                          minHeight: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).textTheme.headline1!.color!)),
                    ),
                  ),
                ],
              ),
            );
          },
          fadeDuration: const Duration(milliseconds: 750),
          thumbnail: NetworkImage(image),
          image: NetworkImage(image),
          fit: BoxFit.cover,
        ),
      );
    }
  }
}
