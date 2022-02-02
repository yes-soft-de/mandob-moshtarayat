import 'package:flutter/rendering.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/consts/urls.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';

import 'package:flutter/material.dart';
 import 'package:mandob_moshtarayat/module_profile/model/profile_model.dart';
 import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';
 import 'package:qr_flutter/qr_flutter.dart';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

@injectable
class MyCodeScreen extends StatefulWidget {
  MyCodeScreen( );

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<MyCodeScreen> {
  ProfileModel? profileModel;
  String? id;
  File? file;
  final key = GlobalKey();
 late List<bool>  selected;
 late bool apple;
 late bool google;
 late String store;

  @override
  void initState() {
    google = true;
    apple = false;
    selected = [google ,apple];
    store = 'google';
    super.initState();
  }

  var args;
  @override
  Widget build(BuildContext context) {
        args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is ProfileModel) {
      profileModel = args;
      id =profileModel?.mandobID;
    }
    return Scaffold(
      appBar: CustomMandobAppBar.appBar(context,
          title: S.of(context).myCode),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    color: Theme.of(context).dialogBackgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(children: [
                        CircleAvatar(backgroundImage: NetworkImage(profileModel?.image??''),radius: 45,),
                        SizedBox(height: 10,),
                        Text(profileModel?.mandobName??'' , style: TextStyle(fontSize: 22 , fontWeight: FontWeight.bold),),
                        SizedBox(height: 8,),
                        Text(profileModel?.phone??'' ,style: TextStyle(fontSize: 13 )),
                        SizedBox(height: 15,),
                        RepaintBoundary(
                          key: key,
                          child: Container(
                            color: Colors.white,
                            child: QrImage(
                              data: Urls.GOOGLE_LINK +'$id'+'/'+'$store',
                              version: QrVersions.auto,
                              size: 230.0,
                             ),
                          ),
                        ),
                        SizedBox(height: 15,),
                        ToggleButtons(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(children: [Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(Icons.android),
                            ),Text('Google')],),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(children: [Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(Icons.ios_share),
                            ),Text('Apple')],),
                          ),
                        ], isSelected: selected,onPressed: (v){
                          if(v==0){
                            google = true;
                            apple =false;
                            selected = [google ,apple];
                            store='google';
                          }else{
                            google = false;
                            apple =true;
                            selected = [google ,apple];
                            store='apple';
                          }
                          setState(() {
                          });
                        }),
                      ],),
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton.icon(

                    icon: Icon(Icons.share,color: Colors.white,),
                    onPressed: () async{
                      try {
                        RenderRepaintBoundary boundary = key.currentContext!
                            .findRenderObject() as RenderRepaintBoundary;

                        var image = await boundary.toImage();
                        ByteData? byteData =
                            await image.toByteData(format: ImageByteFormat.png);
                        Uint8List pngBytes = byteData!.buffer.asUint8List();

                        final appDir = await getApplicationDocumentsDirectory();

                        var datetime = DateTime.now();

                        file = await File('${appDir.path}/$datetime.png').create();

                        await file?.writeAsBytes(pngBytes);

                      await Share.shareFiles(
                      [file!.path],
                      mimeTypes: ["image/png"],
                      text: 'Scan QR',
                      );
                      } catch (e) {
                      print(e.toString());
                      }
                    },
                    label: Text(S.of(context).share,style: TextStyle(color: Colors.white),),
                    style: OutlinedButton.styleFrom(
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.orange),
                      ),
                    ),
                  ),
                ),
              ],
            ),
//          children: [
////            CircleAvatar(backgroundImage: NetworkImage(''),)
//
//          ],
          ),
        ),
      ),
    );
  }


}
