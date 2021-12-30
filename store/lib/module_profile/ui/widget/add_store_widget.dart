 import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_profile/request/create_store_request.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/components/custom_feild.dart';
import 'package:mandob_moshtarayat/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat/utils/components/map.dart';
import 'package:mandob_moshtarayat/utils/components/stacked_form.dart';
import 'package:mandob_moshtarayat/utils/effect/checked.dart';
import 'package:mandob_moshtarayat/utils/effect/hidder.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';

class UpdateStoreWidget extends StatefulWidget {
   final Function(String, String, String, bool, bool, String?, String?,String,String,String,String)
       updateStore;
   final CreateStoreRequest? request;

   UpdateStoreWidget({required this.updateStore, this.request});

   @override
   _UpdateStoreWidgetState createState() => _UpdateStoreWidgetState();
 }

 class _UpdateStoreWidgetState extends State<UpdateStoreWidget> {
   final GlobalKey<FormState> _key = GlobalKey<FormState>();
   late TextEditingController _nameController;
   late TextEditingController _phoneController;
   late TextEditingController _deliveryController;
   late TextEditingController _bankName ;
   late TextEditingController _bankAccountNumber;
   late TextEditingController _stcPay;
   LatLng? storeLocation;
   String? imagePath;
   bool privateOrder = false;
   bool products = false;
   String? catId;
   MapController mapController = MapController();
   TimeOfDay? openingTime;
   TimeOfDay? closingTime;
   String status = 'active';
   var date = DateTime.now();
   final ImagePicker _imagePicker = ImagePicker();
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
                       S.current.storeName,
                       style: TextStyle(fontWeight: FontWeight.bold),
                       textAlign: TextAlign.start,
                     ),
                   ),
                   CustomFormField(
                     controller: _nameController,
                     hintText: S.current.storeName,
                   ),

                   Padding(
                     padding: const EdgeInsets.only(
                         left: 12.0, bottom: 8, right: 12, top: 16.0),
                     child: Text(
                       S.current.phoneNumber,
                       style: TextStyle(fontWeight: FontWeight.bold),
                       textAlign: TextAlign.start,
                     ),
                   ),
                   CustomFormField(
                     controller: _phoneController,
                     hintText: S.current.phoneNumber,
                     validator: true,
                     phone: true,
                     numbers: true,
                   ),

                   Hider(
                     active: false,
                     child: Padding(
                       padding: const EdgeInsets.only(bottom: 32, top: 32.0),
                       child: InkWell(
                         borderRadius: BorderRadius.circular(25),
                         onTap: () {
                           storeLocation = null;
                           mapController = MapController();
                           showDialog(
                               builder: (_) {
                                 return Scaffold(
                                   appBar: CustomMandopAppBar.appBar(context,
                                       title: S.current.storeLocation,
                                       actions: [
                                         TextButton(
                                             onPressed: () {
                                               Navigator.of(context).pop();
                                             },
                                             child: Text(S.current.save)),
                                       ]),
                                   body: MapClientOrder(
                                     mapController,
                                     onTap: (newPos) {
                                       storeLocation = newPos;
                                       setState(() {});
                                     },
                                   ),
                                 );
                               },
                               context: context);
                         },
                         child: Container(
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(25),
                             color: storeLocation == null
                                 ? Theme.of(context).primaryColor
                                 : Colors.green,
                           ),
                           child: Center(
                             child: Padding(
                               padding: const EdgeInsets.all(16.0),
                               child: Text(
                                 S.current.storeLocation,
                                 style: TextStyle(
                                     fontWeight: FontWeight.bold, color: Colors.white),
                                 textAlign: TextAlign.start,
                               ),
                             ),
                           ),
                         ),
                       ),
                     ),
                   ),
                   SizedBox(
                     height: 16,
                   ),
                   Padding(
                     padding: const EdgeInsets.all(16.0),
                     child: Center(
                         child: Text(
                           S.current.storeImage,
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
                   ),

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
                   ),
                   // Store Shift
                   Padding(
                     padding: const EdgeInsets.only(top: 32.0, left: 16, right: 16),
                     child: Align(
                         alignment: AlignmentDirectional.centerStart,
                         child: Text(
                           S.current.workTime + ' : ',
                           style: TextStyle(fontWeight: FontWeight.bold),
                         )),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(top: 16.0),
                     child: Material(
                       borderRadius: BorderRadius.circular(25),
                       elevation: 0.5,
                       child: ListTile(
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(25),
                         ),
                         onTap: () {
                           showTimePicker(
                             context: context,
                             initialTime: TimeOfDay.now(),
                           ).then((value) {
                             if (value == null) {
                             } else {
                               openingTime = value;
                               setState(() {});
                             }
                           });
                         },
                         title: Text(S.of(context).openingTime),
                         trailing: Container(
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                 color: Theme.of(context).backgroundColor),
                             child: Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Text(
                                 openingTime?.format(context).toString() ?? '00:00 ',
                                 style: TextStyle(fontWeight: FontWeight.bold),
                               ),
                             )),
                       ),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(top: 16.0),
                     child: Material(
                       borderRadius: BorderRadius.circular(25),
                       elevation: 0.5,
                       child: ListTile(
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(25),
                         ),
                         onTap: () {
                           showTimePicker(
                             context: context,
                             initialTime: TimeOfDay.now(),
                           ).then((value) {
                             if (value == null) {
                             } else {
                               closingTime = value;
                               setState(() {});
                             }
                           });
                         },
                         title: Text(S.of(context).closingTime),
                         trailing: Container(
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                 color: Theme.of(context).backgroundColor),
                             child: Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Text(
                                 closingTime?.format(context).toString() ?? '00:00 ',
                                 style: TextStyle(fontWeight: FontWeight.bold),
                               ),
                             )),
                       ),
                     ),
                   ),
                   // Store Services
                   Padding(
                     padding: const EdgeInsets.only(top: 32.0, left: 16, right: 16),
                     child: Align(
                         alignment: AlignmentDirectional.centerStart,
                         child: Text(
                           S.current.storeService + ' : ',
                           style: TextStyle(fontWeight: FontWeight.bold),
                         )),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(top: 8.0),
                     child: CheckboxListTile(
                         value: products,
                         title: Text(S.of(context).products),
                         onChanged: (v) {
                           products = v ?? false;
                           setState(() {});
                         }),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(bottom: 16),
                     child: CheckboxListTile(
                         value: privateOrder,
                         title: Text(S.of(context).privateOrder),
                         onChanged: (v) {
                           privateOrder = v ?? false;
                           setState(() {});
                         }),
                   ),
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
               imagePath != null &&
               openingTime != null &&
               closingTime != null) {
             if(imagePath!=null && imagePath!.contains('http')){
               imagePath = imagePath!.split('upload/').last;
             }
             widget.updateStore(
               _nameController.text.trim(),
               _phoneController.text.trim(),
               imagePath!,
               products,
               privateOrder,
               DateTime(date.year, date.month,
                   date.day, openingTime!.hour, openingTime!.minute)
                   .toUtc()
                   .toIso8601String(),
               DateTime(date.year, date.month,
                   date.day, closingTime!.hour, closingTime!.minute)
                   .toUtc()
                   .toIso8601String(),
               status,_bankName.text,_bankAccountNumber.text,_stcPay.text
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
     _deliveryController = TextEditingController();
     _phoneController = TextEditingController();
     _bankAccountNumber = TextEditingController();
     _bankName = TextEditingController();
     _stcPay = TextEditingController();
     if (widget.request != null) {
       _nameController.text = widget.request?.storeOwnerName ?? '';
       _phoneController.text = widget.request?.phone ?? '';
       imagePath = widget.request?.image ?? '';
       products = widget.request?.hasProducts == 1 ? true : false;
       privateOrder = widget.request?.privateOrders == 1 ? true : false;
       openingTime = TimeOfDay.fromDateTime(DateTime.parse(
           widget.request?.openingTime ?? DateTime.now().toString()));

       closingTime = TimeOfDay.fromDateTime(DateTime.parse(
           widget.request?.closingTime ?? DateTime.now().toString()));
       status = widget.request?.status ?? 'active';
       _bankAccountNumber.text = widget.request?.bankAccountNumber??'';
       _bankName.text = widget.request?.bankName??'';
       _stcPay.text = widget.request?.stcPay??'';
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
