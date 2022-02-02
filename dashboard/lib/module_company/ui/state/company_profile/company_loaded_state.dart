import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/model/company_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/request/create_company_profile.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/ui/screen/company_profile_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_feild.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/error_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/stacked_form.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/custom_flushbar.dart';

class CompanyLoadedState extends States {
  final CompanyProfileScreenState screenState;
  final String? error;
  final bool empty;
  final CompanyProfileModel? model;

  CompanyLoadedState(this.screenState, this.model,
      {this.empty = false, this.error})
      : super(screenState) {
    if (error != null) {
      screenState.canAddCategories = false;
      screenState.refresh();
    }
    if (model != null) {
      phoneController.text = model?.phone ?? '';
      phone2Controller.text = model?.phone2 ?? '';
      whatsappController.text = model?.whatsapp ?? '';
      faxController.text = model?.fax ?? '';
      emailController.text = model?.email ?? '';
      stcController.text = model?.stc ?? '';
      bankController.text = model?.bank ?? '';
      screenState.refresh();
    }
  }

  String? id;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  var phoneController = TextEditingController();
  var phone2Controller = TextEditingController();
  var whatsappController = TextEditingController();
  var faxController = TextEditingController();
  var emailController = TextEditingController();
  var stcController = TextEditingController();
  var bankController = TextEditingController();

  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getCompanyProfile();
        },
        error: error,
      );
    }
    print(model?.whatsapp);
    return StackedForm(
        child: Form(
          key: _key,
          child: FixedContainer(
              child: CustomListView.custom(
                  padding: EdgeInsets.only(right: 16, left: 16),
                  children: [
                // phone
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, bottom: 8, right: 12, top: 16.0),
                  child: Text(
                    S.current.phone,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                CustomFormField(
                  controller: phoneController,
                  hintText: S.current.phoneNumber,
                ),
                // phone2
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, bottom: 8, right: 12, top: 16.0),
                  child: Text(
                    S.current.phone2,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                CustomFormField(
                  controller: phone2Controller,
                  hintText: S.current.phoneNumber,
                ),
                // whatsapp
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, bottom: 8, right: 12, top: 16.0),
                  child: Text(
                    S.current.whatsapp,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                CustomFormField(
                  controller: whatsappController,
                  hintText: S.current.whatsapp,
                  numbers: true,
                  phone: true,
                ),
                // fax
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, bottom: 8, right: 12, top: 16.0),
                  child: Text(
                    S.current.fax,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                CustomFormField(
                  controller: faxController,
                  hintText: S.current.fax,
                ),
                // bank
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
                  controller: bankController,
                  hintText: S.current.bankName,
                ),
                // stc
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, bottom: 8, right: 12, top: 16.0),
                  child: Text(
                    S.current.stcPayCode,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                CustomFormField(
                  controller: stcController,
                  hintText: S.current.stcPayCode,
                ),
                // email
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, bottom: 8, right: 12, top: 16.0),
                  child: Text(
                    S.current.email,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                CustomFormField(
                  controller: emailController,
                  hintText: S.current.email,
                ),
                SizedBox(
                  height: 100,
                ),
              ])),
        ),
        label: S.current.update,
        onTap: () {
          if (_key.currentState!.validate()) {
            if (empty || error != null) {
              screenState.createProfile(CreateCompanyProfile(
                phone: phoneController.text.trim(),
                phone2: phone2Controller.text.trim(),
                whatsapp: whatsappController.text.trim(),
                fax: faxController.text.trim(),
                bank: bankController.text.trim(),
                stc: stcController.text.trim(),
                email: emailController.text.trim(),
              ));
            } else {
              screenState.updateProfile(CreateCompanyProfile(
                phone: phoneController.text.trim(),
                phone2: phone2Controller.text.trim(),
                whatsapp: whatsappController.text.trim(),
                fax: faxController.text.trim(),
                bank: bankController.text.trim(),
                stc: stcController.text.trim(),
                email: emailController.text.trim(),
              ));
            }
          } else {
            CustomFlushBarHelper.createError(
                    title: S.current.warnning,
                    message: S.current.pleaseCompleteTheForm)
                .show(context);
          }
        });
  }
}
