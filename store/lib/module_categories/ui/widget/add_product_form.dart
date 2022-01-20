import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_categories/model/products_categories_model.dart';
import 'package:mandob_moshtarayat/module_categories/request/create_product_request.dart';
import 'package:mandob_moshtarayat/module_categories/request/update_product_request.dart';
import 'package:mandob_moshtarayat/module_categories/response/store_products_response.dart';
import 'package:mandob_moshtarayat/module_categories/service/store_categories_service.dart';
import 'package:mandob_moshtarayat/module_categories/ui/state/product_category/product_categories_loaded_state.dart';
import 'package:mandob_moshtarayat/module_categories/ui/state/product_category/product_categories_state.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/components/custom_feild.dart';
import 'package:mandob_moshtarayat/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat/utils/components/stacked_form.dart';
import 'package:mandob_moshtarayat/utils/effect/checked.dart';
import 'package:mandob_moshtarayat/utils/effect/hidder.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';

class AddProductsForm extends StatefulWidget {
  final Function(String, String, num, num, List<TranslateStoreProduct>)
      addProduct;
  final ProductCategoriesState? state;
  final List<String> languages;
  final String lang;

  AddProductsForm(
      {required this.addProduct,
      this.state,
      required this.languages,
      required this.lang});

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
  Uint8List? imageBytes;
  final ImagePicker _imagePicker = ImagePicker();

  late List<TranslateStoreProduct> translate;
  late List<CustomFormFieldWithTranslate> translateWidgets;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomMandopAppBar.appBar(context, title: S.current.addProducts),
      body: StackedForm(
          child: Form(
            key: _key,
            child: FixedContainer(
              child: CustomListView.custom(
                  padding: EdgeInsets.only(right: 16, left: 16),
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
                      padding: const EdgeInsets.only(
                          left: 12.0, bottom: 8, right: 12, top: 16.0),
                      child: Text(
                        S.current.productName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
//                  CustomFormField(
//                    controller: _nameController,
//                    hintText: S.current.productName,
//                  ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomFormFieldWithTranslate(
                            controller: _nameController,
                            hintText: S.current.productName,
                            last: false,
                            initLanguage: widget.lang,
                            languages: widget.languages,
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              if (_nameController.text.isEmpty) {
                                CustomFlushBarHelper.createError(
                                        title: S.current.warnning,
                                        message:
                                            S.current.pleaseCompleteTheForm)
                                    .show(context);
                              } else if (translateWidgets.length !=
                                  widget.languages.length) {
                                trans(true);
                              }
                            },
                            child: Icon(Icons.add))
                      ],
                    ),
                    Column(
                      children: trans(false),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, bottom: 8, right: 12, top: 16.0),
                      child: Text(
                        S.current.productPrice,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      controller: _priceController,
                      hintText: S.current.productPrice,
                      numbers: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, bottom: 8, right: 12, top: 16.0),
                      child: Text(
                        S.current.productQuantity,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      controller: _quantityController,
                      hintText: S.current.productQuantity,
                      numbers: true,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, bottom: 8, right: 12, top: 16.0),
                      child: Text(
                        S.current.discount,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      controller: _discountController,
                      hintText: S.current.discount,
                      numbers: true,
                    ),

                    SizedBox(height: 32),
                    InkWell(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: Checked(
                        child: Icon(
                          Icons.image,
                          size: 150,
                        ),
                        checked: imagePath != null && imageBytes != null,
                        checkedWidget: SizedBox(
                            height: 150,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.memory(
                                  imageBytes ?? Uint8List(0),
                                  fit: BoxFit.scaleDown,
                                ))),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ]),
            ),
          ),
          label: S.current.save,
          onTap: () {
            if (_key.currentState!.validate() && imagePath != null) {
              widget.addProduct(
                  _nameController.text,
                  imagePath!,
                  int.parse(_priceController.text),
                  double.parse(_discountController.text),
                  translate);
            } else {
              CustomFlushBarHelper.createError(
                      title: S.current.warnning,
                      message: S.current.pleaseCompleteTheForm)
                  .show(context);
            }
          }),
    );
  }

  @override
  void initState() {
    super.initState();
    translate = [];
    translateWidgets = [];
    print('run' + widget.lang);
  }

  void _openCamera() async {
    _imagePicker
        .getImage(source: ImageSource.camera, imageQuality: 70)
        .then((value) {
      if (value != null)
        setState(() {
          imagePath = value.path;
        });
    });
  }

  void _openGallery() async {
    _imagePicker
        .pickImage(source: ImageSource.gallery, imageQuality: 70)
        .then((value) async {
      if (value != null) {
        imagePath = value.path;
        imageBytes = await value.readAsBytes();
        setState(() {});
      }
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
        });
  }

  List<CustomFormFieldWithTranslate> trans(bool addNewField) {
    if (addNewField) {
      TranslateStoreProduct translateStoreCategory =
          TranslateStoreProduct(lang: widget.languages.first);
      TextEditingController _nameController = TextEditingController();
      late String language = '';

      translateWidgets.add(CustomFormFieldWithTranslate(
        initLanguage: widget.languages.first,
        onChanged: () {
          translateStoreCategory.productName = _nameController.text;
        },
        languages: widget.languages,
        controller: _nameController,
        onSelected: (lan) {
          language = lan;
          translateStoreCategory.lang = language;
        },
      ));
      setState(() {});
      translate.add(translateStoreCategory);
    }
    return translateWidgets;
  }
}

