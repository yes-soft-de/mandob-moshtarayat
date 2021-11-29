import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/model/porfile_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/request/accept_captain_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/ui/screen/captain_profile_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/ui/widget/captain_profile/custom_captain_profile_tile.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/ui/widget/captain_profile/image_tile.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/ui/widget/update_profile_widget.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/error_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/progresive_image.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/stacked_form.dart';
import 'package:mandob_moshtarayat_dashboad/utils/global/screen_type.dart';

class CaptainProfileLoadedState extends States {
  final CaptainProfileScreenState screenState;
  final String? error;
  final bool empty;
  final ProfileModel? model;

  CaptainProfileLoadedState(this.screenState, this.model,
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
    return StackedForm(
        child: FixedContainer(
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
                          title: S.of(context).car,
                          subTitle: model?.car,
                          iconData: Icons.local_taxi_rounded),
                      CustomListTile(
                          title: S.of(context).createDate,
                          subTitle: model?.createDate,
                          iconData: Icons.timer_rounded),
                      CustomListTile(
                          title: S.of(context).status,
                          subTitle: model?.isOnline,
                          iconData: Icons.wifi_rounded),
                      CustomListTile(
                          title: S.of(context).captainStatus,
                          subTitle: model?.status,
                          iconData: Icons.account_box_rounded),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Theme.of(context).primaryColor),
                  child: Flex(
                    direction:
                        ScreenType.isMobile() ? Axis.vertical : Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ImageTile(
                          title: S.current.identity,
                          image: model?.identity ?? ''),
                      ImageTile(
                          title: S.current.mechanichLicence,
                          image: model?.mechanicLicense ?? ''),
                      ImageTile(
                          title: S.current.driverLicence,
                          image: model?.drivingLicence ?? ''),
                    ],
                  ),
                ),
              ),
              Container(
                height: 75,
              )
            ],
          ),
        ),
        label: S.current.updateProfile,
        onTap: () {
          showDialog(
              context: context,
              builder: (_) {
                return Scaffold(
                  appBar: CustomTwaslnaAppBar.appBar(context,
                      title: S.current.updateProfile),
                  body: UpdateProfile(
                    updateProfile: (salary, bounce, status) {
                      Navigator.of(context).pop();
                      screenState.enableCaptain(AcceptCaptainRequest(
                          bounce:
                              double.tryParse(bounce.isEmpty ? '0' : bounce),
                          salary: double.parse(salary),
                          captainID: screenState.captainId.toString(),
                          status: status));
                    },
                    salary: model?.salary.toString(),
                    bounce: model?.bounce.toString(),
                    status: model?.status,
                  ),
                );
              });
        });
  }
}
