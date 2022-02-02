import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/model/porfile_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/ui/screen/clients_profile_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/ui/widget/client_profile/client_custom_tile.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/error_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/progresive_image.dart';

class ClientProfileLoadedState extends States {
  final ClientProfileScreenState screenState;
  final String? error;
  final bool empty;
  final ClientProfileModel? model;

  ClientProfileLoadedState(this.screenState, this.model,
      {this.empty = false, this.error})
      : super(screenState) {
    if (error != null) {
      screenState.refresh();
    }
  }
  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getClientProfile();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getClientProfile();
          });
    }
    return CustomListView.custom(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 175,
            height: 175,
            child: Center(
              child: ClipOval(
                //   borderRadius: BorderRadius.circular(25),
                child: Container(
                  width: 175,
                  height: 175,
                  child: CustomNetworkImage(
                    imageSource: model?.image ?? '',
                    width: double.maxFinite,
                    height: double.maxFinite,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Theme.of(context).primaryColor),
            child: Column(
              children: [
                ClientCustomListTile(
                    title: S.of(context).name,
                    subTitle: model?.name,
                    iconData: Icons.person_rounded),
                ClientCustomListTile(
                    title: S.of(context).phoneNumber,
                    subTitle: model?.phone,
                    iconData: Icons.phone),
                ClientCustomListTile(
                    title: S.of(context).nationalAddress,
                    subTitle: model?.nationalAddress,
                    iconData: Icons.location_on),
                ClientCustomListTile(
                    title: S.of(context).taxNumber,
                    subTitle: model?.taxNumber,
                    iconData: Icons.money),
                ClientCustomListTile(
                    title: S.of(context).recordNumber,
                    subTitle: model?.recordNumber,
                    iconData: Icons.recent_actors),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.current.orders,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        model?.statistics?.clientOrdersCount.toString() ??
                            S.current.unknown,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.current.countOrdersDelivered,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        model?.statistics?.clientOrdersDelivered.toString() ??
                            S.current.unknown,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.current.ordersCancel,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        model?.statistics?.clientOrdersCancel.toString() ??
                            S.current.unknown,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 75,
        )
      ],
    );
  }
}
