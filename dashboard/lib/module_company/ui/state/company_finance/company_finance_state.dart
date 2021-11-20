import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/model/company_finance_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/model/company_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/model/company_price.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/request/create_company_profile.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/request/delivery_company_financial.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/request/financial_compensation_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/ui/screen/company_finance_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/ui/screen/company_profile_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_feild.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/error_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/stacked_form.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/custom_flushbar.dart';

class CompanyFinanceLoadedState extends States {
  final CompanyFinanceScreenState screenState;
  final List<String>? errors;
  final String? error;
  final bool empty;
  final CompanyDeliveryPriceModel? model;
  final CompanyFinanceModel? financeModel;
  CompanyFinanceLoadedState(this.screenState,
      {this.financeModel,
      required this.model,
      this.empty = false,
      this.error,
      this.errors})
      : super(screenState) {
    if (error != null) {
      screenState.refresh();
      CustomFlushBarHelper.createError(
          title: S.current.warnning, message: error ?? '');
    }
    if (errors != null) {
      screenState.refresh();
    }
    if (financeModel != null) {
      kilometerController.text = financeModel?.kilometers.toString() ?? '';
      maxKilometerBonusController.text =
          financeModel?.maxKilometerBonus.toString() ?? '';
      minKilometerBonusController.text =
          financeModel?.minKilometerBonus.toString() ?? '';
      screenState.refresh();
    }
    if (model != null) {
      deliveryCostController.text = model?.deliveryPrice.toString() ?? '';
      screenState.refresh();
    }
  }

  String? id;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  var kilometerController = TextEditingController();
  var minKilometerBonusController = TextEditingController();
  var maxKilometerBonusController = TextEditingController();
  var deliveryCostController = TextEditingController();

  @override
  Widget getUI(BuildContext context) {
    if (errors != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getFinance();
        },
        errors: errors,
      );
    }
    return StackedForm(
        child: Form(
          key: _key,
          child: FixedContainer(
              child: CustomListView.custom(
                  padding: EdgeInsets.only(right: 16, left: 16),
                  children: [
                // delivery price
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, bottom: 8, right: 12, top: 16.0),
                  child: Text(
                    S.current.deliverPrice,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                CustomFormField(
                  numbers: true,
                  controller: deliveryCostController,
                  hintText: S.current.deliverPrice,
                ),
                // kilometer
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, bottom: 8, right: 12, top: 16.0),
                  child: Text(
                    S.current.kilometerLimt,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                CustomFormField(
                  controller: kilometerController,
                  hintText: S.current.kilometerLimt,
                  numbers: true,
                ),
                // max kilo
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, bottom: 8, right: 12, top: 16.0),
                  child: Text(
                    S.current.kilometerLimtMax,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                CustomFormField(
                  numbers: true,
                  controller: maxKilometerBonusController,
                  hintText: S.current.kilometerLimtMax,
                ),
                // min kilo
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, bottom: 8, right: 12, top: 16.0),
                  child: Text(
                    S.current.kilometerLimtMin,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                CustomFormField(
                  numbers: true,
                  controller: minKilometerBonusController,
                  hintText: S.current.kilometerLimtMin,
                  last: true,
                ),
                SizedBox(
                  height: 100,
                ),
              ])),
        ),
        label: S.current.update,
        onTap: () {
          if (_key.currentState!.validate()) {
            screenState.updateFinancial(
              FinancialCompensationRequest(
                id: financeModel?.id,
                kilometers: int.parse(kilometerController.text.trim()),
                maxKilometerBonus:
                    double.parse(maxKilometerBonusController.text.trim()),
                minKilometerBonus:
                    double.parse(minKilometerBonusController.text.trim()),
              ),
              DeliveryCompanyFinancialRequest(
                id: model?.id,
                deliveryCost: deliveryCostController.text.trim(),
              ),
            );
          } else {
            CustomFlushBarHelper.createError(
                    title: S.current.warnning,
                    message: S.current.pleaseCompleteTheForm)
                .show(context);
          }
        });
  }
}
