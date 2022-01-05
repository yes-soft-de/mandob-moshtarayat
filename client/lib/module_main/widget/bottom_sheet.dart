import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/utils/components/custom_feild.dart';
import 'package:mandob_moshtarayat/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat/utils/effect/checked.dart';

class OuterOrderBottomSheet extends StatefulWidget {
  final Function(String, String, String?) callback;
  const OuterOrderBottomSheet({required this.callback}) : super();

  @override
  _OuterOrderBottomSheetState createState() => _OuterOrderBottomSheetState();
}

class _OuterOrderBottomSheetState extends State<OuterOrderBottomSheet> {
  var productNameController = TextEditingController();
  var detailsController = TextEditingController();
  String? imagePath;
  final GlobalKey<FormState> _orderKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextStyle hintStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: Theme.of(context).disabledColor,
      fontSize: 14,
    );
    return FixedContainer(
      child: SingleChildScrollView(
        physics:
            const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Container(
          constraints: const BoxConstraints(minHeight: 400, maxHeight: 475),
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(25)),
          child: Center(
            child: Form(
              key: _orderKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // title
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 16.0, left: 16, bottom: 16),
                    child: Center(
                      child: Text(
                        S.current.enterProductInfo,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                  ),
                  // product Name
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                    child: CustomFormField(
                      hintText: S.current.productName,
                      controller: productNameController,
                      hintStyle: hintStyle,
                    ),
                  ),
                  // Extra Info
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
                    child: CustomFormField(
                      hintText: S.current.extraDetails,
                      controller: detailsController,
                      maxLines: 3,
                      hintStyle: hintStyle,
                    ),
                  ),
                  // upload image
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 16.0, left: 16, bottom: 8),
                    child: Text(
                      S.current.uploadImageIfyouHave,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 16),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () {
                        ImagePicker.platform
                            .pickImage(source: ImageSource.gallery)
                            .then((value) {
                          imagePath = value?.path;
                          setState(() {});
                        });
                      },
                      child: SizedBox(
                        width: 70,
                        height: 70,
                        child: Checked(
                            checked: imagePath != null,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: Theme.of(context).backgroundColor),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.cloud_upload_sharp,
                                    color: Theme.of(context).disabledColor,
                                  ),
                                  Text(
                                    S.current.pressHere,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).disabledColor),
                                  ),
                                ],
                              ),
                            ),
                            checkedWidget: ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: Image.file(
                                  File(imagePath ?? ''),
                                  fit: BoxFit.cover,
                                ))),
                      ),
                    ),
                  ), // send
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        )),
                        onPressed: () {
                          if (_orderKey.currentState?.validate() == true) {
                            widget.callback(productNameController.text,
                                detailsController.text, imagePath);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            S.current.send,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
