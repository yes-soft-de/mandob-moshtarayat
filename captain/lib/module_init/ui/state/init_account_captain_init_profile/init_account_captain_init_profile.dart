import 'dart:io';
import 'package:mandob_moshtarayat_captain/generated/l10n.dart';
import 'package:mandob_moshtarayat_captain/module_init/request/create_captain_profile/create_captain_profile_request.dart';
import 'package:mandob_moshtarayat_captain/module_init/ui/screens/init_account_screen/init_account_screen.dart';
import 'package:mandob_moshtarayat_captain/module_init/ui/state/init_account/init_account.state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mandob_moshtarayat_captain/utils/components/custom_feild.dart';
import 'package:mandob_moshtarayat_captain/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_captain/utils/components/faded_button_bar.dart';

class InitAccountCaptainInitProfile extends InitAccountState {
  Uri? captainImage;
  Uri? driverLicence;
  Uri? mechanicLicence;
  Uri? identity;

  final _ageController = TextEditingController();
  final _carController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _bankAccountNumberController = TextEditingController();
  final _stcPayController = TextEditingController();

  InitAccountCaptainInitProfile(InitAccountScreenState screenState)
      : super(screenState);

  InitAccountCaptainInitProfile.withData(
      InitAccountScreenState screenState, CreateCaptainProfileRequest request)
      : super(screenState) {
    _ageController.text = request.age?.toString() ?? '';
    _carController.text = request.car ?? '';
    _phoneController.text = request.phone ?? '';
    _bankNameController.text = request.bankName ?? '';
    _bankAccountNumberController.text = request.bankAccountNumber ?? '';
    _stcPayController.text = request.stcPay ?? '';
    captainImage = this.captainImage;
    driverLicence = this.driverLicence;
    mechanicLicence = this.mechanicLicence;
    identity = this.identity;
  }

  final GlobalKey<FormState> _initKey = GlobalKey<FormState>();