class UpdateProductsForm extends StatefulWidget {
  final Function(String, String, String, String, String) addProduct;
  final UpdateProductRequest  request;
  final CategoryLink categoryLink;
  final List<DropdownMenuItem<String>>? categoriesOne;
  final List<DropdownMenuItem<String>>? categoriesTwo;
  final CategoriesService? categoriesService;

  UpdateProductsForm({
    required this.addProduct,
   required this.request,
    this.categoriesOne,
    this.categoriesTwo,
   required this.categoryLink,
    required this.categoriesService,
  });
  @override
  _UpdateProductsFormState createState() => _UpdateProductsFormState();
}

class _UpdateProductsFormState extends State<UpdateProductsForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
// final TextEditingController _quantityController = TextEditingController();
  String? imagePath;
  final ImagePicker _imagePicker = ImagePicker();
  String? maincatId;
  String? subcatId;
  List<DropdownMenuItem<String>> categoriesTwoLocal = [];

  bool isUpdatedToMain = false;

  @override
  void initState() {
    if (widget.request != null) {
      categoriesTwoLocal = widget.categoriesTwo ?? [];
      _nameController.text =
          widget.request.dataStoreProduct.productName ?? '';
      imagePath = widget.request.dataStoreProduct.productImage;
      _priceController.text =
          widget.request.dataStoreProduct.productPrice?.toString() ?? '0';
      _discountController.text =
          widget.request.dataStoreProduct.discount?.toString() ?? '0';
      maincatId = widget.request.dataStoreProduct.isLevelOne ?? false
          ? widget.request.dataStoreProduct.storeProductCategoryID?.toString()
          : null;
      if(widget.request.dataStoreProduct.isLevelTwo){
        subcatId = widget.request.dataStoreProduct.isLevelTwo
            ? widget.request.dataStoreProduct.storeProductCategoryID?.toString()
            : null;
        print('haven');
        print(widget.categoryLink.subCategoryLevelOneID.toString());
        maincatId =  widget.categoryLink.subCategoryLevelOneID.toString();
      }


//      _quantityController.text =  widget.request?.dataStoreProduct?.productQuantity?.toString() ?? '0';
    }
    super.initState();
  }

  void _openCamera() async {
    _imagePicker
        .getImage(source: ImageSource.camera, imageQuality: 70)
        .then((value) {
      if (value != null)
        setState(() {
          imagePath = value.path;
        });
    });
  }

  void _openGallery() async {
    _imagePicker
        .getImage(source: ImageSource.gallery, imageQuality: 70)
        .then((value) {
      if (value != null)
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomMandopAppBar.appBar(context, title: S.current.updateProduct),
      body: StackedForm(
          child: Form(
            key: _key,
            child: FixedContainer(
              child: CustomListView.custom(
                  padding: EdgeInsets.only(right: 16, left: 16),
                  children: [
                    // categories one
                    Hider(
                      active: widget.categoriesOne != null &&
                          widget.categoriesOne!.length > 0,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Theme.of(context).backgroundColor),
                        child: Center(
                          child: DropdownButton(
                            value: maincatId,
                            items: widget.categoriesOne,
                            onChanged: (v) {
                              maincatId = v.toString();
                              isUpdatedToMain = true;
                              changeLocalCategory();
                              getCategoryLevelTwo(int.parse(maincatId ?? '0'));
                              setState(() {});
                            },
                            hint: Text(
                              S.current.chooseCategory,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            underline: SizedBox(),
                            icon: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(Icons.arrow_drop_down_rounded),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    //categories two
                    Hider(
                      active: categoriesTwoLocal.isNotEmpty,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Theme.of(context).backgroundColor),
                        child: Center(
                          child: DropdownButton(
                            value: subcatId,
                            items: categoriesTwoLocal,
                            onChanged: (v) {
                              isUpdatedToMain = false;
                              subcatId = v.toString();
                              setState(() {});
                            },
                            hint: Text(
                              S.current.chooseCategory,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            underline: SizedBox(),
                            icon: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(Icons.arrow_drop_down_rounded),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, bottom: 8, right: 12, top: 16.0),
                      child: Text(
                        S.current.productName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      controller: _nameController,
                      hintText: S.current.productName,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, bottom: 8, right: 12, top: 16.0),
                      child: Text(
                        S.current.productPrice,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      controller: _priceController,
                      hintText: S.current.productPrice,
                      numbers: true,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, bottom: 8, right: 12, top: 16.0),
                      child: Text(
                        S.current.discount,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      controller: _discountController,
                      hintText: S.current.discount,
                      numbers: true,
                    ),

//                  Padding(
//                    padding: const EdgeInsets.only(left: 12.0,bottom: 8,right: 12,top: 16.0),
//                    child: Text(S.current.productQuantity,style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
//                  ),
//                  CustomFormField(
//                    controller: _quantityController,
//                    hintText: S.current.productQuantity,
//                    numbers: true,
//                  ),
                    SizedBox(height: 32),
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
                                child: imagePath!.contains('http') == true
                                    ? Image.network(imagePath!)
                                    : Image.file(
                                        File(imagePath ?? ''),
                                        fit: BoxFit.cover,
                                      ))),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ]),
            ),
          ),
          label: S.current.save,
          onTap: () {
            if (_key.currentState!.validate() &&
                imagePath != null &&
                maincatId != null) {
              if (imagePath != null && imagePath!.contains('http')) {
                imagePath = imagePath!.split('upload/').last;
              }
              widget.addProduct(
                  _nameController.text,
                  _priceController.text,
                  imagePath!,
                  _discountController.text,
                  isUpdatedToMain ? maincatId! : subcatId ?? '-1');
            } else {
              CustomFlushBarHelper.createError(
                      title: S.current.warnning,
                      message: S.current.pleaseCompleteTheForm)
                  .show(context);
            }
          }),
    );
  }
changeLocalCategory(){
    subcatId = '';
    categoriesTwoLocal.clear();
  categoriesTwoLocal.add(DropdownMenuItem(
    value: '',
    child: Text(''),
  ));
}
  getCategoryLevelTwo(maincatId) async {
    widget.categoriesService!.getCategoryLevelTwo(maincatId).then((value) {
      if (value.hasError) {
        return ProductsCategoryModel(id: -1, categoryName: '');
      } else if (value.isEmpty) {
        return ProductsCategoryModel(id: -1, categoryName: '');
      } else {
        print('fuk');
        ProductsCategoryModel model = value as ProductsCategoryModel;
        print(model.data.length);
        getChoicesTwo(model.data);
      }
    });
  }

  List<DropdownMenuItem<String>> getChoicesTwo(
      List<ProductsCategoryModel> categoriesTwo) {
    categoriesTwoLocal.clear();
    categoriesTwoLocal.add(DropdownMenuItem(
      value: '',
      child: Text(''),
    ));
    categoriesTwo.forEach((element) {
      categoriesTwoLocal.add(DropdownMenuItem(
        value: element.id.toString(),
        child: Text(element.categoryName),
      ));
    });
    print("cat level two in side category");
    print(categoriesTwoLocal.length.toString());
    setState(() {
    });
    return categoriesTwoLocal;
  }
}
