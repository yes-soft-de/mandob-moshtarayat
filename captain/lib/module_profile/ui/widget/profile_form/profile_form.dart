import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mandob_moshtarayat_captain/consts/urls.dart';
import 'package:mandob_moshtarayat_captain/generated/l10n.dart';
import 'dart:io';

import 'package:mandob_moshtarayat_captain/module_profile/model/profile_model/profile_model.dart';
import 'package:mandob_moshtarayat_captain/module_profile/request/profile/profile_request.dart';
import 'package:mandob_moshtarayat_captain/utils/components/custom_feild.dart';
import 'package:mandob_moshtarayat_captain/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_captain/utils/components/stacked_form.dart';
import 'package:mandob_moshtarayat_captain/utils/helpers/custom_flushbar.dart';
import 'package:mandob_moshtarayat_captain/utils/images/images.dart';

class ProfileFormWidget extends StatefulWidget {
  final Function(ProfileModel) onProfileSaved;
  final Function(ProfileModel, String?, String?) onImageUpload;
  final ProfileRequest? profileRequest;

  @override
  _ProfileFormWidgetState createState() => _ProfileFormWidgetState();

  ProfileFormWidget({
    required this.onProfileSaved,
    required this.onImageUpload,
    this.profileRequest,
  });
}

class _ProfileFormWidgetState extends State<ProfileFormWidget> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _carController = TextEditingController();
  final _stcPayController = TextEditingController();
  final _bankAccountNumberController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _ageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String countryCode = '+966';
  String imageAvatar = '';
  String? captainState;

  @override
  void initState() {
    super.initState();
    if (widget.profileRequest == null) {
    } else {
      _nameController.text = widget.profileRequest?.name ?? '';
      imageAvatar = widget.profileRequest?.name ?? '';
      if (widget.profileRequest?.phone != null) {
        countryCode = widget.profileRequest!.phone!.contains('+')
            ? widget.profileRequest!.phone!.substring(0, 4)
            : '+966';
        _phoneController.text =
            widget.profileRequest!.phone!.replaceFirst(countryCode, '0');
      }

      _stcPayController.text = widget.profileRequest?.stcPay ?? '';
      _bankAccountNumberController.text =
          widget.profileRequest?.bankAccountNumber ?? '';
      _bankNameController.text = widget.profileRequest?.bankName ?? '';
      _carController.text = widget.profileRequest?.car ?? '';
      captainState = widget.profileRequest?.isOnline;
      _ageController.text = widget.profileRequest?.age ?? '';
    }
  }

  ProfileModel? profile;

  Widget titleField(String title) {
    return Align(
        alignment: AlignmentDirectional.bottomStart,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
          child: Text(title),
        ));
  }

  Widget addIcon() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
          alignment: AlignmentDirectional.bottomStart,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.add_a_photo_rounded,
                color: Colors.white,
              ),
            ),
          )),
    );
  }

  Widget imageProfileProvider(
      {required ProfileRequest request,
      required String image,
      required String imageType}) {
    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            bottom: 8.0,
          ),
          child: Container(
              width: double.maxFinite,
              height: 45,
              child: Center(
                  child: Text(
                imageType,
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
        ),
        GestureDetector(
          onTap: () {
            ImagePicker()
                .getImage(source: ImageSource.gallery, imageQuality: 70)
                .then((value) {
              if (value != null) {
                profile = ProfileModel(
                    image: request.image,
                    drivingLicence: request.drivingLicence,
                    mechanicLicense: request.mechanicLicense,
                    identity: request.identity,
                    car: _carController.text,
                    age: int.parse(_ageController.text),
                    name: _nameController.text,
                    phone: _phoneController.text,
                    stcPay: _stcPayController.text,
                    bankNumber: _bankAccountNumberController.text,
                    bankName: _bankNameController.text,
                    isOnline: captainState);
                if (S.current.identity == imageType) {
                  profile?.identity = value.path;
                  widget.onImageUpload(profile!, 'identity', value.path);
                } else if (S.current.mechanichLicence == imageType) {
                  profile?.mechanicLicense = value.path;
                  widget.onImageUpload(profile!, 'mechanic', value.path);
                } else {
                  profile?.drivingLicence = value.path;
                  widget.onImageUpload(profile!, 'driving', value.path);
                }
              }
            });
          },
          child: Container(
            height: 150,
            width: double.maxFinite,
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage.assetNetwork(
                      placeholder: ImageAsset.PLACEHOLDER,
                      image: '${image}'.contains('http')
                          ? '${image}'
                          : '${Urls.IMAGES_ROOT}${image}',
                      fit: BoxFit.cover,
                      height: 150,
                      width: double.maxFinite,
                      imageErrorBuilder: (e, s, h) {
                        return Image.asset(
                          ImageAsset.PLACEHOLDER,
                          fit: BoxFit.cover,
                          height: 150,
                          width: double.maxFinite,
                        );
                      },
                    ),
                  ),
                ),
                addIcon()
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: StackedForm(
        label: S.current.save,
        onTap: () {
          if (captainState == null) {
            CustomFlushBarHelper.createError(
                    title: S.current.warnning,
                    message: S.current.chooseYourState)
                .show(context);
          } else if (_formKey.currentState!.validate()) {
            String phone = _phoneController.text;
            if (phone[0] == '0') {
              phone = phone.substring(1);
            }
            var profile = ProfileModel(
                image: widget.profileRequest?.image,
                name: _nameController.text,
                phone: countryCode + phone,
                stcPay: _stcPayController.text,
                bankName: _bankNameController.text,
                bankNumber: _bankAccountNumberController.text,
                car: _carController.text,
                age: int.parse(_ageController.text),
                mechanicLicense: widget.profileRequest?.mechanicLicense,
                drivingLicence: widget.profileRequest?.drivingLicence,
                identity: widget.profileRequest?.identity,
                isOnline: captainState);
            widget.onProfileSaved(profile);
          } else {
            CustomFlushBarHelper.createError(
                    title: S.current.warnning,
                    message: S.current.pleaseCompleteTheForm)
                .show(context);
          }
        },
        child: CustomListView.custom(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 8.0, left: 8.0, top: 16, bottom: 16),
              child: GestureDetector(
                onTap: () {
                  ImagePicker()
                      .getImage(source: ImageSource.gallery, imageQuality: 70)
                      .then((value) {
                    if (value != null) {
                      profile = ProfileModel(
                          image: value.path,
                          name: _nameController.text,
                          phone: _phoneController.text,
                          stcPay: _stcPayController.text,
                          bankName: _bankNameController.text,
                          bankNumber: _bankAccountNumberController.text,
                          car: _carController.text,
                          age: int.parse(_ageController.text),
                          mechanicLicense:
                              widget.profileRequest?.mechanicLicense,
                          drivingLicence: widget.profileRequest?.drivingLicence,
                          identity: widget.profileRequest?.identity,
                          isOnline: captainState);
                      widget.onImageUpload(profile!, null, null);
                    }
                  });
                },
                child: Container(
                  height: 200,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                            child: Text(
                          '${imageAvatar.isNotEmpty ? imageAvatar[0].toUpperCase() : '?'}',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 50),
                          textScaleFactor: 1,
                        )),
                      ),
                      widget.profileRequest == null
                          ? Container()
                          : widget.profileRequest?.image == null
                              ? Container()
                              : Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(widget
                                                .profileRequest!.image!
                                                .contains('http')
                                            ? widget.profileRequest!.image!
                                            : Urls.IMAGES_ROOT +
                                                widget.profileRequest!.image!),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: AlignmentDirectional.bottomStart,
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).primaryColor),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.add_a_photo_rounded,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            titleField(S.of(context).name),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: CustomFormField(
                controller: _nameController,
                hintText: S.current.nameHint,
                contentPadding: EdgeInsets.only(top: 15),
                preIcon: Icon(Icons.person),
              ),
            ),
            titleField(S.of(context).phoneNumber),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: CustomFormField(
                controller: _phoneController,
                hintText: '050000000',
                contentPadding: EdgeInsets.only(top: 15),
                preIcon: Icon(Icons.phone),
                phone: true,
                numbers: true,
              ),
            ),
            titleField(S.of(context).age),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: CustomFormField(
                controller: _ageController,
                hintText: S.current.age,
                contentPadding: EdgeInsets.only(top: 15),
                preIcon: Icon(Icons.date_range_rounded),
                numbers: true,
              ),
            ),
            titleField(S.of(context).car),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: CustomFormField(
                controller: _carController,
                hintText: S.current.car,
                contentPadding: EdgeInsets.only(top: 15),
                preIcon: Icon(Icons.local_taxi_rounded),
              ),
            ),
            titleField(S.of(context).bankName),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: CustomFormField(
                controller: _bankNameController,
                hintText: S.current.bankName,
                contentPadding: EdgeInsets.only(top: 15),
                preIcon: Icon(Icons.monetization_on_rounded),
              ),
            ),
            titleField(S.of(context).bankAccountNumber),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: CustomFormField(
                controller: _bankAccountNumberController,
                hintText: '123456789',
                contentPadding: EdgeInsets.only(top: 15),
                preIcon: Icon(Icons.password_rounded),
                numbers: true,
              ),
            ),
            titleField(S.of(context).stcPayCode),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: CustomFormField(
                controller: _stcPayController,
                hintText: 'XXXXXXXX',
                contentPadding: EdgeInsets.only(top: 15),
                preIcon: Icon(Icons.credit_card_rounded),
                last: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
              child: ListTile(
                tileColor: captainState != null
                    ? (captainState == 'active' ? Colors.green : Colors.red)
                    : Theme.of(context).backgroundColor,
                leading: Icon(
                  Icons.wifi_rounded,
                  color: captainState != null ? Colors.white : null,
                ),
                title: Text(S.of(context).myStatus,
                    style: TextStyle(
                      color: captainState != null ? Colors.white : null,
                    )),
                trailing: DropdownButton(
                    value: captainState,
                    hint: captainState == null
                        ? Text(S.current.chooseYourState)
                        : null,
                    underline: Container(),
                    dropdownColor: captainState != null
                        ? (captainState == 'active' ? Colors.green : Colors.red)
                        : Theme.of(context).backgroundColor,
                    icon: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.arrow_drop_down_rounded,
                        color: captainState != null ? Colors.white : null,
                      ),
                    ),
                    items: [
                      DropdownMenuItem(
                        child: Text(
                          S.current.captainStateActive,
                          style: TextStyle(
                            color: captainState != null ? Colors.white : null,
                          ),
                        ),
                        value: 'active',
                      ),
                      DropdownMenuItem(
                        child: Text(
                          S.current.captainStateInactive,
                          style: TextStyle(
                            color: captainState != null ? Colors.white : null,
                          ),
                        ),
                        value: 'inactive',
                      ),
                    ],
                    onChanged: (newState) {
                      captainState = newState.toString();
                      setState(() {});
                    }),
              ),
            ),
            _getCaptainMoreData(
                context, widget.profileRequest ?? ProfileRequest.empty()),
            Container(
              height: 75,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getCaptainMoreData(BuildContext context, ProfileRequest request) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8, right: 8, left: 8),
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          imageProfileProvider(
            request: request,
            image: request.identity ?? '',
            imageType: S.current.identity,
          ),
          imageProfileProvider(
            request: request,
            image: request.drivingLicence ?? '',
            imageType: S.current.driverLicence,
          ),
          imageProfileProvider(
            request: request,
            image: request.mechanicLicense ?? '',
            imageType: S.current.mechanichLicence,
          ),
        ],
      ),
    );
  }
}
