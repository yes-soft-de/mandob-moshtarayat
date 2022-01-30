import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/model/distro_payment_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/ui/screen/distros_payment_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/ui/widget/captain_payments.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/costom_search.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/error_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/fixed_container.dart';
import 'package:flutter/material.dart';

class DistrosPaymentsLoadedState extends States {
  final DistrosPaymentsScreenState screenState;
  final String? error;
  final bool empty;
  final List<DistroPaymentModel>? model;

  DistrosPaymentsLoadedState(this.screenState, this.model,
      {this.empty = false, this.error})
      : super(screenState) {
    if (error != null) {
      screenState.refresh();
    }
  }

  String? id;
  String? search;

  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getDistros();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getDistros();
          });
    }
    return FixedContainer(
        child: CustomListView.custom(children: getCaptains(context)));
  }

  List<Widget> getCaptains(BuildContext context) {
    List<Widget> widgets = [];
    for (var element in model ?? <DistroPaymentModel>[]) {
      if (!element.mandobName!.contains(search ?? '') && search != null) {
        continue;
      }

      widgets.add(DistroCardPayment(
        Id: element.id.toString(),
        mandobId: element.mandobID,
        image: element.image ?? '',
        remainingAmountForCaptain: element.remainingAmountForMandob ?? 0,
        captainName: element.mandobName ?? S.current.unknown,
      ));
    }

    if (model != null) {
      widgets.insert(
          0,
          Padding(
            padding: EdgeInsets.only(left: 18.0, right: 18.0, bottom: 16),
            child: CustomDeliverySearch(
              hintText: S.current.searchingForDistro,
              onChanged: (s) {
                if (s == '' || s.isEmpty) {
                  search = null;
                  screenState.refresh();
                } else {
                  search = s;
                  screenState.refresh();
                }
              },
            ),
          ));
    }

    return widgets;
  }
}
