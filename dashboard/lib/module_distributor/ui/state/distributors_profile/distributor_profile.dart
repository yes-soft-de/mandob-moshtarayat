import 'package:flutter/material.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/request/accept_captain_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/ui/screen/captain_profile_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/ui/widget/captain_profile/custom_captain_profile_tile.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/ui/widget/captain_profile/image_tile.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/ui/widget/update_profile_widget.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/model/profile_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/request/accept_distro_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/ui/screen/distros_profile_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/error_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/progresive_image.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/stacked_form.dart';
import 'package:mandob_moshtarayat_dashboad/utils/global/screen_type.dart';

class DistributorProfileLoadedState extends States {
  final DistributorProfileScreenState screenState;
  final String? error;
  final bool empty;
  final ProfileModel? model;

  DistributorProfileLoadedState(this.screenState, this.model,
      {this.empty = false, this.error})
      : super(screenState) {
    if (error != null) {
      screenState.refresh();
    }
  }
  @override
  Widget getUI(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getCaptain();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getCaptain();
          });
    }
    return FixedContainer(
      child: CustomListView.custom(
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
                  CustomListTile(
                      title: S.of(context).name,
                      subTitle: model?.name,
                      iconData: Icons.person_rounded),
                  CustomListTile(
                      title: S.of(context).age,
                      subTitle: model?.age?.toString(),
                      iconData: Icons.calendar_today_rounded),
                  CustomListTile(
                      title: S.of(context).phoneNumber,
                      subTitle: model?.phone,
                      iconData: Icons.phone),


                  CustomListTile(
                      title: S.of(context).bankName,
                      subTitle: model?.bankName,
                      iconData: Icons.comment_bank),
                  CustomListTile(
                      title: S.of(context).bankAccountNumber,
                      subTitle: model?.bankNumber,
                      iconData: Icons.comment_bank),
                  CustomListTile(
                      title: S.of(context).stcPayCode,
                      subTitle: model?.stcPay,
                      iconData: Icons.comment_bank),

                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: ListTileSwitch(
                        switchActiveColor: Colors.green,
                        switchInactiveColor: Colors.red,
                        leading: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.account_box_rounded, color: Theme.of(context).primaryColor),
                            )),
                        title: Text(S.of(context).representativeStatus,   style: TextStyle(color: Colors.white),),
                        subtitle:  Text(model?.status =='active'
                            ? S.current.captainStateActive
                            : S.current.captainStateInactive,   style: TextStyle(color: Colors.white),),

                        value: model?.status == 'active',
                        onChanged: (v) {
                          if (v) {
                            model?.status = 'active';
                            screenState.enableDistro(AcceptDistroRequest(distroID: screenState.Id.toString() ,status:model?.status ));
                          } else {
                            model?.status = 'inActive';
                            screenState.enableDistro(AcceptDistroRequest(distroID: screenState.Id.toString() ,status:model?.status ));
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),

          Container(
            height: 75,
          )
        ],
      ),
    );
  }
}
