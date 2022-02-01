 import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_init/request/create_captain_profile/create_captain_profile_request.dart';
import 'package:mandob_moshtarayat/module_profile/model/profile_model.dart';
import 'package:mandob_moshtarayat/module_profile/request/create_store_request.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/components/custom_feild.dart';
import 'package:mandob_moshtarayat/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat/utils/components/map.dart';
import 'package:mandob_moshtarayat/utils/components/stacked_form.dart';
import 'package:mandob_moshtarayat/utils/effect/checked.dart';
import 'package:mandob_moshtarayat/utils/effect/hidder.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';

class UpdateProfileWidget extends StatefulWidget {
   final Function(String, String, String, String?, String?,String,String)
       updateMandob;
   final ProfileModel? request;

   UpdateProfileWidget({required this.updateMandob, this.request});

   @override
   _UpdateStoreWidgetState createState() => _UpdateStoreWidgetState();
 }

 class _UpdateStoreWidgetState extends State<UpdateProfileWidget> {
   final GlobalKey<FormState> _key = GlobalKey<FormState>();
   late TextEditingController _nameController;
   late TextEditingController _ageController;
   late TextEditingController _bankName ;
   late TextEditingController _bankAccountNumber;
   late TextEditingController _stcPay;
   String? imagePath;
   String? status;
   final ImagePicker _imagePicker = ImagePicker();
   int val = 1;
   @override
   Widget build(BuildContext context) {
     return StackedForm(
         child: Form(
           key: _key,
           child:Container(
             width: double.maxFinite,
             child: Center(
               child: Container(
                 constraints: BoxConstraints(
                   maxWidth: 600,
                 ),
                 child:  CustomListView
                     .custom(padding: EdgeInsets.only(right: 16, left: 16), children: [
                   Padding(
                     padding: const EdgeInsets.only(
                         left: 12.0, bottom: 8, right: 12, top: 16.0),
                     child: Text(
                       S.current.name,
                       style: TextStyle(fontWeight: FontWeight.bold),
                       textAlign: TextAlign.start,
                     ),
                   ),
                   CustomFormField(
                     controller: _nameController,
                     hintText: S.current.name,
                   ),


                   Padding(
                     padding: const EdgeInsets.only(
                         left: 12.0, bottom: 8, right: 12, top: 16.0),
                     child: Text(
                       S.current.age,
                       style: TextStyle(fontWeight: FontWeight.bold),
                       textAlign: TextAlign.start,
                     ),
                   ),
                   CustomFormField(
                     controller: _ageController,
                     hintText: S.current.age,
                   ),

                   Padding(
                     padding: const EdgeInsets.all(16.0),
                     child: Center(
                         child: Text(
                           S.current.yourImage,
                           style: TextStyle(fontWeight: FontWeight.bold),
                         )),
                   ),
                   InkWell(
                     onTap: () {
                       _showPicker(context);
                     },
                     child: Checked(
                       child: Icon(
                         Icons.image,
                         size: 150,
                       ),
                       checked: imagePath != null,
                       checkedWidget: SizedBox(
                           height: 150,
                           child: ClipRRect(
                               borderRadius: BorderRadius.circular(25),
                               child: imagePath!.contains('http')
                                   ? Image.network(imagePath!)
                                   : Image.file(
                                 File(imagePath ?? ''),
                                 fit: BoxFit.cover,
                               ))),
                     ),
                   ),
                   //account
                   Padding(
                     padding: const EdgeInsets.only(
                         left: 12.0, bottom: 8, right: 12, top: 16.0),
                     child: Text(
                       S.current.bankName,
                       style: TextStyle(fontWeight: FontWeight.bold),
                       textAlign: TextAlign.start,
                     ),
                   ),
                   CustomFormField(
                     controller: _bankName,
                     hintText: S.current.bankName,
                   ),

                   //bank account Number
                   Row(children: [
                     Flexible(
                       flex: 1,
                       child: ListTile(
                         title: Text(S.of(context).bankAccountNumber,style: TextStyle(fontSize: 12)),
                         leading: Radio(
                           value: 1,
                           groupValue: val,
                           onChanged: (value) {
                             val = value as  int;
                            setState(() {

                            });
                           },
                           activeColor: Theme.of(context).accentColor,
                         ),
                       ),
                     ),
                     Flexible(
                       flex: 1,
                       child: ListTile(
                         title: Text(S.of(context).stcPayCode,style: TextStyle(fontSize: 12),),
                         leading: Radio(
                             value: 2,
                             groupValue: val,
                             onChanged: (value) {
                               val = value as  int;
                             setState(() {

                             });

                             },
                             activeColor: Theme.of(context).accentColor
                         ),
                       ),
                     ),
                   ],),

                   Visibility(
                     visible: val==1,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Padding(
                           padding: const EdgeInsets.only(
                               left: 12.0, bottom: 8, right: 12, top: 16.0),
                           child: Text(
                             S.current.bankAccountNumber,
                             style: TextStyle(fontWeight: FontWeight.bold),
                             textAlign: TextAlign.start,
                           ),
                         ),
                         CustomFormField(
                           controller: _bankAccountNumber,
                           hintText: S.current.bankAccountNumber,
                           validator:val==1?true: false,
                         ),
                       ],),
                   ),
                   Visibility(
                     visible: val==2,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Padding(
                           padding: const EdgeInsets.only(
                               left: 12.0, bottom: 8, right: 12, top: 16.0),
                           child: Text(
                             S.current.stc,
                             style: TextStyle(fontWeight: FontWeight.bold),
                             textAlign: TextAlign.start,
                           ),
                         ),
                         CustomFormField(
                           controller: _stcPay,
                           hintText: S.current.stc,
                           validator:val==2?true: false,
                         ),
                       ],),
                   ),
                   // Store Shift

                   SizedBox(
                     height: 100,
                   ),
                 ]),
               ),
             ),
           ),
         ),
         label: S.current.update,
         onTap: () {
           if (_key.currentState!.validate() &&
               imagePath != null
             ) {
             if(imagePath!=null && imagePath!.contains('http')){
               imagePath = imagePath!.split('upload/').last;
             }
             widget.updateMandob(
               _nameController.text.trim(),
               imagePath!,
               status??'inactive',_bankName.text,_bankAccountNumber.text,_stcPay.text,_ageController.text
             );
           } else {
             CustomFlushBarHelper.createError(
                     title: S.current.warnning,
                     message: S.current.pleaseCompleteTheForm)
                 .show(context);
           }
         });
   }

   @override
   void initState() {
     _nameController = TextEditingController();
     _ageController = TextEditingController();
     _bankAccountNumber = TextEditingController();
     _bankName = TextEditingController();
     _stcPay = TextEditingController();
     if (widget.request != null) {
       _nameController.text = widget.request?.mandobName ?? '';
       _ageController.text = widget.request?.age.toString() ?? '';
       imagePath = widget.request?.image ?? '';
       status = widget.request?.status ?? 'inactive';
       _bankAccountNumber.text = widget.request?.bankNumber??'';
       _bankName.text = widget.request?.bankName??'';
       _stcPay.text = widget.request?.stcPay??'';
       val = _bankAccountNumber.text != '' ? 1 : 2;
     }
     super.initState();
   }


   void _openCamera() async {

     _imagePicker.getImage(source: ImageSource.camera ,imageQuality: 70).then((value){
       if(value != null)
         setState(() {
           imagePath = value.path;
         });
     });
   }
   void _openGallery() async {

     _imagePicker.getImage(source: ImageSource.gallery ,imageQuality: 70).then((value){
       if(value != null)
         setState(() {
           imagePath = value.path;
         });
     });
   }
   void _showPicker(context) {
     showModalBottomSheet(
         context: context,
         builder: (BuildContext bc) {
           return SafeArea(
             child: Container(
               child: new Wrap(
                 children: <Widget>[
                   new ListTile(
                       leading: new Icon(Icons.photo_library),
                       title: new Text(S.of(context).gallery),
                       onTap: () {
                         _openGallery();
                         Navigator.of(context).pop();
                       }),
                   new ListTile(
                     leading: new Icon(Icons.photo_camera),
                     title: new Text(S.of(context).camera),
                     onTap: () {
                       _openCamera();
                       Navigator.of(context).pop();
                     },
                   ),
                 ],
               ),
             ),
           );
         }
     );
   }
 }
