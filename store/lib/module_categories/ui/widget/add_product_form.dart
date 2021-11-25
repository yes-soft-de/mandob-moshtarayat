import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_categories/request/update_product_request.dart';
import 'package:mandob_moshtarayat/module_categories/ui/state/product_category/product_categories_state.dart';

import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/components/custom_feild.dart';
import 'package:mandob_moshtarayat/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat/utils/components/stacked_form.dart';
import 'package:mandob_moshtarayat/utils/effect/checked.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';

class AddProductsForm extends StatefulWidget {
  final Function(String, String, num,num) addProduct;
  final ProductCategoriesState? state;

  AddProductsForm({required this.addProduct, this.state});

  @override
  _AddProductsFormState createState() => _AddProductsFormState();
}

class _AddProductsFormState extends State<AddProductsForm> {

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  String? imagePath;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomMandopAppBar.appBar(context, title: S.current.addProducts),
      body: StackedForm(
          child: Form(
            key: _key,
            child: FixedContainer(child: CustomListView.custom(
                padding: EdgeInsets.only(right: 16,left: 16),
                children: [
//                  Hider(
//                    active: true,
//                    child: Container(
//                      decoration: BoxDecoration(
//                          borderRadius: BorderRadius.circular(25),
//                          color: Theme.of(context).backgroundColor
//                      ),
//                      child: Center(
//                        child: DropdownButton(
//                          value:catId,
//                          items:widget.state!.get(),
//                          onChanged: (v){
//                            catId = v.toString();
//                            setState(() {
//                            });
//                          },
//                          hint: Text(S.current.chooseCategory,style: TextStyle(
//                              fontWeight: FontWeight.bold
//                          ),),
//                          underline: SizedBox(),
//                          icon: Padding(
//                            padding: const EdgeInsets.all(4.0),
//                            child: Icon(Icons.arrow_drop_down_rounded),
//                          ),
//                        ),
//                      ),
//                    ),
//                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0,bottom: 8,right: 12,top: 16.0),
                    child: Text(S.current.productName,style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                  ),
                  CustomFormField(
                    controller: _nameController,
                    hintText: S.current.productName,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0,bottom: 8,right: 12,top: 16.0),
                    child: Text(S.current.productPrice,style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                  ),
                  CustomFormField(
                    controller: _priceController,
                    hintText: S.current.productPrice,
                    numbers: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0,bottom: 8,right: 12,top: 16.0),
                    child: Text(S.current.productQuantity,style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                  ),
                  CustomFormField(
                    controller: _quantityController,
                    hintText: S.current.productQuantity,
                    numbers: true,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 12.0,bottom: 8,right: 12,top: 16.0),
                    child: Text(S.current.discount,style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                  ),
                  CustomFormField(
                    controller: _discountController,
                    hintText: S.current.discount,
                    numbers: true,
                  ),

                  SizedBox(height:32),
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
                      checkedWidget:SizedBox(
                          height: 150,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.file(
                                File(imagePath ?? ''),
                                fit: BoxFit.cover,
                              ))),
                    ),
                  ),
                  SizedBox(height: 100,),
                ]),),
          ),
          label: S.current.save,
          onTap: () {
            if (_key.currentState!.validate() && imagePath != null ) {
              widget.addProduct(_nameController.text,imagePath!,int.parse(_priceController.text),double.parse(_discountController.text));
            } else {
              CustomFlushBarHelper.createError(
                  title: S.current.warnning,
                  message: S.current.pleaseCompleteTheForm)
                  .show(context);
            }
          }),
    );
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

class UpdateProductsForm extends StatefulWidget {
  final Function(String,String,String,String) addProduct;
  final UpdateProductRequest? request;
  UpdateProductsForm({required this.addProduct,this.request});
  @override
  _UpdateProductsFormState createState() => _UpdateProductsFormState();
}

class _UpdateProductsFormState extends State<UpdateProductsForm> {

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
 final TextEditingController _priceController = TextEditingController();
 final TextEditingController _discountController = TextEditingController();
  String? imagePath;
  final ImagePicker _imagePicker = ImagePicker();


  @override
  void initState() {
    if (widget.request != null){
      _nameController.text = widget.request?.productName ?? '';
      imagePath = widget.request?.productImage;
      _priceController.text = widget.request?.productPrice?.toString() ?? '0';
      _discountController.text = widget.request?.discount?.toString() ?? '0';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomMandopAppBar.appBar(context, title: S.current.updateProduct),
      body: StackedForm(
          child: Form(
            key: _key,
            child: FixedContainer(child: CustomListView.custom(
                padding: EdgeInsets.only(right: 16,left: 16),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0,bottom: 8,right: 12,top: 16.0),
                    child: Text(S.current.productName,style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                  ),
                  CustomFormField(
                    controller: _nameController,
                    hintText: S.current.productName,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0,bottom: 8,right: 12,top: 16.0),
                    child: Text(S.current.productPrice,style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                  ),
                  CustomFormField(
                    controller: _priceController,
                    hintText: S.current.productPrice,
                    numbers: true,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 12.0,bottom: 8,right: 12,top: 16.0),
                    child: Text(S.current.discount,style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                  ),
                  CustomFormField(
                    controller: _discountController,
                    hintText: S.current.discount,
                    numbers: true,
                  ),

                  SizedBox(height:32),
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
                      checkedWidget:SizedBox(
                          height: 150,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child:imagePath!.contains('http') == true ? Image.network(imagePath!) : Image.file(
                                File(imagePath ?? ''),
                                fit: BoxFit.cover,
                              ))),
                    ),
                  ),
                  SizedBox(height: 100,),
                ]),),
          ),
          label: S.current.save,
          onTap: () {
            if (_key.currentState!.validate() && imagePath != null) {
             if(imagePath!=null && imagePath!.contains('http')){
               imagePath = imagePath!.split('upload/').last;
             }
              widget.addProduct(_nameController.text,_priceController.text,imagePath!,_discountController.text);
            } else {
              CustomFlushBarHelper.createError(
                  title: S.current.warnning,
                  message: S.current.pleaseCompleteTheForm)
                  .show(context);
            }
          }),
    );
  }
}


