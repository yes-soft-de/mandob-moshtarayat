import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';

class WebImageLoader extends StatelessWidget {
  final String filePath;
  const WebImageLoader({
    Key? key,
    required this.filePath,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: XFile(filePath).readAsBytes(),
      initialData: Image.asset(ImageAsset.LOGO),
      builder: (context, snapshoot) {
        if (snapshoot.connectionState == ConnectionState.waiting) {
          return Image.asset(ImageAsset.LOGO);
        } else {
          return Image.memory(snapshoot.data as Uint8List);
        }
      });
  }
}