  @override
  Widget getUI(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _initKey,
        child: Stack(
          children: [
            CustomListView.custom(
              children: [
                MediaQuery.of(context).viewInsets.bottom != 0
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            ImagePicker()
                                .getImage(source: ImageSource.gallery)
                                .then((value) {
                              if (value != null) {
                                captainImage = Uri(path: value.path);
                                screen.refresh();
                              }
                            });
                          },
                          child: Container(
                              height: 75,
                              width: 75,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                      child: Icon(Icons.person,
                                          size: 45, color: Colors.white)),
                                  _getCaptainImageFG(),
                                ],
                              )),
                        ),
                      ),
                Center(
                  child: Text(S.current.chooseCaptainProfile,
                      style: TextStyle(
                          color: Theme.of(context).disabledColor,
                          fontWeight: FontWeight.bold)),
                ),
                // phone
                Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
                      child: Text('${S.of(context).phoneNumber}'),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: CustomFormField(
                    controller: _phoneController,
                    hintText: '0500000000',
                    contentPadding: EdgeInsets.only(top: 15),
                    preIcon: Icon(Icons.phone),
                    numbers: true,
                    phone: true,
                  ),
                ),
                // age
                Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
                      child: Text('${S.of(context).age}'),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: CustomFormField(
                    controller: _ageController,
                    hintText: S.current.age,
                    contentPadding: EdgeInsets.only(top: 15),
                    preIcon: Icon(Icons.date_range_rounded),
                    numbers: true,
                  ),
                ),
                // car
                Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
                      child: Text('${S.of(context).car}'),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: CustomFormField(
                    controller: _carController,
                    hintText: S.current.car,
                    contentPadding: EdgeInsets.only(top: 15),
                    preIcon: Icon(Icons.local_taxi_rounded),
                  ),
                ),
                Container(
                  height: 24,
                ),
                // Identity
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Center(
                      child: Text(
                        S.of(context).identity,
                        style: TextStyle(fontWeight: FontWeight.w600),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ),
                _getIdentity(context),
                // Driver Licence
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Center(
                      child: Text(
                        S.of(context).driverLicence,
                        style: TextStyle(fontWeight: FontWeight.w600),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ),
                _getDriverLicenceFG(context),
                // Mechanic Licence
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Center(
                      child: Text(
                        S.of(context).mechanichLicence,
                        style: TextStyle(fontWeight: FontWeight.w600),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ),
                _getMechanicLicenceFG(context),
                Container(
                  height: 24,
                ),
                // Bank name
                Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
                      child: Text('${S.of(context).bankName}'),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: CustomFormField(
                    controller: _bankNameController,
                    hintText: S.current.bankName,
                    contentPadding: EdgeInsets.only(top: 15),
                    preIcon: Icon(Icons.monetization_on_rounded),
                  ),
                ),
                // Bank Account Number
                Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
                      child: Text('${S.of(context).bankAccountNumber}'),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: CustomFormField(
                    controller: _bankAccountNumberController,
                    hintText: '0000000000',
                    contentPadding: EdgeInsets.only(top: 15),
                    preIcon: Icon(Icons.password_rounded),
                    numbers: true,
                  ),
                ),
                // Stc Pay
                Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
                      child: Text('${S.of(context).stcPayCode}'),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: CustomFormField(
                    controller: _stcPayController,
                    hintText: 'XXXXXXXX',
                    contentPadding: EdgeInsets.only(top: 15),
                    preIcon: Icon(Icons.credit_card_rounded),
                    last: true,
                  ),
                ),
                Container(
                  height: 100,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FadedButtonBar(
                text: S.of(context).uploadAndSubmit,
                onPressed: driverLicence == null ||
                        captainImage == null ||
                        mechanicLicence == null ||
                        identity == null
                    ? null
                    : () {
                        if (_initKey.currentState!.validate()) {
                          screen.submitProfile(
                              CreateCaptainProfileRequest.withUriImages(
                                  age: int.parse(_ageController.text),
                                  car: _carController.text,
                                  captainImage: captainImage,
                                  driving: driverLicence,
                                  mechanic: mechanicLicence,
                                  idImage: identity,
                                  phone: _phoneController.text,
                                  bankAccountNumber:
                                      _bankAccountNumberController.text,
                                  bankName: _bankNameController.text,
                                  stcPay: _stcPayController.text));
                        }
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getDriverLicenceFG(BuildContext context) {
    if (driverLicence != null) {
      return Padding(
        padding:
            const EdgeInsets.only(top: 8.0, left: 16, right: 16, bottom: 8.0),
        child: Container(
          height: 150,
          child: GestureDetector(
            onTap: () {
              ImagePicker().getImage(source: ImageSource.gallery).then((value) {
                if (value != null) {
                  driverLicence = Uri(path: value.path);
                  screen.refresh();
                }
              });
            },
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: FileImage(File(driverLicence!.path)),
                            fit: BoxFit.cover)),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, left: 16, right: 16, bottom: 8.0),
      child: GestureDetector(
        onTap: () {
          ImagePicker().getImage(source: ImageSource.gallery).then((value) {
            if (value != null) {
              driverLicence = Uri(path: value.path);
              screen.refresh();
            }
          });
        },
        child: Container(
          height: 150,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey[900]
                          : Color.fromRGBO(236, 239, 241, 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.camera,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getMechanicLicenceFG(BuildContext context) {
    if (mechanicLicence != null) {
      return Padding(
        padding:
            const EdgeInsets.only(top: 8.0, left: 16, right: 16, bottom: 8.0),
        child: Container(
          height: 150,
          child: GestureDetector(
            onTap: () {
              ImagePicker().getImage(source: ImageSource.gallery).then((value) {
                if (value != null) {
                  mechanicLicence = Uri(path: value.path);
                  screen.refresh();
                }
              });
            },
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: FileImage(File(mechanicLicence!.path)),
                            fit: BoxFit.cover)),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, left: 16, right: 16, bottom: 8.0),
      child: GestureDetector(
        onTap: () {
          ImagePicker().getImage(source: ImageSource.gallery).then((value) {
            if (value != null) {
              mechanicLicence = Uri(path: value.path);
              screen.refresh();
            }
          });
        },
        child: Container(
          height: 150,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.camera,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getIdentity(BuildContext context) {
    if (identity != null) {
      return Padding(
        padding:
            const EdgeInsets.only(top: 8.0, left: 16, right: 16, bottom: 8.0),
        child: Container(
          height: 150,
          child: GestureDetector(
            onTap: () {
              ImagePicker().getImage(source: ImageSource.gallery).then((value) {
                if (value != null) {
                  identity = Uri(path: value.path);
                  screen.refresh();
                }
              });
            },
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: FileImage(File(identity!.path)),
                            fit: BoxFit.cover)),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, left: 16, right: 16, bottom: 8.0),
      child: GestureDetector(
        onTap: () {
          ImagePicker().getImage(source: ImageSource.gallery).then((value) {
            if (value != null) {
              identity = Uri(path: value.path);
              screen.refresh();
            }
          });
        },
        child: Container(
          height: 150,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.camera,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getCaptainImageFG() {
    if (captainImage != null) {
      return Container(
          decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: FileImage(File.fromUri(captainImage!)),
          fit: BoxFit.cover,
        ),
      ));
    } else {
      return Container();
    }
  }
}
